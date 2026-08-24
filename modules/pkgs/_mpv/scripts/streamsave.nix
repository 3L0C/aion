{
  lib,
  pkgs,
  fetchFromGitHub,
  unstableGitUpdater,
}:
pkgs.mpvScripts.buildLua {
  pname = "mpv-streamsave";
  version = "0.28.0-unstable-2024-07-18";
  scriptPath = "streamsave.lua";

  src = fetchFromGitHub {
    owner = "Sagnac";
    repo = "streamsave";
    rev = "e2ab499783a74fd23b909462c9b12234794ada94";
    hash = "sha256-7szlRFGrPS+tC7j3G6FuR/UpKvC3FWqIcHKW2PWFDpo=";
  };

  passthru.updateScript = unstableGitUpdater {};

  meta = {
    description = "mpv script aimed at saving live streams and clipping online videos without encoding.";
    homepage = "https://github.com/Sagnac/streamsave";
    license = lib.licenses.mit;
    maintainers = [(import ../../_maintainers.nix).threeloc];
  };
}
