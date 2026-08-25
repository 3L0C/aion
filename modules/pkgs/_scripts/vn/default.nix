# Visual novel wine helpers: vn-init, vn-run, vn-shell, vn-migrate.
# wine and wine-ge store paths are baked in at build time, so the scripts
# do not depend on PATH order.
{
  cabextract,
  coreutils,
  p7zip,
  rsync,
  wine,
  wine-ge,
  winetricks,
  writeShellScriptBin,
}:
let
  # vcrun2022 is omitted: winetricks refuses to install it next to vcrun2015,
  # and vcrun2015 covers most VN engines.
  winetricksVerbs = "corefonts cjkfonts d3dx9 vcrun2015 xact quartz ffdshow";

  # winetricks shells out to cabextract / 7z for extraction.
  initPath = "${winetricks}/bin:${wine}/bin:${wine-ge}/bin:${coreutils}/bin:${cabextract}/bin:${p7zip}/bin";
in
{
  vn-init = writeShellScriptBin "vn-init" ''
    #!/usr/bin/env sh
    # Usage: vn-init [--force]
    # Bootstraps ~/Games/vn (vanilla wine) and ~/Games/vn-ge (wine-ge) as
    # 32-bit wine prefixes with a lean set of winetricks verbs. Downloads
    # Windows redistributables from the internet (several hundred MB).
    #
    # Idempotent: a per-prefix marker file ($PREFIX/.aion-bootstrapped)
    # prevents re-running. Pass --force to bootstrap anyway.
    set -eu

    force=0
    if [ "''${1-}" = "--force" ]; then
      force=1
      shift
    fi

    export PATH=${initPath}:$PATH

    bootstrap_prefix() {
      prefix="$1"
      winebin="$2"

      if [ "$force" -eq 0 ] && [ -f "$prefix/.aion-bootstrapped" ]; then
        echo "==> $prefix already bootstrapped, skipping (--force to override)"
        return 0
      fi

      echo "==> bootstrapping $prefix with $winebin"
      mkdir -p "$prefix"

      WINEPREFIX="$prefix" WINEARCH=win32 LC_ALL=ja_JP.UTF-8 \
        "$winebin" wineboot --init

      WINEPREFIX="$prefix" LC_ALL=ja_JP.UTF-8 \
        winetricks -q ${winetricksVerbs}

      touch "$prefix/.aion-bootstrapped"
      echo "==> $prefix ready"
    }

    bootstrap_prefix "$HOME/Games/vn" ${wine}/bin/wine
    bootstrap_prefix "$HOME/Games/vn-ge" ${wine-ge}/bin/wine

    echo
    echo "All VN prefixes bootstrapped. Use vn-run (vanilla) or vn-run --ge (wine-ge) to launch games."
  '';

  vn-run = writeShellScriptBin "vn-run" ''
    #!/usr/bin/env sh
    # Usage: vn-run [--ge] <game.exe> [args...]
    set -eu

    prefix="$HOME/Games/vn"
    wine_bin="${wine}/bin/wine"

    if [ "''${1-}" = "--ge" ]; then
      prefix="$HOME/Games/vn-ge"
      wine_bin="${wine-ge}/bin/wine"
      shift
    fi

    exec env \
      WINEPREFIX="$prefix" \
      LC_ALL="ja_JP.UTF-8" \
      LANG="ja_JP.UTF-8" \
      TZ="Asia/Tokyo" \
      WINEDLLOVERRIDES="winemenubuilder.exe=d" \
      "$wine_bin" "$@"
  '';

  vn-shell = writeShellScriptBin "vn-shell" ''
    #!/usr/bin/env sh
    # Usage: vn-shell [prefix-path]
    # Default prefix: ~/Games/vn. Override by passing an absolute path.
    # Inside the subshell, winetricks / winecfg / wine <exe> all target
    # the VN prefix with Japanese locale + Tokyo time zone.
    exec env \
      WINEPREFIX="''${1:-$HOME/Games/vn}" \
      LC_ALL="ja_JP.UTF-8" \
      LANG="ja_JP.UTF-8" \
      TZ="Asia/Tokyo" \
      "''${SHELL:-/bin/sh}"
  '';

  vn-migrate = writeShellScriptBin "vn-migrate" ''
    #!/usr/bin/env sh
    # Usage: vn-migrate <src-prefix> <dst-prefix>
    #   e.g.  vn-migrate ~/arch-home/.local/share/wineprefixes/fate ~/Games/vn
    # Copies installed-game folders from a source wine prefix into a
    # destination wine prefix. Preserves saves that live inside game
    # install dirs. Does NOT touch: drive_c/users, dosdevices, registry.
    set -eu

    src="''${1:?usage: vn-migrate <src-prefix> <dst-prefix>}"
    dst="''${2:?usage: vn-migrate <src-prefix> <dst-prefix>}"

    [ -d "$src/drive_c" ] || {
      echo "not a wine prefix: $src" >&2
      exit 1
    }
    [ -d "$dst/drive_c" ] || {
      echo "not a wine prefix: $dst (run vn-init first to bootstrap)" >&2
      exit 1
    }

    for dir in "Program Files" "Program Files (x86)"; do
      if [ -d "$src/drive_c/$dir" ]; then
        echo "==> copying '$dir' from $src to $dst"
        ${rsync}/bin/rsync -a --info=progress2 \
          --exclude='Windows NT' \
          --exclude='Common Files' \
          --exclude='Internet Explorer' \
          --exclude='Windows Media Player' \
          "$src/drive_c/$dir/" "$dst/drive_c/$dir/"
      fi
    done

    cat <<'MSG'
    ==> done. games whose saves live inside the install directory
        (e.g. Fate Realta Nua: faterealtanua_savedata) are migrated
        automatically.

        if a game stores saves in AppData, copy manually, e.g.:

          rsync -a \
            <src>/drive_c/users/<old-user>/AppData/Roaming/<Vendor>/ \
            <dst>/drive_c/users/<new-user>/AppData/Roaming/<Vendor>/

        not done automatically to avoid clobbering fresh AppData.
    MSG
  '';
}
