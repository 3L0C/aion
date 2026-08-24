{
  lib,
  pkgs,
}:
pkgs.mpvScripts.buildLua {
  pname = "mpv-filename";
  version = "1.0.0";

  # Point to your local Lua script
  scriptPath = "./lua/filename.lua";

  # Use local file instead of fetching from GitHub
  src = ./.;

  meta = {
    description = "Filename script for mpv";
    license = lib.licenses.unlicense;
    maintainers = [(import ../../_maintainers.nix).threeloc];
  };
}
