{
  lib,
  python3Packages,
  fetchPypi,
  nix-update-script,
}:
python3Packages.buildPythonApplication rec {
  pname = "jellyproxy";
  version = "0.1.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-G3MwXFaTBDvuynJvAXQgs9dyXUUYVOKOaIb7w3Q3jVI=";
  };

  build-system = with python3Packages; [
    setuptools
    wheel
  ];

  dependencies = with python3Packages; [
    python-mpv-jsonipc
  ];

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    description = "A proxy that sits between jellyfin-mpv-shim and mpv to filter and control IPC commands";
    longDescription = ''
      JellyProxy prevents jellyfin-mpv-shim from overriding your carefully configured mpv settings
      by intercepting commands between JMS and mpv, letting you block unwanted changes while
      keeping the features you want.
    '';
    homepage = "https://github.com/johndovern/JellyProxy";
    license = licenses.gpl3Only;
    maintainers = [ (import ../_maintainers.nix).threeloc ];
    mainProgram = "jellyproxy";
    platforms = platforms.unix;
  };
}
