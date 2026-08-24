{
  perSystem = {pkgs, ...}: {
    packages.mpv-scripts = pkgs.callPackage ./_mpv-scripts {};
  };
}
