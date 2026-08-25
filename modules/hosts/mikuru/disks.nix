{ inputs, ... }: {
  flake.modules.nixos."hosts/mikuru" = {
    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices = {
      disk.main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_BLACK_SN770_1TB_24095Y811805";
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
                extraArgs = [
                  "-n"
                  "NIXBOOT"
                ];
                mountOptions = [
                  "fmask=0077"
                  "dmask=0077"
                ];
              };
            };
            root = {
              size = "100%";
              label = "NIXROOT";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                extraArgs = [
                  "-L"
                  "NIXROOT"
                ];
              };
            };
          };
        };
      };
    };
  };
}
