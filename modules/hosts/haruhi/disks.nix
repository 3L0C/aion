# Declarative disk partitioning for haruhi
{inputs, ...}: {
  flake.modules.nixos."hosts/haruhi" = {
    imports = [inputs.disko.nixosModules.disko];

    disko.devices = {
      disk.main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Samsung_SSD_990_EVO_Plus_2TB_S7U6NJ0XA00075N";
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
            luks = {
              size = "100%";
              label = "NIXLUKS";
              content = {
                type = "luks";
                name = "nixcrypt";
                askPassword = true;
                settings = {
                  allowDiscards = true;
                  crypttabExtraOpts = [
                    "fido2-device=auto"
                    "token-timeout=30"
                  ];
                };
                extraFormatArgs = [
                  "--label"
                  "NIXLUKS"
                ];
                content = {
                  type = "lvm_pv";
                  vg = "nix";
                };
              };
            };
          };
        };
      };
      lvm_vg.nix = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = "48G";
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true;
              extraArgs = [
                "-L"
                "NIXSWAP"
              ];
            };
          };
          root = {
            size = "100%FREE";
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
}
