{
  virtualisation.oci-containers.containers.wireguard = {
    image = "lscr.io/linuxserver/wireguard:latest";
    environment = {
      PUID = "1000";
      PGID = "1000";
      TZ = "America/Los_Angeles";
      SERVERURL = "auto";
      SERVERPORT = "51820";
      PEERS = "iPhone,PC,Laptop,Tablet,Pixel8,SteamDeck";
      INTERNAL_SUBNET = "192.168.99.0";
      ALLOWEDIPS = "192.168.1.0/24,192.168.99.0/24";
      LOG_CONFS = "true";
    };
    volumes = [
      "/var/lib/wireguard:/config"
      "/run/current-system/kernel-modules/lib/modules:/lib/modules:ro"
    ];
    extraOptions = [
      "--network=host"
      "--cap-add=NET_ADMIN"
      "--cap-add=SYS_MODULE"
      "--sysctl=net.ipv4.conf.all.src_valid_mark=1"
    ];
  };
  systemd.tmpfiles.rules = [
    "d /var/lib/wireguard 0755 root root -"
  ];
  networking.firewall.allowedUDPPorts = [51820];
}
