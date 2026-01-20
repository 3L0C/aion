{pkgs, ...}: {
  programs.eww = {
    enable = true;
    package = pkgs.eww;
    configDir = ./config;
  };
  home.packages = with pkgs; [
    playerctl
    jq
  ];
}
