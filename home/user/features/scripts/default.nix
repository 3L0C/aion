{
  pkgs,
  lib,
  ...
}: let
  mkScript = name: file: pkgs.writeShellScriptBin name (builtins.readFile file);
  scriptsPath = lib.custom.relativeToRoot "pkgs/scripts";
in {
  home.packages = [
    (mkScript "nb" (scriptsPath + "/nix/nb"))
    (mkScript "bs" (scriptsPath + "/bin/bs"))
    (mkScript "vidthumb" (scriptsPath + "/utils/vidthumb"))
    (mkScript "doomemacs" (scriptsPath + "/doom/doomemacs"))
    (mkScript "hmpv" (scriptsPath + "/wip/hmpv"))
    (mkScript "wip-test" (scriptsPath + "/wip/wip-test"))
  ];
}
