{
  callPackage,
  fzf,
  jq,
  rsync,
  winePackages,
  writeShellApplication,
  writeShellScriptBin,
}:
let
  mkScript = name: file: writeShellScriptBin name (builtins.readFile file);
in
{
  nb = mkScript "nb" ./nix/nb;
  ne = mkScript "ne" ./ne;

  doomemacs = mkScript "doomemacs" ./doom/doomemacs;

  dns-recovery = mkScript "dns-recovery" ./system/dns-recovery;

  touchpad-toggle = mkScript "touchpad-toggle" ./river/touchpad-toggle;

  window-pick = writeShellApplication {
    name = "window-pick";
    runtimeInputs = [
      fzf
      jq
    ];
    text = builtins.readFile ./oxbow/window-pick;
  };

  media = mkScript "media" ./media/media;

  converter-sh = mkScript "converter.sh" ./media/converter.sh;

  statusbar = callPackage ./statusbar { };

  menu = callPackage ./menu { };

  lf = callPackage ./lf { };

  vn = callPackage ./vn {
    # winePackages creates the 32-bit prefixes that VN engines need.
    # wineWow64Packages refuses WINEARCH=win32; wineWowPackages is deprecated.
    wine = winePackages.waylandFull;
    inherit rsync;
  };
}
