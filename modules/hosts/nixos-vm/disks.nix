{inputs, ...}: {
  flake.modules.nixos."hosts/nixos-vm" = {
    imports = [inputs.disko.nixosModules.disko];

    disko.devices = {
      disk.main = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              label = "NIXBOOT";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                extraArgs = ["-n" "NIXBOOT"];
                mountOptions = ["fmask=0077" "dmask=0077"];
              };
            };
            root = {
              size = "100%";
              label = "NIXROOT";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                extraArgs = ["-L" "NIXROOT"];
              };
            };
          };
        };
      };
    };
  };
}
