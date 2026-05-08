{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.river-classic-uwsm;
in {
  options.programs.river-classic-uwsm = {
    enable = lib.mkEnableOption "River Classic compositor with UWSM session management";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.river-classic-no-session;
      defaultText = lib.literalExpression "pkgs.river-classic-no-session";
      description = ''
        The River Classic package to use. Defaults to river-classic-no-session which
        has the plain river.desktop session file removed and the binary renamed to
        `river-classic` so it can coexist with the river 0.4.x package.
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
        Extra packages to be installed system-wide for use with River Classic.
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
      waylandCompositors.river-classic = {
        prettyName = "River Classic";
        comment = "River Classic compositor managed by UWSM";
        binPath = lib.getExe (pkgs.writeShellScriptBin "river-classic" ''
          exec ${lib.getExe cfg.package} -c "$HOME/.config/river-classic/init"
        '');
      };
    };
  };

  meta.maintainers = [];
}
