{
  lib,
  stdenv,
  fetchgit,
  wayland,
  wayland-scanner,
  libxkbcommon,
}:
stdenv.mkDerivation {
  pname = "zrwm";
  version = "0-unstable-2026-04-30";

  src = fetchgit {
    url = "https://git.sr.ht/~zuki/zrwm";
    rev = "c02d8633214d3aa9e5790644efbfff187d83f3e6";
    hash = "sha256-tIMz/MKbFDVU1VImvuI8knuNm7iD3vYIQObznOyqqVE=";
  };

  nativeBuildInputs = [
    wayland-scanner
  ];

  buildInputs = [
    wayland
    libxkbcommon
  ];
  buildPhase = ''
    runHook preBuild
    $CC nob.c -o nob
    ./nob
    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall
    install -Dm755 zrwm $out/bin/zrwm
    install -Dm755 zrwm-msg $out/bin/zrwm-msg
    runHook postInstall
  '';

  meta = {
    description = "zuki's window manager for the river compositor (rwm protocol v3)";
    homepage = "https://git.sr.ht/~zuki/zrwm";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    mainProgram = "zrwm";
  };
}
