#!/usr/bin/env bash

set -euo pipefail

DB_PATH="${1:-/var/lib/jellyfin/data/jellyfin.db}"
BACKUP_DIR="$(dirname "$DB_PATH")"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP_DB="${BACKUP_DIR}/jellyfin.db.bak_${TIMESTAMP}"
BACKUP_JSON="${BACKUP_DIR}/corrupt_userdata_${TIMESTAMP}.json"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*"; exit 1; }

if ! command -v sqlite3 &>/dev/null; then
    error "sqlite3 is not installed. Install it with: nix-shell -p sqlite"
fi

if [ ! -f "$DB_PATH" ]; then
    error "Database not found at: $DB_PATH"
fi

if ! sqlite3 "$DB_PATH" "SELECT 1;" &>/dev/null; then
    error "Cannot open database. Is Jellyfin still running? Stop it first:\n  sudo systemctl stop jellyfin"
fi
if systemctl is-active --quiet jellyfin 2>/dev/null; then
    error "Jellyfin is still running. Stop it first:\n  sudo systemctl stop jellyfin"
fi

info "Backing up database to: $BACKUP_DB"
cp "$DB_PATH" "$BACKUP_DB"
info "Backup complete ($(du -h "$BACKUP_DB" | cut -f1))"

info "Checking UserData table schema..."
COLUMNS=$(sqlite3 "$DB_PATH" "PRAGMA table_info(UserData);" 2>/dev/null)
if [ -z "$COLUMNS" ]; then
    error "UserData table not found in database"
fi

echo "$COLUMNS" | while IFS='|' read -r cid name type notnull dflt pk; do
    echo "  $name ($type)"
done

CORRUPT_COUNT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM UserData WHERE CustomDataKey = '';")
info "Found $CORRUPT_COUNT corrupt entries (empty CustomDataKey)"

if [ "$CORRUPT_COUNT" -eq 0 ]; then
    info "No corrupt entries found. Nothing to fix!"
    rm -f "$BACKUP_DB"
    exit 0
fi

info "Exporting corrupt entries to: $BACKUP_JSON"
sqlite3 "$DB_PATH" <<'SQL' > "$BACKUP_JSON"
.mode json
SELECT
    CustomDataKey,
    ItemId,
    UserId,
    AudioStreamIndex,
    IsFavorite,
    LastPlayedDate,
    Likes,
    PlayCount,
    PlaybackPositionTicks,
    Played,
    Rating,
    RetentionDate,
    SubtitleStreamIndex
FROM UserData
WHERE CustomDataKey = '';
SQL

info "Exported $CORRUPT_COUNT entries to backup file"

echo ""
info "Corrupt entries summary:"
sqlite3 -header -column "$DB_PATH" <<'SQL'
SELECT
    substr(ItemId, 1, 8) || '...' AS Item,
    substr(UserId, 1, 8) || '...' AS User,
    Played,
    PlayCount,
    PlaybackPositionTicks AS PositionTicks,
    LastPlayedDate
FROM UserData
WHERE CustomDataKey = '';
SQL
echo ""

info "Checking for potential key conflicts..."
CONFLICTS=$(sqlite3 "$DB_PATH" <<'SQL'
SELECT COUNT(*) FROM UserData AS corrupt
INNER JOIN UserData AS existing
    ON corrupt.ItemId = existing.ItemId
    AND corrupt.UserId = existing.UserId
    AND existing.CustomDataKey != ''
WHERE corrupt.CustomDataKey = '';
SQL
)

if [ "$CONFLICTS" -gt 0 ]; then
    warn "Found $CONFLICTS entries that already have a non-empty key counterpart."
    warn "These will be deleted (the non-empty key version already exists)."
    echo ""
    info "Entries with existing counterparts (will be deleted):"
    sqlite3 -header -column "$DB_PATH" <<'SQL'
SELECT
    substr(corrupt.ItemId, 1, 8) || '...' AS Item,
    corrupt.Played AS CorruptPlayed,
    corrupt.PlayCount AS CorruptCount,
    existing.Played AS ExistingPlayed,
    existing.PlayCount AS ExistingCount,
    existing.CustomDataKey AS ExistingKey
FROM UserData AS corrupt
INNER JOIN UserData AS existing
    ON corrupt.ItemId = existing.ItemId
    AND corrupt.UserId = existing.UserId
    AND existing.CustomDataKey != ''
WHERE corrupt.CustomDataKey = '';
SQL
    echo ""
fi

read -rp "Proceed with fix? [y/N] " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    info "Aborted. Database backup is at: $BACKUP_DB"
    exit 0
fi

if [ "$CONFLICTS" -gt 0 ]; then
    info "Removing $CONFLICTS duplicate corrupt entries..."
    sqlite3 "$DB_PATH" <<'SQL'
DELETE FROM UserData
WHERE CustomDataKey = ''
AND EXISTS (
    SELECT 1 FROM UserData AS existing
    WHERE existing.ItemId = UserData.ItemId
    AND existing.UserId = UserData.UserId
    AND existing.CustomDataKey != ''
);
SQL
    info "Removed $CONFLICTS duplicates"
fi
REMAINING=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM UserData WHERE CustomDataKey = '';")
if [ "$REMAINING" -gt 0 ]; then
    info "Fixing $REMAINING remaining entries by setting CustomDataKey to formatted ItemId..."
    SAMPLE_ID=$(sqlite3 "$DB_PATH" "SELECT ItemId FROM UserData WHERE CustomDataKey = '' LIMIT 1;")
    SAMPLE_LEN=${#SAMPLE_ID}

    if [ "$SAMPLE_LEN" -eq 36 ]; then
        info "ItemId format: UUID with dashes (${SAMPLE_LEN} chars). Using as-is for CustomDataKey."
        sqlite3 "$DB_PATH" <<'SQL'
UPDATE UserData
SET CustomDataKey = lower(ItemId)
WHERE CustomDataKey = '';
SQL
    elif [ "$SAMPLE_LEN" -eq 32 ]; then
        info "ItemId format: hex without dashes (${SAMPLE_LEN} chars). Formatting as UUID for CustomDataKey."
        sqlite3 "$DB_PATH" <<'SQL'
UPDATE UserData
SET CustomDataKey =
    lower(
        substr(ItemId, 1, 8) || '-' ||
        substr(ItemId, 9, 4) || '-' ||
        substr(ItemId, 13, 4) || '-' ||
        substr(ItemId, 17, 4) || '-' ||
        substr(ItemId, 21, 12)
    )
WHERE CustomDataKey = '';
SQL
    else
        error "Unexpected ItemId format (length=$SAMPLE_LEN, sample=$SAMPLE_ID). Cannot determine key format."
    fi

    info "Fixed $REMAINING entries"
fi

echo ""
REMAINING_CORRUPT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM UserData WHERE CustomDataKey = '';")
if [ "$REMAINING_CORRUPT" -eq 0 ]; then
    info "Verification passed: no corrupt entries remaining"
else
    error "Verification failed: $REMAINING_CORRUPT corrupt entries still exist!"
fi

echo ""
info "Done! Summary:"
info "  - Database backup: $BACKUP_DB"
info "  - Exported corrupt data: $BACKUP_JSON"
info "  - Fixed entries: $CORRUPT_COUNT"
info ""
info "You can now restart Jellyfin:"
info "  sudo systemctl start jellyfin"
