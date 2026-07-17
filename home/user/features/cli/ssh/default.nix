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
    "id_anon-T430"
    "id_anskrevy"
    "id_aur"
    "id_Cole"
    "id_CSUG-Cole"
    "id_deb-mount"
    "id_debVPN"
    "id_ed25519_sk"
    "id_ed25519_sk_2"
    "id_john"
    "id_openwrt"
    "id_rsa"
    "id_rsa_an0nym0ous"
    "id_ssh_server"
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
        "codeberg.org-john" = {
          HostName = "codeberg.org";
          User = "git";
          IdentityFile = "~/.ssh/id_john";
          AddKeysToAgent = "yes";
        };

        "codeberg.org-anon" = {
          HostName = "codeberg.org";
          User = "git";
          IdentityFile = "~/.ssh/id_anon-T430";
          AddKeysToAgent = "yes";
        };

        "codeberg.org:anon" = {
          HostName = "codeberg.org";
          User = "git";
          IdentityFile = "~/.ssh/id_anon-T430";
          AddKeysToAgent = "yes";
        };

        "codeberg.org-anskrevy" = {
          HostName = "codeberg.org";
          User = "git";
          IdentityFile = "~/.ssh/id_anskrevy";
          AddKeysToAgent = "yes";
        };

        "codeberg.org:anskrevy" = {
          HostName = "codeberg.org";
          User = "git";
          IdentityFile = "~/.ssh/id_anskrevy";
          AddKeysToAgent = "yes";
        };

        "github.com-john" = {
          HostName = "github.com";
          User = "git";
          IdentityFile = "~/.ssh/id_john";
          AddKeysToAgent = "yes";
        };

        "github.com-anon" = {
          HostName = "github.com";
          User = "git";
          IdentityFile = "~/.ssh/id_anon-T430";
          AddKeysToAgent = "yes";
        };

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

        "vult-server" = {
          HostName = "45.77.184.169";
          Port = 22;
          User = "root";
          IdentityFile = "~/.ssh/id_Cole";
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
  home.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
  };
}
