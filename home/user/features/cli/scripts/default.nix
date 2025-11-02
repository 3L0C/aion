{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs.custom.scripts;
    [
      nb # Nix build helper
      bs # Build script
      vidthumb # Video thumbnail generator
      doomemacs # Doom Emacs launcher
      hmpv # MPV helper
      wip-test # Test script
    ]
    ++ (builtins.filter lib.isDerivation (builtins.attrValues statusbar))
    ++ (builtins.filter lib.isDerivation (builtins.attrValues menu))
    ++ (builtins.filter lib.isDerivation (builtins.attrValues lf));
}
