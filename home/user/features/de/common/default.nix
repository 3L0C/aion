{pkgs, ...}: {
  imports = [
    ./services
    ./tools

    ./browsers.nix
    ./document-viewers.nix
    ./filemanagers.nix
    ./gnome-apps.nix
    ./kde-apps.nix
    ./music-players.nix
    ./security.nix
    ./stylix.nix
    ./virtualization.nix
    ./wayland.nix
    ./wine.nix
    ./wk.nix
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    overskride
  ];
}
