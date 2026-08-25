# Wayland option schema plus the user-level Wayland utilities.
{
  flake.modules.homeManager.hm-wayland =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.wayland.envVars = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = { };
        description = ''
          Wayland environment variables to be set by each compositor.
          These are not set globally to support mixed Wayland/X11 systems.
          Each compositor should apply these in its own startup mechanism.
        '';
      };

      config = {
        wayland.envVars = {
          QT_QPA_PLATFORM = "wayland";
          SDL_VIDEODRIVER = "wayland";
          XDG_SESSION_TYPE = "wayland";
          GDK_BACKEND = "wayland";
          MOZ_ENABLE_WAYLAND = "1";
          ELECTRON_OZONE_PLATFORM_HINT = "auto";
          NIXOS_OZONE_WL = "1";
        }
        // lib.optionalAttrs (config.userSpec.kbdOptions != "") {
          XKB_DEFAULT_OPTIONS = config.userSpec.kbdOptions;
        };

        home.packages = with pkgs; [
          master.wf-recorder # Utility program for screen recording of wlroots-based compositors
          wl-clipboard # Command-line copy/paste utilities for Wayland
          wlr-randr # Xrandr clone for wlroots compositors
        ];

        xdg = {
          configFile = {
            "electron-flags.conf".text = ''
              --enable-features=UseOzonePlatform
              --ozone-platform=wayland
            '';

            "uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
          };
          portal.config.common.default = "*";
        };
      };
    };
}
