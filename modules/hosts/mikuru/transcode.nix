# VA-API for hardware transcoding on the RX 6600 XT.
{
  flake.modules.nixos."hosts/mikuru" = { pkgs, ... }: {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        libva
        libva-utils
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "radeonsi";
    };
  };
}
