{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (config.home) homeDirectory;
  currentHost = config.hostSpec.name;

  # Tailnet hosts mapping: hostname -> domain
  # Add new hosts here to include them in SSH config
  tailnetHosts = {
    haruhi = "tail7d01e8.ts.net";
    mikuru = "tail7d01e8.ts.net";
    yuki = "tail7d01e8.ts.net";
  };

  # Generate SSH settings entries for all tailnet hosts except the current one
  tailnetSettings = lib.mapAttrs' (hostname: domain: {
    name = hostname;
    value = {
      HostName = "${hostname}.${domain}";
      User = "user";
      IdentityFile = "~/.ssh/id_3L0C";
      AddKeysToAgent = "yes";
    };
  }) (lib.filterAttrs (hostname: _: hostname != currentHost) tailnetHosts);
  # All SSH key names to deploy via sops
  sshKeyNames = [
    "id_3L0C"
    "id_anskrevy"
    "id_aur"
    "id_CSUG-Cole"
    "id_openwrt"
  ];

  # Generate sops.secrets entries for all SSH keys (private + public)
  sshKeySecrets = lib.listToAttrs (
    lib.flatten (
      map (name: [
        {
          name = "ssh_keys/${name}";
          value = {
            path = "${homeDirectory}/.ssh/${name}";
            mode = "0600";
          };
        }
        {
          name = "ssh_keys/${name}.pub";
          value = {
            path = "${homeDirectory}/.ssh/${name}.pub";
            mode = "0644";
          };
        }
      ])
      sshKeyNames
    )
  );
in {
  # SSH keys deployed from sops secrets
  sops.secrets = sshKeySecrets;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    package = pkgs.stable.openssh;

    settings =
      {
        "github.com-anskrevy" = {
          HostName = "github.com";
          User = "git";
          IdentityFile = "~/.ssh/id_anskrevy";
          AddKeysToAgent = "yes";
        };

        "openwrt" = {
          HostName = "192.168.1.1";
          Port = 53920;
          User = "root";
          IdentityFile = "~/.ssh/openwrt";
          AddKeysToAgent = "yes";
        };

        "aur.archlinux.org " = {
          IdentityFile = "~/.ssh/id_aur";
          User = "aur";
          AddKeysToAgent = "yes";
        };

        "github.com-3L0C" = {
          HostName = "github.com";
          User = "git";
          IdentityFile = "~/.ssh/id_3L0C";
          AddKeysToAgent = "yes";
        };

        "github.com-csug" = {
          HostName = "github.com";
          User = "git";
          IdentityFile = "~/.ssh/id_CSUG-Cole";
          AddKeysToAgent = "yes";
        };

        "codeberg.org" = {
          HostName = "codeberg.org";
          User = "git";
          IdentityFile = "~/.ssh/id_3L0C";
          AddKeysToAgent = "yes";
        };
      }
      // tailnetSettings;
  };

  services.ssh-agent.enable = true;
}
