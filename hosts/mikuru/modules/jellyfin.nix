# Jellyfin media server with AMD GPU transcoding
{pkgs, ...}: {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  # The jellyfin user needs access to the render devices for GPU transcoding.
  users.users.jellyfin.extraGroups = ["render" "video" "media"];

  # VA-API for hardware transcoding on the RX 6600 XT.
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
}
