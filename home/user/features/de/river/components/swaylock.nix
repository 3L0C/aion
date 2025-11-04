{lib, ...}: {
  programs.swaylock = {
    enable = true;

    settings = {
      # Behavior
      ignore-empty-password = true;
      show-failed-attempts = true;
      show-keyboard-layout = false;
      indicator-radius = 100;
      indicator-thickness = 10;
      image = lib.mkDefault "~/.config/hypr/1450741833367.jpg"; # Reuse Hyprland wallpaper
      scaling = "fill";
      daemonize = false;
    };
  };
}
