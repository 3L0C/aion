{
  config,
  pkgs,
  ...
}: {
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
  services.pcscd.enable = true;

  # udev rules for non-root YubiKey access
  services.udev.packages = [pkgs.yubikey-personalization];
  security.pam.u2f = {
    enable = true;
    settings = {
      authfile = "/etc/u2f_keys";
      cue = true; # "Please touch the device" prompt
    };
  };
  security.pam.services = {
    greetd.u2fAuth = true;
    sudo.rules.auth.u2f = {
      order = 100; # Before unix_early (200) so U2F is tried first
      control = "sufficient";
      modulePath = "${pkgs.pam_u2f}/lib/security/pam_u2f.so";
      args = ["authfile=/etc/u2f_keys" "cue"];
    };
    hyprlock.u2fAuth = true;
    swaylock.u2fAuth = true;
  };
}
