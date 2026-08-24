{
  appimageTools,
  fetchurl,
}: let
  pname = "openshot-qt";
  version = "3.5.1";

  src = fetchurl {
    url = "https://github.com/OpenShot/openshot-qt/releases/download/v${version}/OpenShot-v${version}-x86_64.AppImage";
    hash = "sha256-L/eiWW5SRsOVsIxA/YbSeMDLReS/fumSdCO6MvH02I0=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
  appimageTools.wrapAppImage {
    inherit pname version;
    src = appimageContents;
    extraPkgs = pkgs: [pkgs.libva];
    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/org.openshot.OpenShot.desktop \
        $out/share/applications/org.openshot.OpenShot.desktop
      substituteInPlace $out/share/applications/org.openshot.OpenShot.desktop \
        --replace-fail 'Exec=openshot-qt-launch %F' 'Exec=openshot-qt %F'
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/512x512/apps/openshot-qt.png \
        $out/share/icons/hicolor/512x512/apps/openshot-qt.png
    '';
    passthru.src = src;
  }
