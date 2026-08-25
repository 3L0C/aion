{
  flake.modules = {
    # YubiKey/FIDO2 authentication for PAM login and sudo
    nixos.yubikey =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        # U2F keys shared across hosts via sops.
        # Generate: pamu2fcfg -u user > /tmp/u2f_keys (repeat with -n for more keys),
        # then add to ~/aion-secrets/hosts/common/secrets.yaml as "u2f_keys".
        sops.secrets.u2f_keys = {
          sopsFile = config.sops.commonSecretsFile;
          path = "/etc/u2f_keys";
          mode = "0644";
        };

        environment.systemPackages = with pkgs; [
          yubikey-personalization # ykinfo CLI
          yubikey-manager # ykman CLI
          libfido2 # fido2-token CLI + libraries
          pam_u2f # PAM module
        ];

        # Smart card daemon for PIV/CCID operations
        services.pcscd.enable = true;

        # udev rules for non-root YubiKey access
        services.udev.packages = [ pkgs.yubikey-personalization ];

        # Policy: sudo accepts the YubiKey alone (sufficient); greetd and swaylock
        # require password plus YubiKey (required).
        security.pam.services =
          let
            u2fArgs = [
              "authfile=/etc/u2f_keys"
              "cue"
              "origin=pam://aion"
              "appid=pam://aion"
            ];
            u2fModulePath = "${pkgs.pam_u2f}/lib/security/pam_u2f.so";
          in
          {
            sudo.rules.auth.u2f = {
              enable = lib.mkForce true;
              order = 100;
              control = "sufficient";
              modulePath = u2fModulePath;
              args = u2fArgs;
            };
            greetd.rules.auth.u2f = {
              enable = lib.mkForce true;
              order = 100;
              control = lib.mkForce "required";
              modulePath = u2fModulePath;
              args = u2fArgs;
            };
            swaylock.rules.auth.u2f = {
              enable = lib.mkForce true;
              order = 100;
              control = lib.mkForce "required";
              modulePath = u2fModulePath;
              args = u2fArgs;
            };
          };
      };

    # YubiKey touch notification
    homeManager.yubikey =
      {
        config,
        lib,
        ...
      }:
      {
        services.yubikey-touch-detector = lib.mkIf (config.hostSpec.kind != "headless") {
          enable = true;
          extraArgs = [ "--libnotify" ];
        };
      };
  };
}
