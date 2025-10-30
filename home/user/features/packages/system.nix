{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dunst # Customizable and lightweight notification-daemon
  ];
}
