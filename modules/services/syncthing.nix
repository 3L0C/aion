{
  flake.modules = {
    nixos = {
      syncthing = {
        services.syncthing = {
          enable = true;
          openDefaultPorts = true;
          guiAddress = "0.0.0.0:8384";
        };
      };

      syncthing-ports = {
        networking.firewall = {
          allowedTCPPorts = [ 22000 ];
          allowedUDPPorts = [
            22000
            21027
          ];
        };
      };
    };

    homeManager.syncthing = {
      services.syncthing = {
        enable = true;
        guiAddress = "0.0.0.0:8384";
      };
    };
  };
}
