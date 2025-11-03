{pkgs, ...}: {
  systemd.user.services.wpctl-settings = {
    Unit = {
      Description = "Configure WirePlumber Bluetooth settings";
      After = [
        "graphical-session.target"
        "pipewire.service"
        "wireplumber.service"
      ];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.wireplumber}/bin/wpctl settings --save bluetooth.autoswitch-to-headset-profile false";
      Slice = "background-graphical.slice";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
