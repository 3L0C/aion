# Source: https://github.com/EmergentMind/nix-config/blob/dev/modules/common/host-spec.nix
{
  flake.modules = let
    module = {lib, ...}: {
      options.hostSpec = let
        inherit (lib) mkOption types;
      in {
        name = mkOption {
          type = types.str;
          description = "The name of the host";
        };

        kind = mkOption {
          type = types.enum [
            "desktop"
            "laptop"
            "headless"
          ];
          description = "The kind of host";
        };

        isWork = mkOption {
          type = types.bool;
          default = false;
          description = "Whether the host is used for work";
        };

        cpuThermalZone = mkOption {
          type = types.nullOr types.int;
          description = "Thermal zone to use for CPU temp monitoring";
          default = null;
        };

        hasDiscreteGPU = mkOption {
          type = types.bool;
          default = false;
          description = "Whether the host has a discrete GPU";
        };

        wlanInterface = mkOption {
          type = types.nullOr types.str;
          description = "The name of the wireless LAN interface, if applicable";
          default = null;
        };

        ethernetInterface = mkOption {
          type = types.nullOr types.str;
          description = "The name of the ethernet interface, if applicable";
          default = null;
        };

        cpuHwmonPath = mkOption {
          type = types.nullOr types.str;
          description = "Absolute path to CPU temperature hwmon directory";
          default = null;
          example = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
        };

        cpuTempInput = mkOption {
          type = types.str;
          description = "Temperature input filename in hwmon directory";
          default = "temp1_input";
          example = "temp3_input";
        };

        primaryUser = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "Primary administrator account name for the host";
          example = "user";
        };

        domain = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "DNS domain this host serves; proxy hostnames are <service>.<domain>";
          example = "example.com";
        };

        mediaRoot = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "Root directory of the media library";
          example = "/mnt/tank/data/media";
        };

        torrentsRoot = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = "Root directory for torrent downloads";
          example = "/mnt/tank/data/torrents";
        };

        # Data only; does not dictate configuration settings
        work = mkOption {
          type = types.attrsOf types.anything;
          default = {};
          description = "An attribute set of work-related information if isWork is true";
        };
      };
    };
  in {
    nixos.host-spec = module;
    homeManager.host-spec = module;
  };
}
