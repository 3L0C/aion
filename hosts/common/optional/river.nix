{...}: {
  imports = [
    ./wayland.nix
  ];

  programs.river-uwsm.enable = true;
}
