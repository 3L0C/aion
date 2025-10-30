{ ... }:
{
  programs.mpv.enable = true;

  imports = [
    ./binds.nix
    ./config.nix
    ./scripts
  ];
}
