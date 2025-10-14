{ lib, pkgs, host, ... }:
let
  scriptTypes = {
    universal = [ "bin" "utils" "text" "system" "nix" ];
    desktop = [ "media" "gui" ];
    laptop = [ "battery" "power" "wifi" ];
    wm = [ "statusbar" "screenshot" "wallpaper" ];
    gaming = [ "gaming" "steam" ];
    media = [ "mpv" "audio" "video" ];
    dev = [ "dev" "git" "docker" "emacs" "doom" ];
    server = [ "backup" "monitoring" "network" ];
  };
  unique = lib.unique;
  flatten = lib.flatten;
  combine = types: unique (flatten (map (type: scriptTypes.${type} or []) types));
  withExtras = base: extras: unique (base ++ extras);
  without = base: toRemove: builtins.filter (x: !(builtins.elem x toRemove)) base;
  scriptDirectoriesByHost = {
    snow = combine [ "universal" "desktop" "wm" "media" "gaming" "dev" ];
    laptop1 = combine [ "universal" "desktop" "laptop" "wm" "dev" ];
    work-laptop = withExtras
      (combine [ "universal" "desktop" "laptop" "wm" ])
      [ "work-vpn" "company-tools" ];
    minimal-laptop = without
      (combine [ "universal" "desktop" "laptop" "wm" ])
      [ "media" ];
    home-server = combine [ "universal" "server" "media" ];
    build-server = withExtras
      (combine [ "universal" "server" ])
      [ "build-tools" "deployment" ];
  };
  scriptDirectories = scriptDirectoriesByHost.${host} or scriptTypes.universal;
  makeScript = name: file: pkgs.writeShellScriptBin name file;
  makeScriptsFromDir = dir:
    let
      fileTypes = builtins.readDir dir;
      allFiles = builtins.attrNames fileTypes;
      scriptFiles = builtins.filter (fileName:
        let
          isRegularFile = fileTypes.${fileName} == "regular";
        in
          isRegularFile && lib.hasPrefix "#!" (
            builtins.readFile (dir + "/${fileName}")
          )
      ) allFiles;
    in
      builtins.listToAttrs (map (scriptFile:
        let
          src = builtins.readFile (dir + "/${scriptFile}");
        in {
          name = scriptFile;
          value = makeScript scriptFile src;
        }
      ) scriptFiles);
  allScripts = lib.foldl' (acc: dirName:
    let
      dirPath = ./. + "/${dirName}";
    in
      if builtins.pathExists dirPath
      then acc // (makeScriptsFromDir dirPath)
      else acc
  ) {} scriptDirectories;

  scripts = builtins.attrValues allScripts;
in
{
  home.packages = scripts;
  home.sessionPath = [
    "$HOME/nixos-config/modules/home/scripts/wip"
  ];
}
