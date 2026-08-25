# Kmonad keyboard remapping service
# Provides vim navigation, tap-hold modifiers, colemak-dhm, and extend layers
{
  flake.modules.nixos.kmonad =
    { config, ... }:
    let
      inherit (config.home-manager.users.${config.hostSpec.primaryUser}) userSpec;
    in
    {
      assertions = [
        {
          assertion = userSpec.kmonadDevice != null;
          message = "userSpec.kmonadDevice must be set when using kmonad";
        }
        {
          assertion = userSpec.kmonadConfig != null;
          message = "userSpec.kmonadConfig must be set when using kmonad";
        }
      ];

      services.kmonad = {
        enable = true;
        keyboards = {
          main = {
            device = userSpec.kmonadDevice;
            defcfg = {
              enable = true;
              fallthrough = true;
              allowCommands = false;
            };
            config = userSpec.kmonadConfig;
          };
        };
      };
    };
}
