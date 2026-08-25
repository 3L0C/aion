{
  pkgs,
  mpv-unwrapped,
}:
let
  inherit (mpv-unwrapped) src version;
in
pkgs.mpvScripts.buildLua {
  inherit src version;
  pname = "mpv-stats";

  dontUnpack = true;
  scriptPath = "${src}/player/lua/stats.lua";

  meta = {
    inherit (mpv-unwrapped.meta) license;
    homepage = "https://github.com/mpv-player/mpv/blob/v${version}/player/lua/stats.lua";
  };
}
