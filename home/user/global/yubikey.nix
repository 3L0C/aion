{
  config,
  lib,
  ...
}: {
  # YubiKey touch notification
  services.yubikey-touch-detector = lib.mkIf (config.hostSpec.kind != "headless") {
    enable = true;
    extraArgs = ["--libnotify"];
  };
}
