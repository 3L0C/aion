{
  lib,
  pkgs,
  ...
}: {
  imports =
    (map lib.custom.relativeToRoot [
      "modules/nixos"
      "modules/common"
    ])
    ++ [
      ./home-manager.nix

      ./bootloader.nix
      ./fonts.nix
      ./hardening.nix
      ./locale.nix
      ./network.nix
      ./nix.nix
      ./secrets.nix
      ./security.nix
      ./udev.nix
    ];
  environment.systemPackages = with pkgs; [
    pciutils
  ];

  hardware.enableAllFirmware = true;
  documentation.man.generateCaches = true;
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
