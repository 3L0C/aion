{
  writeShellApplication,
  git,
}:
writeShellApplication {
  name = "update-pkgs";

  runtimeInputs = [git];

  text = ''
    # nix-update edits the source file in the working tree, so operate from the
    # flake root regardless of where the command was invoked.
    root=$(git rev-parse --show-toplevel)
    cd "$root"

    system=$(nix eval --impure --raw --expr builtins.currentSystem)

    # Discover auto-updatable packages. Emits one TSV line per package:
    #   <attrPath>\t<sourceFileRelativeToRepo>\t<branch|tag>
    # attrPath comes from the tree walk, the file from meta.position, and the
    # branch/tag mode from the version string: the nixpkgs `<v>-unstable-<date>`
    # convention -- or a bare commit hash (a rev pin with no releases) -- means
    # follow the branch HEAD; anything else is a released version, follow tags.
    # (Reading the package's actual updater would be exact, but deep-evaluating a
    # nix-update-script updateScript pulls nix-update in and trips the lix overlay
    # recursion, so we classify from the version instead.)
    targets=$(nix eval --impure --raw --expr '
      let
        flake = builtins.getFlake (toString ./.);
        lib = flake.inputs.nixpkgs.lib;
        set = builtins.getAttr (builtins.currentSystem) flake.legacyPackages;
        root = toString flake.outPath;
        fileOf = v: lib.removePrefix (root + "/") (lib.head (lib.splitString ":" v.meta.position));
        # NOTE: the hex-ish branch on the classifier below is a heuristic, not an
        # exact match on "is this a commit hash". A bare 7-40 char string of only
        # [0-9a-f] would be misclassified as "branch" even if it were something
        # else entirely -- e.g. a hypothetical all-digit date tag "20260315" (8
        # chars, all in [0-9a-f]) would match and be treated as a branch pin. No
        # package here currently uses such a version scheme, but a future one
        # could trip this.
        modeOf = v:
          let ver = toString (v.version or ""); in
          if (builtins.match ".*-unstable-.*" ver) != null then "branch"
          else if (builtins.match "[0-9a-f]{7,40}" ver) != null then "branch"
          else "tag";
        # Only descends into attrsets marked recurseForDerivations (the flag
        # `lib.recurseIntoAttrs` sets), matching how `nix build`/`nix search`
        # discover nested package sets. A namespace under `scripts` that isn't
        # marked this way (e.g. a future `scripts.statusbar` with its own
        # updateScript-bearing packages) won't be walked into, so its packages
        # won't be discovered here even if they declare `passthru.updateScript`.
        go = path: s:
          lib.concatLists (lib.mapAttrsToList (n: v:
            if !(lib.isAttrs v) then []
            else if lib.isDerivation v then
              (if (v.passthru.updateScript or null) != null
               then [ (lib.concatStringsSep "\t" [ (lib.concatStringsSep "." (path ++ [n])) (fileOf v) (modeOf v) ]) ]
               else [])
            else if (v.recurseForDerivations or false) then go (path ++ [n]) v
            else []) s);
      in lib.concatStringsSep "\n" (go [] set)
    ')

    # Keep going if a single package fails to update (network, a moved branch, ...)
    # rather than aborting the whole batch under `set -e`. The diff shows what changed.
    nix_update() {
      nix run nixpkgs#nix-update -- "$@" \
        || echo "  !! nix-update exited non-zero for this package; check the diff / rerun it alone"
    }

    while IFS=$'\t' read -r attr file mode; do
      [ -n "$attr" ] || continue
      echo ">> updating $attr ($mode) -> $file"
      extra=()
      [ "$mode" = "branch" ] && extra=(--version=branch)
      nix_update --flake --override-filename "$file" "''${extra[@]}" "$@" "legacyPackages.$system.$attr"
    done <<< "$targets"

    echo ">> done. review changes with: git diff -- pkgs/"
  '';
}
