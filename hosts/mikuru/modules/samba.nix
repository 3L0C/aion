{
  services = {
    samba = {
      enable = true;
      openFirewall = true; # Opens ports 139, 445

      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "mikuru";
          "netbios name" = "mikuru";
          "security" = "user";
          "hosts allow" = "192.168.1.0/24 100.64.0.0/10 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "map to guest" = "never"; # Require authentication
        };
        media = {
          path = "/mnt";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "valid users" = "@media"; # Users in media group
          "force group" = "media";
          "create mask" = "0664";
          "directory mask" = "0775";
          # Apple compatibility
          "vfs objects" = "catia fruit streams_xattr";
          "fruit:aapl" = "yes";
        };
      };
    };

    # Windows discovery daemon
    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

    # macOS/Bonjour discovery
    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
  };
}
