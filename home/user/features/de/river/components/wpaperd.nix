{lib, ...}: {
  services.wpaperd = {
    enable = true;
  };

  systemd.user.services.wpaperd = {
    Unit = {
      PartOf = ["wayland-session@River.target"];
      After = ["wayland-session@River.target"];
    };
    Install = {
      WantedBy = lib.mkForce ["wayland-session@River.target"];
    };
  };
}
