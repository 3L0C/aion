{lib, ...}: {
  services.wpaperd = {
    enable = true;
  };

  systemd.user.services.wpaperd = {
    Unit = {
      PartOf = ["wayland-session@river.target"];
      After = ["wayland-session@river.target"];
    };
    Install = {
      WantedBy = lib.mkForce ["wayland-session@river.target"];
    };
  };
}
