{
  flake.modules.homeManager.monitors =
    {
      lib,
      config,
      ...
    }:
    let
      inherit (lib) types mkOption;

      monitorOption = types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            example = "eDP-1";
          };
          primary = mkOption {
            type = types.bool;
            default = false;
          };
          width = mkOption {
            type = types.int;
            example = 1920;
          };
          height = mkOption {
            type = types.int;
            example = 1080;
          };
          refreshRate = mkOption {
            type = types.float;
            default = 60.0;
          };
          autoResolution = mkOption {
            type = types.bool;
            default = true;
            description = "Use highres@highrr (auto) or explicit width/height/refreshRate";
          };
          position = mkOption {
            type = types.str;
            default = "auto";
            example = "1920x0";
          };
          x = mkOption {
            type = types.int;
            default = 0;
            example = 1080;
          };
          y = mkOption {
            type = types.int;
            default = 0;
            example = 1920;
          };
          scale = mkOption {
            type = types.str;
            default = "auto";
          };
          enabled = mkOption {
            type = types.bool;
            default = true;
          };
          # OLED burn-in mitigation: enables automatic bar position rotation
          isOLED = mkOption {
            type = types.bool;
            default = false;
            description = "Enable OLED burn-in mitigation";
          };
          workspaces = mkOption {
            type = types.listOf types.str;
            default = [ ];
            example = [
              "1"
              "2"
              "3"
            ];
          };
          transform = mkOption {
            type = types.str;
            default = "normal";
            example = "flipped-90";
          };
          extraArgs = mkOption {
            type = types.nullOr types.str;
            default = null;
          };
        };
      };
      layoutOverrideOption = types.submodule {
        options = {
          x = mkOption {
            type = types.int;
            example = 2560;
          };
          y = mkOption {
            type = types.int;
            default = 0;
          };
        };
      };
    in
    {
      options = {
        monitors = mkOption {
          type = types.listOf monitorOption;
          default = [ ];
        };

        monitorLayouts = mkOption {
          type = types.attrsOf (types.attrsOf layoutOverrideOption);
          default = { };
          description = ''
            Named alternate monitor layouts. Each entry maps an output name
            to {x, y} position overrides applied on top of the base `monitors`
            config. Switch at runtime with `kanshictl switch <name>`.
          '';
        };

        primaryMonitor = mkOption {
          type = types.nullOr monitorOption;
          readOnly = true;
          default = lib.findFirst (m: m.primary) null config.monitors;
        };
      };

      config = {
        assertions = [
          {
            assertion =
              ((lib.length config.monitors) != 0)
              -> ((lib.length (lib.filter (m: m.primary) config.monitors)) == 1);
            message = "Exactly one monitor must be set to primary.";
          }
        ];
      };
    };
}
