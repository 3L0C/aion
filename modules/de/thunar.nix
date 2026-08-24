{
  flake.modules.nixos.thunar = {pkgs, ...}: {
    programs.thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    # Persist preferences outside of XFCE
    programs.xfconf.enable = true;

    # Thumbnail support for images
    services.tumbler.enable = true;
  };
}
