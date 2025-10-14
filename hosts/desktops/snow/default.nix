{ localModulesPath, ... }: 
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
    ./mounts.nix
    ./syncthing.nix
    (localModulesPath + "/core")
    (localModulesPath + "/core/fixes/usb-wake-fix.nix") 
  ];
}
