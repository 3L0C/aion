# Source: https://github.com/EmergentMind/nix-config/blob/dev/modules/common/host-spec.nix
{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.hostSpec = {
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

    # Keyboard options
    kbdModel = mkOption {
      type = types.str;
      description = "Keyboard model";
      default = "pc105";
    };
    kbdLayout = mkOption {
      type = types.str;
      description = "Keyboard layout";
      default = "us";
    };
    kbdVariant = mkOption {
      type = types.str;
      description = "Keyboard variant";
      default = "";
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

    # Compositor modifier keys (different compositors use different syntax)
    modifierKeys = mkOption {
      type = types.attrsOf types.str;
      default = {
        river = "Super";
        hyprland = "SUPER";
        niri = "Mod";
      };
      description = ''
        Modifier key(s) for window manager keybindings, per compositor.
        Different compositors use different syntax:
        - River: "Super", "Super+Control", "Shift+Control+Alt"
        - Hyprland: "SUPER", "SUPER_CONTROL", "SUPER_SHIFT"
        - Niri: "Mod", "Mod+Shift", "Mod+Ctrl" (Mod = Super on TTY, Alt in window)
      '';
      example = {
        river = "Super+Control";
        hyprland = "SUPER_CONTROL";
        niri = "Mod+Ctrl";
      };
    };
    primaryUser = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Primary administrator account name for the host";
      example = "user";
    };
    work = mkOption {
      type = types.attrsOf types.anything;
      default = {};
      description = "An attribute set of work-related information if isWork is true";
    };
  };
}
