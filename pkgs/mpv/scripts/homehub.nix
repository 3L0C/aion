{
  lib,
  pkgs,
  fetchFromGitHub,
  unstableGitUpdater,
}:
pkgs.mpvScripts.buildLua {
  pname = "mpv-homehub";
  version = "0-unstable-2026-02-07";
  scriptPath = ".";

  src = fetchFromGitHub {
    owner = "3L0C";
    repo = "mpv-homehub";
    rev = "dee0a18186ef8008a01653fe38b1ce8599d31edb";
    hash = "sha256-s89WQglVjtb6B/ESsjE7VDNpi95JXWZQscZlGsRl1kk=";
  };

  passthru.updateScript = unstableGitUpdater {};

  meta = {
    description = "Script for mpv that turns it into a client for various home media services.";
    homepage = "https://github.com/3L0C/mpv-homehub";
    license = lib.licenses.gpl3Plus;
    maintainers = [(import ../../maintainers.nix).threeloc];
  };
}
