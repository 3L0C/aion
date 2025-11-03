{pkgs, ...}: {
  programs.mpv.enable = true;

  imports = [
    ./scripts

    ./binds.nix
    ./config.nix
  ];

  # MPV helper scripts
  home.packages = with pkgs.custom.scripts; [
    hmpv # MPV helper (WIP)
  ];
}
