{
  lib,
  pkgs,
  fetchFromGitHub,
  unstableGitUpdater,
}:
pkgs.mpvScripts.buildLua {
  pname = "mpv-persist-properties";
  version = "0-unstable-2022-11-15";
  scriptPath = "persist-properties.lua";

  src = fetchFromGitHub {
    owner = "d87";
    repo = "mpv-persist-properties";
    rev = "ddb1e6bd7a7d57da9b567ea8dc5227906f416ec6";
    hash = "sha256-C2nejhkxAZgfKRl9FrZZqODq2xW6zCbv/sBiqXSAd2k=";
  };

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    description = "Keeps selected property values (like volume) between player sessions";
    homepage = "https://github.com/d87/mpv-persist-properties";
    license = lib.licenses.mit;
    maintainers = [ (import ../../_maintainers.nix).threeloc ];
  };
}
