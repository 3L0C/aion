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
      debug = true; # TEMP: Debug why U2F isn't prompting
      debug_file = "/tmp/pam_u2f.log";
    };
    control = "sufficient";
  };
  security.pam.services = {
    greetd.u2fAuth = true;
    sudo.u2fAuth = true;
    hyprlock.u2fAuth = true;
    swaylock.u2fAuth = true;
  };
}
