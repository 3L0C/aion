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
  tailnetMatchBlocks = lib.mapAttrs' (hostname: domain: {
    name = hostname;
    value = {
      hostname = "${hostname}.${domain}";
      user = "user";
      identityFile = "~/.ssh/id_3L0C";
      addKeysToAgent = "yes";
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
  sshKeySecrets = lib.listToAttrs (lib.flatten (map (name: [
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
    sshKeyNames));
in {
  # SSH keys deployed from sops secrets
  sops.secrets = sshKeySecrets;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    package = pkgs.stable.openssh;

    matchBlocks =
      {
        "codeberg.org-john" = {
          hostname = "codeberg.org";
          user = "git";
          identityFile = "~/.ssh/id_john";
          addKeysToAgent = "yes";
        };

        "codeberg.org-anon" = {
          hostname = "codeberg.org";
          user = "git";
          identityFile = "~/.ssh/id_anon-T430";
          addKeysToAgent = "yes";
        };

        "codeberg.org:anon" = {
          hostname = "codeberg.org";
          user = "git";
          identityFile = "~/.ssh/id_anon-T430";
          addKeysToAgent = "yes";
        };

        "codeberg.org-anskrevy" = {
          hostname = "codeberg.org";
          user = "git";
          identityFile = "~/.ssh/id_anskrevy";
          addKeysToAgent = "yes";
        };

        "codeberg.org:anskrevy" = {
          hostname = "codeberg.org";
          user = "git";
          identityFile = "~/.ssh/id_anskrevy";
          addKeysToAgent = "yes";
        };

        "github.com-john" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_john";
          addKeysToAgent = "yes";
        };

        "github.com-anon" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_anon-T430";
          addKeysToAgent = "yes";
        };

        "github.com-anskrevy" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_anskrevy";
          addKeysToAgent = "yes";
        };

        "openwrt" = {
          hostname = "192.168.1.1";
          port = 53920;
          user = "root";
          identityFile = "~/.ssh/openwrt";
          addKeysToAgent = "yes";
        };

        "vult-server" = {
          hostname = "45.77.184.169";
          port = 22;
          user = "root";
          identityFile = "~/.ssh/id_Cole";
          addKeysToAgent = "yes";
        };

        "aur.archlinux.org " = {
          identityFile = "~/.ssh/id_aur";
          user = "aur";
          addKeysToAgent = "yes";
        };

        "github.com-3L0C" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_3L0C";
          addKeysToAgent = "yes";
        };

        "github.com-csug" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_CSUG-Cole";
          addKeysToAgent = "yes";
        };
      }
      // tailnetMatchBlocks;
  };

  services.ssh-agent.enable = true;
  home.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
  };
}
