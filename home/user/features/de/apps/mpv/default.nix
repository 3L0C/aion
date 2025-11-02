{
  programs.mpv.enable = true;

  imports = [
    ./scripts

    ./binds.nix
    ./config.nix
  ];
}
