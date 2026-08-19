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
in
  appimageTools.wrapType2 {
    inherit pname version src;
    extraPkgs = pkgs: [pkgs.libva];
  }
