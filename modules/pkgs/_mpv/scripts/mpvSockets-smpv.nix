{
  lib,
  pkgs,
  fetchFromGitHub,
  unstableGitUpdater,
}:
pkgs.mpvScripts.buildLua {
  pname = "mpv-mpvSockets-smpv";
  version = "0-unstable-2025-01-05";
  scriptPath = "mpvSockets.lua";

  src = fetchFromGitHub {
    owner = "3L0C";
    repo = "mpvSockets-smpv";
    rev = "1688ee0b9215e9ee73bb35971dd80f10d58221f4";
    hash = "sha256-E39wj2GasqjWDShrb+tGyOuPZsoFacemZs5a/TFsGqg=";
  };

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    description = "Fork of mpvSockets made compatible with umpv and more";
    homepage = "https://github.com/3L0C/mpvSockets-smpv";
    license = lib.licenses.mit;
    maintainers = [ (import ../../_maintainers.nix).threeloc ];
  };
}
