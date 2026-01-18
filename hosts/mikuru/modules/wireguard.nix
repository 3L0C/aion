{
  networking = {
    wireguard.interfaces.wg0 = {
      ips = ["192.168.99.1/24"];
      listenPort = 51820;
      privateKeyFile = "/var/lib/wireguard/server-private-key";
      peers = [
        {
          publicKey = "YcoYEIBaVm3nXfCFHXHatfRtqZ8JjttfgzkfmugQJ0A=";
          presharedKeyFile = "/var/lib/wireguard/psk-iphone";
          allowedIPs = ["192.168.99.4/32"];
        }
        {
          publicKey = "f3vrJfNZ4S4Mf35CLNvAYDtKDUy57eC/O2A8FiPodhc=";
          presharedKeyFile = "/var/lib/wireguard/psk-pc";
          allowedIPs = ["192.168.99.5/32"];
        }
        {
          publicKey = "qBnyrt5iYod5ToSQM4UAH7SzFcDFT3cLnQebleqVxQk=";
          presharedKeyFile = "/var/lib/wireguard/psk-laptop";
          allowedIPs = ["192.168.99.6/32"];
        }
        {
          publicKey = "qtZdXeaMmFWPG/e50uliQsZF6CG6P7CSbhyvW55Mw2o=";
          presharedKeyFile = "/var/lib/wireguard/psk-tablet";
          allowedIPs = ["192.168.99.7/32"];
        }
        {
          publicKey = "s4vzV36hsSM3lqoLJAP+BsJRPDP4UwByBKwnBKk4bQk=";
          presharedKeyFile = "/var/lib/wireguard/psk-pixel8";
          allowedIPs = ["192.168.99.8/32"];
        }
        {
          publicKey = "MY6fy+EaRqOF5staK3JpmuGw2P4xEHhSavLUJj13lx0=";
          presharedKeyFile = "/var/lib/wireguard/psk-steamdeck";
          allowedIPs = ["192.168.99.2/32"];
        }
      ];
    };
    nat = {
      enable = true;
      internalInterfaces = ["wg0"];
      externalInterface = "enp8s0"; # Adjust to your actual interface
    };
    firewall.allowedUDPPorts = [51820];
  };
}
