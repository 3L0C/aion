{lib, ...}: {
  services.wpaperd = {
    enable = true;
  };

  systemd.user.services.wpaperd = {
    Unit = {
      PartOf = ["river-session.target"];
      After = ["river-session.target"];
    };
    Install = {
      WantedBy = lib.mkForce ["river-session.target"];
    };
  };
}
