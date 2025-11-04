{
  callPackage,
  writeShellScriptBin,
}: let
  mkScript = name: file: writeShellScriptBin name (builtins.readFile file);
in {
  hypr-layout = mkScript "hypr-layout" ./hyprland/layout.sh;
  nb = mkScript "nb" ./nix/nb;
  doomemacs = mkScript "doomemacs" ./doom/doomemacs;
  dns-recovery = mkScript "dns-recovery" ./system/dns-recovery;
  hmpv = mkScript "hmpv" ./wip/hmpv;
  statusbar = callPackage ./statusbar {};
  menu = callPackage ./menu {};
  lf = callPackage ./lf {};
}
