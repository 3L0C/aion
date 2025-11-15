{pkgs, ...}: {
  home.packages = with pkgs; [
    easyeffects
  ];
  systemd.user.services.easyeffects = {
    Unit = {
      Description = "EasyEffects audio processing";
      After = ["graphical-session.target" "pipewire.service"];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.easyeffects}/bin/easyeffects --gapplication-service";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
