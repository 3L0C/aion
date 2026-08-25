# River 0.4.x compositor with UWSM integration. River 0.4.x ships no window
# manager; the windowManager option supplies one (default: oxbow).
{
  flake.modules.nixos.river-uwsm =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.programs.river-uwsm;
    in
    {
      options.programs.river-uwsm = {
        enable = lib.mkEnableOption "River 0.4.x compositor with UWSM session management";

        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.river-no-session;
          defaultText = lib.literalExpression "pkgs.river-no-session";
          description = ''
            The River 0.4.x package to use. Defaults to river-no-session which has
            the plain river.desktop session file removed to prevent conflicts with
            the UWSM-managed river-uwsm.desktop session.
          '';
        };

        windowManager = lib.mkOption {
          type = lib.types.package;
          default = pkgs.oxbow;
          defaultText = lib.literalExpression "pkgs.oxbow";
          description = ''
            Window manager to install alongside River 0.4.x. River 0.4.x removed
            the built-in WM, so a separate WM speaking the rwm protocol is required
            (default: oxbow). This is installed system-wide; the home-manager
            side starts it as a session-scoped systemd service.
          '';
        };
      };

      config = lib.mkIf cfg.enable {
        environment.systemPackages = [
          cfg.package
          cfg.windowManager
        ];

        programs.uwsm = {
          enable = true;
          waylandCompositors.river = {
            prettyName = "River";
            comment = "River 0.4.x compositor managed by UWSM";
            binPath = lib.getExe cfg.package;
          };
        };
      };

      meta.maintainers = [ ];
    };
}
