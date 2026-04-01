{
  config,
  lib,
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
  security.pam.services = let
    u2fArgs = [
      "authfile=/etc/u2f_keys"
      "cue"
      "origin=pam://aion"
      "appid=pam://aion"
    ];
    u2fModulePath = "${pkgs.pam_u2f}/lib/security/pam_u2f.so";
  in {
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
}
