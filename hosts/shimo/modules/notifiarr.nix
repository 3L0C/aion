{
  virtualisation.oci-containers.containers.notifiarr = {
    image = "golift/notifiarr:latest";
    volumes = [
      "/var/lib/notifiarr:/config"
      "/var/run/utmp:/var/run/utmp:ro"
      "/etc/machine-id:/etc/machine-id:ro"
    ];
    environment = {
      TZ = "America/Los_Angeles";
    };
    extraOptions = [
      "--network=host"
    ];
  };
  systemd.tmpfiles.rules = [
    "d /var/lib/notifiarr 0755 root root -"
  ];
}
