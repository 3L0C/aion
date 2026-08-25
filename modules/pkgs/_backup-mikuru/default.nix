{
  lib,
  writeShellApplication,
  rsync,
  coreutils,
  util-linux,
}:
writeShellApplication {
  name = "mikuru-backup";

  runtimeInputs = [
    rsync
    coreutils
    util-linux
  ];

  text = ''
    dataset="tank/backups/mikuru-state"
    keep_snapshots=8
    start_epoch=$SECONDS

    log() { echo ">> $*"; }
    warn() { echo "WARNING: $*" >&2; }
    die() {
      echo "ERROR: $*" >&2
      exit 1
    }
    services=(
      "traefik:/var/lib/traefik"                          # services.traefik.dataDir (ACME acme.json)
      "glance:/var/lib/private/glance"                    # DynamicUser + StateDirectory=glance
      "jellyfin:/var/lib/jellyfin"                        # services.jellyfin.dataDir (configDir nests inside)
      "seerr:/var/lib/private/seerr"                      # jellyseerr; DynamicUser + StateDirectory=seerr
      "sonarr:/var/lib/sonarr"                            # dataDir=/var/lib/sonarr/.config/NzbDrone (in home dir)
      "radarr:/var/lib/radarr"                            # dataDir=/var/lib/radarr/.config/Radarr (in home dir)
      "lidarr:/var/lib/lidarr"                            # dataDir=/var/lib/lidarr/.config/Lidarr (in home dir)
      "prowlarr:/var/lib/prowlarr"                        # StateDirectory=prowlarr
      "bazarr:/var/lib/bazarr"                            # users.users.bazarr.home
      "jackett:/var/lib/jackett"                          # dataDir=/var/lib/jackett/.config/Jackett (in home dir)
      "navidrome:/var/lib/navidrome"                      # settings.DataFolder + StateDirectory=navidrome
      "komga:/var/lib/komga"                              # services.komga.stateDir
      "kavita:/var/lib/kavita"                            # services.kavita.dataDir
      "suwayomi-server:/var/lib/suwayomi-server"          # services.suwayomi-server.dataDir
      "qbittorrent:/var/lib/qBittorrent"                  # services.qbittorrent.profileDir (vpn-confined, plain unit name)
      "syncthing:/var/lib/syncthing/.config/syncthing"    # services.syncthing.configDir (keys, device IDs, index db)
      # services.syncthing.dataDir (/var/lib/syncthing/sync) is deliberately excluded:
      # it's synced content already replicated to other hosts, not unique
      # state, and would inflate every retained snapshot for no benefit.
      "immich-server:/var/lib/immich"                     # StateDirectory=immich (media on tank; DB via pg_dumpall)
      "immich-machine-learning:"                          # stop-only: only has CacheDirectory (/var/cache/immich)
      "redis-immich:/var/lib/redis-immich"                # StateDirectory=redis-immich (dump.rdb)
      "photoprism:/var/lib/private/photoprism"            # DynamicUser + StateDirectory=photoprism (originals on tank)
      "podman-audiobookshelf:/var/lib/audiobookshelf"     # oci volumes: config + metadata subdirs
      "podman-cleanuparr:/var/lib/cleanuparr"             # oci volume: /config
      "podman-notifiarr:/var/lib/notifiarr"               # oci volume: /config
    )

    # Copied without stopping anything (live, low-write state).
    live_paths=(
      "/var/lib/samba" # samba passdb/secrets (private/passdb.tdb)
    )

    # ----- preflight -------------------------------------------------------
    [[ $EUID -eq 0 ]] || die "must run as root (try: sudo mikuru-backup)"
    command -v zfs >/dev/null 2>&1 || die "zfs not found in PATH; is this mikuru?"
    command -v zpool >/dev/null 2>&1 || die "zpool not found in PATH; is this mikuru?"
    command -v systemctl >/dev/null 2>&1 || die "systemctl not found in PATH"

    zpool list -H tank >/dev/null 2>&1 || die "pool 'tank' is not imported; aborting"

    # Idempotently create the destination dataset (inherits pool properties).
    if ! zfs list -H -o name "$dataset" >/dev/null 2>&1; then
      log "creating dataset $dataset"
      zfs create -p "$dataset"
    fi
    [[ $(zfs get -H -o value mounted "$dataset") == "yes" ]] \
      || die "dataset $dataset is not mounted"
    dest=$(zfs get -H -o value mountpoint "$dataset")
    [[ -d $dest ]] || die "mountpoint '$dest' of $dataset is not a directory"
    log "backing up to $dest"

    # ----- stop services (trap guarantees restart on ANY exit path) --------
    # restart_failed is set (not fatal) by the trap so a failed restart is
    # never silently swallowed; the normal-path caller below turns it into a
    # non-zero exit once the backup itself has finished.
    stopped_units=()
    restart_failed=0
    restart_stopped_units() {
      local i
      for ((i = ''${#stopped_units[@]} - 1; i >= 0; i--)); do
        log "starting ''${stopped_units[i]}"
        systemctl start "''${stopped_units[i]}" || {
          warn "failed to restart ''${stopped_units[i]}; check it manually"
          restart_failed=1
        }
      done
      stopped_units=()
    }
    trap restart_stopped_units EXIT

    # Stop $1 and push it onto stopped_units for restart, but only if it's
    # currently active -- an already-inactive unit is left alone so the trap
    # never "restarts" something that was intentionally down beforehand.
    stop_and_track() {
      local unit=$1
      systemctl is-active --quiet "$unit" || return 0
      log "stopping $unit"
      systemctl stop "$unit"
      stopped_units+=("$unit")
    }

    copy_paths=()
    for entry in "''${services[@]}"; do
      unit=''${entry%%:*}
      path=''${entry#*:}
      # Unit-less entries only contribute a path (copied under the stop
      # window established by the units listed before them).
      if [[ -z $unit ]]; then
        copy_paths+=("$path")
        continue
      fi
      if ! systemctl cat "$unit.service" >/dev/null 2>&1; then
        warn "unit $unit.service not found on this system; skipping"
        continue
      fi
      # Suspend the matching health-check timer (arr stack) FIRST so it
      # cannot re-arm and fire again, then stop the (oneshot) health-check
      # service itself to kill any run already in flight -- otherwise it
      # could `systemctl restart` this unit mid-rsync. Only the timer is
      # tracked for restart; the oneshot service needs no restart of its
      # own, the timer will trigger it again on schedule.
      if systemctl cat "$unit-health-check.timer" >/dev/null 2>&1; then
        stop_and_track "$unit-health-check.timer"
      fi
      if systemctl cat "$unit-health-check.service" >/dev/null 2>&1; then
        systemctl stop "$unit-health-check.service"
      fi
      stop_and_track "$unit.service"
      [[ -n $path ]] && copy_paths+=("$path")
    done

    # ----- postgres dump (cluster stays up; taken while consistent) --------
    if systemctl cat postgresql.service >/dev/null 2>&1; then
      systemctl is-active --quiet postgresql.service \
        || die "postgresql.service exists but is not active; refusing a partial backup"
      pg_dumpall_bin=$(command -v pg_dumpall) \
        || die "pg_dumpall not found in PATH but postgresql.service exists"
      log "dumping postgres cluster (pg_dumpall)"
      mkdir -p "$dest/postgres"
      dump_tmp="$dest/postgres/.dumpall.sql.tmp"
      runuser -u postgres -- "$pg_dumpall_bin" >"$dump_tmp"
      mv "$dump_tmp" "$dest/postgres/dumpall.sql"
    else
      warn "postgresql.service not found on this system; skipping pg_dumpall"
    fi

    # ----- copy state ------------------------------------------------------
    mkdir -p "$dest/state"
    for path in "''${copy_paths[@]}" "''${live_paths[@]}"; do
      if [[ ! -e $path ]]; then
        warn "state path $path does not exist; skipping"
        continue
      fi
      log "rsync $path"
      # -R mirrors the full source path under $dest/state (restore-friendly);
      # --delete keeps each mirrored tree an exact copy.
      rsync -aHAX --delete --numeric-ids -R "$path" "$dest/state/"
    done

    # ----- restart everything before snapshotting --------------------------
    restart_stopped_units
    trap - EXIT

    # ----- snapshot + prune ------------------------------------------------
    snapshot="$dataset@backup-$(date +%Y%m%d-%H%M%S)"
    log "creating snapshot $snapshot"
    zfs snapshot "$snapshot"

    # Read into a variable first (not process substitution) so a failing
    # `zfs list` is caught explicitly instead of mapfile silently seeing an
    # empty stream and pruning nothing.
    all_snaps_raw=$(zfs list -H -t snapshot -o name -s creation "$dataset") \
      || die "zfs list failed while checking snapshots for $dataset; not pruning"
    all_snaps=()
    [[ -n $all_snaps_raw ]] && mapfile -t all_snaps <<<"$all_snaps_raw"
    backup_snaps=()
    for snap in "''${all_snaps[@]}"; do
      if [[ $snap == "$dataset@backup-"* ]]; then
        backup_snaps+=("$snap")
      fi
    done
    prune_count=$((''${#backup_snaps[@]} - keep_snapshots))
    for ((i = 0; i < prune_count; i++)); do
      log "pruning old snapshot ''${backup_snaps[i]}"
      zfs destroy "''${backup_snaps[i]}"
    done

    # ----- summary ----------------------------------------------------------
    elapsed=$((SECONDS - start_epoch))
    log "backup complete in $((elapsed / 60))m$((elapsed % 60))s"
    log "dataset used: $(zfs get -H -o value used "$dataset")"
    log "snapshot:     $snapshot"

    # The backup itself succeeded, but a service that failed to come back up
    # is not a success -- fail loudly now that the diagnostic summary above
    # has been printed.
    if ((restart_failed)); then
      echo "ERROR: one or more services failed to restart after backup; see warnings above" >&2
      exit 1
    fi
  '';

  meta = {
    description = "Consistent backup of mikuru's service state to the tank ZFS pool";
    maintainers = [ (import ../_maintainers.nix).threeloc ];
    mainProgram = "mikuru-backup";
    platforms = lib.platforms.linux;
  };
}
