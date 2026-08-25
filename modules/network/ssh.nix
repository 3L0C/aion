{
  flake.modules.homeManager.ssh =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      inherit (config.home) homeDirectory;

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
          ]) sshKeyNames
        )
      );
    in
    {
      # SSH keys deployed from sops secrets
      sops.secrets = sshKeySecrets;
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        package = pkgs.stable.openssh;

        settings = {
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

          "github.com" = {
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
        };
      };

      services.ssh-agent.enable = true;
    };
}
