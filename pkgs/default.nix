{pkgs}: {
  nb = pkgs.writeShellScriptBin "nb" (builtins.readFile ./scripts/nix/nb);
  bs = pkgs.writeShellScriptBin "bs" (builtins.readFile ./scripts/bin/bs);
  vidthumb = pkgs.writeShellScriptBin "vidthumb" (builtins.readFile ./scripts/utils/vidthumb);
  doomemacs = pkgs.writeShellScriptBin "doomemacs" (builtins.readFile ./scripts/doom/doomemacs);
  hmpv = pkgs.writeShellScriptBin "hmpv" (builtins.readFile ./scripts/wip/hmpv);
  wip-test = pkgs.writeShellScriptBin "wip-test" (builtins.readFile ./scripts/wip/wip-test);
}
