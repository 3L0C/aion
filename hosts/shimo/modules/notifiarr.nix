{
  virtualisation.oci-containers.containers.notifiarr = {
    image = "golift/notifiarr:latest";
    ports = ["5454:5454"];
    volumes = [
      "/var/lib/notifiarr:/config"
      "/var/run/utmp:/var/run/utmp:ro"
      "/etc/machine-id:/etc/machine-id:ro"
    ];
    environment = {
      TZ = "America/Los_Angeles";
    };
  };
  systemd.tmpfiles.rules = [
    "d /var/lib/notifiarr 0755 root root -"
  ];
}
