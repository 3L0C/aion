{
  lib,
  pkgs,
  fetchFromGitHub,
  unstableGitUpdater
}:
pkgs.mpvScripts.buildLua {
  pname = "mpv-jellyfin";
  version = "0-unstable-2025-08-05";
  scriptPath = "scripts/jellyfin.lua";

  src = fetchFromGitHub {
    owner = "EmperorPenguin18";
    repo = "mpv-jellyfin";
    rev = "15c94c843bb723e004da8ff4b2a22c7eda51f26e";
    hash = "sha256-dli/YNDSbPYgu3navhpSTiJn17dqRxISVPZpw9yzbNc=";
  };

  postPatch = ''
    substituteInPlace scripts/jellyfin.lua \
      --replace-fail '\"username\"' \
                     '\"Username\"'
  '';

  passthru.updateScript = unstableGitUpdater {  };

  meta = {
    description = "Script for mpv that turns it into a jellyfin client.";
    homepage = "https://github.com/EmperorPenguin18/mpv-jellyfin";
    license = lib.licenses.unlicense;
    maintainers = [ "3L0C" ];
  };
}
