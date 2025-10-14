{
  lib,
  pkgs,
  fetchFromGitHub,
  unstableGitUpdater,
}:
pkgs.mpvScripts.buildLua {
  pname = "mpv-trackselect";
  version = "0-unstable-2023-08-01";
  scriptPath = "trackselect.lua";

  src = fetchFromGitHub {
    owner = "po5";
    repo = "trackselect";
    rev = "eed0627dff0906a7e594719e41055b23da599540";
    hash = "sha256-YtW2I6CuGfubZfgOBoSdlQ/YMQHi8FOKgzE4QhjSg38=";
  };

  passthru.updateScript = unstableGitUpdater {  };

  meta = {
    description = "Script for mpv to select tracks based on their title";
    homepage = "https://github.com/po5/trackselect";
    license = lib.licenses.mit;
    maintainers = [ "3L0C" ];
  };
}
