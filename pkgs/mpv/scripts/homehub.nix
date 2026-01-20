{
  lib,
  pkgs,
  fetchFromGitHub,
  unstableGitUpdater,
}:
pkgs.mpvScripts.buildLua {
  pname = "mpv-homehub";
  version = "0-unstable-2026-01-20";
  scriptPath = ".";

  src = fetchFromGitHub {
    owner = "3L0C";
    repo = "mpv-homehub";
    rev = "3e6aa619b7651dfed1931845ac8e86bbe575611e";
    hash = "sha256-6y14xiKd+RQM6fiHDSCCiNfcOdH/UjffyG3DaxzhgLs=";
  };

  passthru.updateScript = unstableGitUpdater {};

  meta = {
    description = "Script for mpv that turns it into a client for various home media services.";
    homepage = "https://github.com/EmperorPenguin18/mpv-homehub";
    license = lib.licenses.gpl3Plus;
    maintainers = ["3L0C"];
  };
}
