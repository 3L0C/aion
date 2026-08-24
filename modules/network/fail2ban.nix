# Fail2ban for SSH brute force protection
{
  flake.modules.nixos.fail2ban = {
    config,
    lib,
    ...
  }: let
    sshPorts = config.services.openssh.ports;
    sshPortStr = lib.concatMapStringsSep "," toString sshPorts;
  in {
    services.fail2ban = {
      enable = true;
      maxretry = 5;
      bantime = "1h";
      bantime-increment = {
        enable = true;
        maxtime = "168h"; # 1 week max
        factor = "4";
      };
      jails.sshd = {
        settings = {
          enabled = true;
          port = sshPortStr;
          filter = "sshd";
          maxretry = 3;
        };
      };
    };
  };
}
