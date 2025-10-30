{
  lib,
  pkgs,
  ...
}: {
  imports =
    (map lib.custom.relativeToRoot ["modules/nixos" "modules/common"])
    ++ [
      ./nix.nix
      ./locale.nix
      ./network.nix
      ./security.nix
      ./fonts.nix
      ./program.nix
      ./services.nix
      ./udev.nix
      ./bootloader.nix
    ];
  environment.systemPackages = with pkgs; [
    pciutils
  ];

  hardware.enableAllFirmware = true;
  services.speechd.enable = false;
  services.irqbalance.enable = true;
  systemd = {
    services.journalctl-vacuum = {
      description = "Vacuum journalctl logs";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.systemd}/bin/journalctl --vacuum-time=23d";
      };
    };
    timers.journalctl-vacuum = {
      wantedBy = ["timers.target"];
      partOf = ["journalctl-vacuum.service"];
      timerConfig.OnCalendar = "weekly";
    };

    services.irqbalance.serviceConfig.ProtectKernelTunables = "no";
  };
}
