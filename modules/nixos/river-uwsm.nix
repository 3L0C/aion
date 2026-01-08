{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.river-uwsm;
in {
  options.programs.river-uwsm = {
    enable = lib.mkEnableOption "River compositor with UWSM session management";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.river-classic-no-session;
      defaultText = lib.literalExpression "pkgs.river-classic-no-session";
      description = ''
        The River package to use. Defaults to river-classic-no-session which has
        the plain river.desktop session file removed to prevent conflicts with
        the UWSM-managed river-uwsm.desktop session.
      '';
    };

    extraPackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = with pkgs; [
        swaylock
        foot
        dmenu
      ];
      defaultText = lib.literalExpression "with pkgs; [ swaylock foot dmenu ]";
      example = lib.literalExpression "with pkgs; [ alacritty rofi ]";
      description = ''
        Extra packages to be installed system-wide for use with River.
        This is passed through to {option}`programs.river-classic.extraPackages`.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    programs.river-classic = {
      enable = true;
      package = null;
      inherit (cfg) extraPackages;
    };
    environment.systemPackages = [cfg.package];
    programs.uwsm = {
      enable = true;
      waylandCompositors.river = {
        prettyName = "River";
        comment = "River compositor managed by UWSM";
        binPath = lib.getExe cfg.package;
      };
    };
  };

  meta.maintainers = [];
}
