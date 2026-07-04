{
  appimageTools,
  fetchurl,
  nix-update-script,
}: let
  pname = "shiru";
  version = "6.7.1";

  src = fetchurl {
    url = "https://github.com/RockinChaos/Shiru/releases/download/v${version}/linux-Shiru-v${version}.AppImage";
    hash = "sha256-ol/9fdRqGIFKhNq2Va0cUhyPIrSX9PCld2cU2BnQ+ng=";
  };

  appimageContents = appimageTools.extract {inherit pname version src;};
in
  appimageTools.wrapType2 {
    inherit pname version src;

    passthru.updateScript = nix-update-script {};

    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/shiru.desktop $out/share/applications/shiru.desktop
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/512x512/apps/shiru.png \
        $out/usr/share/icons/hicolor/512x512/apps/shiru.png
      substituteInPlace $out/share/applications/shiru.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=${pname}'
    '';
  }
