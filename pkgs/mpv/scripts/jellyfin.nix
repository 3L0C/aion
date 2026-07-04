{
  lib,
  pkgs,
  fetchFromGitHub,
  unstableGitUpdater,
}:
pkgs.mpvScripts.buildLua {
  pname = "mpv-jellyfin";
  version = "1.2-unstable-2026-03-22";
  scriptPath = "scripts/jellyfin.lua";

  src = fetchFromGitHub {
    owner = "EmperorPenguin18";
    repo = "mpv-jellyfin";
    rev = "ff3e8f2cd301b0c789ad36d03bc3cc03bba61615";
    hash = "sha256-bC9suv/wuxFk3rhIKMsv6Bwcag9wkWkphh8g32wDlno=";
  };

  passthru.updateScript = unstableGitUpdater {};

  meta = {
    description = "Script for mpv that turns it into a jellyfin client.";
    homepage = "https://github.com/EmperorPenguin18/mpv-jellyfin";
    license = lib.licenses.unlicense;
    maintainers = [(import ../../maintainers.nix).threeloc];
  };
}
