{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-unwrapped.override {
      x11Support = false;
    };

    font = lib.mkForce "${config.stylix.fonts.monospace.name} ${toString config.stylix.fonts.sizes.popups}";
    terminal = "${lib.getExe pkgs.kitty}";
    # Basic configuration
    extraConfig = {
      modi = "drun,run,ssh";
      display-drun = "Applications";
      display-run = "Run";
      display-ssh = "SSH";

      run-command = "uwsm-app -- {cmd}";
      show-icons = false;
      drun-display-format = "{name}";
    };
  };
}
