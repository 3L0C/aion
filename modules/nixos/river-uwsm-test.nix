{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.river-uwsm-test;
in {
  options.programs.river-uwsm-test = {
    enable = lib.mkEnableOption "River compositor with UWSM session management (test version with GPU reset fix)";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.river-classic-test-no-session;
      defaultText = lib.literalExpression "pkgs.river-classic-test-no-session";
      description = ''
        The River test package to use. Defaults to river-classic-test-no-session which
        includes the GPU reset fix patch and has the plain river.desktop session file
        removed to prevent conflicts with the UWSM-managed session.
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
        binPath = "/run/current-system/sw/bin/river";
      };
    };
  };

  meta.maintainers = [];
}
