{
  callPackage,
  writeShellScriptBin,
}: let
  mkScript = name: file: writeShellScriptBin name (builtins.readFile file);
in {
  nb = mkScript "nb" ./nix/nb;
  bs = mkScript "bs" ./bin/bs;
  vidthumb = mkScript "vidthumb" ./utils/vidthumb;
  doomemacs = mkScript "doomemacs" ./doom/doomemacs;
  hmpv = mkScript "hmpv" ./wip/hmpv;
  wip-test = mkScript "wip-test" ./wip/wip-test;
  statusbar = callPackage ./statusbar {};
  menu = callPackage ./menu {};
  lf = callPackage ./lf {};
}
