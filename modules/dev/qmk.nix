# QMK Firmware Development: Keyboard Customization
# Tools for building and flashing custom mechanical keyboard firmware
{
  flake.modules.homeManager.dev = {pkgs, ...}: {
    home.packages = with pkgs; [
      qmk # CLI tool for customizing supported mechanical keyboards
    ];
  };
}
