{
  config,
  lib,
  pkgs,
  ...
}: let
  riverctl = "${lib.getExe' pkgs.river-classic "riverctl"}";
  keyboardLayoutCmd = let
    model = config.userSpec.kbdModel;
    variant = config.userSpec.kbdVariant;
    options = config.userSpec.kbdOptions;
    layout = config.userSpec.kbdLayout;
  in
    lib.optionalString (options != "") ''
      ${riverctl} keyboard-layout \
        ${lib.optionalString (model != "") "-model \"${model}\""} \
        ${lib.optionalString (variant != "") "-variant \"${variant}\""} \
        -options "${options}" \
        "${layout}"
    '';
  settingsScript = pkgs.writeShellScript "river-settings" ''
    ${riverctl} default-attach-mode top
    ${riverctl} allow-tearing disabled
    ${riverctl} border-width 4
    ${riverctl} focus-follows-cursor normal
    ${riverctl} hide-cursor timeout 5000
    ${riverctl} hide-cursor when-typing enabled
    ${riverctl} set-cursor-warp on-output-change
    ${riverctl} set-repeat 50 300

    ${keyboardLayoutCmd}
    ${riverctl} xcursor-theme "${config.stylix.cursor.name}" ${toString config.stylix.cursor.size}
    ${riverctl} input "*Touchpad*" click-method button-areas
    ${riverctl} input "*Touchpad*" drag enabled
    ${riverctl} input "*Touchpad*" drag-lock enabled
    ${riverctl} input "*Touchpad*" disable-while-typing enabled
    ${riverctl} input "*Touchpad*" disable-while-trackpointing enabled
    ${riverctl} input "*Touchpad*" middle-emulation enabled
    ${riverctl} input "*Touchpad*" natural-scroll enabled
    ${riverctl} input "*Touchpad*" tap enabled
    ${riverctl} input "*Touchpad*" tap-button-map left-right-middle
    ${riverctl} input "*Touchpad*" scroll-method two-finger
  '';
in {
  systemd.user.services.river-settings = lib.custom.mkWaylandService {
    riverclassic = {
      Unit = {
        Description = "River Classic compositor settings";
        Documentation = "man:riverctl(1)";
      };

      Service = {
        Type = "oneshot";
        ExecStart = settingsScript;
        RemainAfterExit = true;
      };
    };
  };
}
