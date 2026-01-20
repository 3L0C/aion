{
  callPackage,
  writeShellScriptBin,
}: let
  mkScript = name: file: writeShellScriptBin name (builtins.readFile file);
in {
  hypr-layout = mkScript "hypr-layout" ./hyprland/layout.sh;
  nb = mkScript "nb" ./nix/nb;
  ne = mkScript "ne" ./ne;
  doomemacs = mkScript "doomemacs" ./doom/doomemacs;
  dns-recovery = mkScript "dns-recovery" ./system/dns-recovery;
  media = mkScript "media" ./media/media;
  browser-migrate = mkScript "browser-migrate" ./browser/browser-migrate;
  statusbar = callPackage ./statusbar {};
  menu = callPackage ./menu {};
  lf = callPackage ./lf {};
}
