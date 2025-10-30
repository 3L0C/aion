{ username, ... }:
{
  services = {
    xserver = {
      displayManager.startx.enable = true;
      enable = true;
      xkb.layout = "us";
    };

    libinput = {
      enable = true;
    };
  };
  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
}
