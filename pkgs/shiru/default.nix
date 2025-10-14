{
  appimageTools,
  fetchurl
}:
let
  pname = "shiru";
  version = "6.1.12";

  src = fetchurl {
    url = "https://github.com/RockinChaos/Shiru/releases/download/v${version}/linux-Shiru-v${version}.AppImage";
    hash = "sha256-HMdIxzPv4MWysaFNoz12f1qMZx1g9lbyh/hpZOUAAtM=";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/shiru.desktop $out/share/applications/shiru.desktop
    install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/512x512/apps/shiru.png \
      $out/usr/share/icons/hicolor/512x512/apps/shiru.png
    substituteInPlace $out/share/applications/shiru.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
  '';
}
