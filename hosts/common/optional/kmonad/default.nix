# Kmonad keyboard remapping service
# Provides vim navigation, tap-hold modifiers, colemak-dhm, and extend layers
{
  services.kmonad = {
    enable = true;
    keyboards = {
      g16-internal = {
        device = "/dev/input/event5";
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = false;
        };
        config = builtins.readFile ./g16.kbd;
      };
    };
  };
}
