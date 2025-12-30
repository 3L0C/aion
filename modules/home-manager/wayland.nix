{lib, ...}: {
  options.wayland.envVars = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = {};
    description = ''
      Wayland environment variables to be set by each compositor.
      These are not set globally to support mixed Wayland/X11 systems.
      Each compositor should apply these in its own startup mechanism.
    '';
  };
}
