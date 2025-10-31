# QMK Firmware Development: Keyboard Customization
# Tools for building and flashing custom mechanical keyboard firmware
{pkgs, ...}: {
  home.packages = with pkgs; [
    qmk # CLI tool for customizing supported mechanical keyboards
  ];
}
