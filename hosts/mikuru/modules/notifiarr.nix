# Notifiarr notification relay for *arr apps.
# There is no native NixOS module, so it runs as a Podman container.
{config, ...}: {
  virtualisation.oci-containers.containers.notifiarr = {
    image = "golift/notifiarr:latest";
    volumes = [
      "/var/lib/notifiarr:/config"
      "/var/run/utmp:/var/run/utmp:ro"
      "/etc/machine-id:/etc/machine-id:ro"
    ];
    environment = {
      TZ = config.time.timeZone;
    };
    extraOptions = [
      "--pull=always"
      "--network=host"
      "--memory=512m"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/notifiarr 0755 root root -"
  ];
}
