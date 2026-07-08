{
  lib,
  stdenv,
  fetchFromGitLab,
  nix-update-script,
  pkg-config,
  wayland,
  wayland-scanner,
  pixman,
}:
stdenv.mkDerivation rec {
  pname = "river-shifttags";
  version = "0.2.2";

  src = fetchFromGitLab {
    owner = "akumar-xyz";
    repo = "river-shifttags";
    rev = version;
    hash = "sha256-SzzFnhbDi9jKS/rjsWyIfUkX4wP1TRs/y4N+El/OW4U=";
  };

  patches = [
    ./patches/add-send-view-mode.patch
  ];

  nativeBuildInputs = [
    pkg-config
    wayland-scanner
  ];

  buildInputs = [
    wayland
    pixman
  ];
  makeFlags = [
    "PREFIX=${placeholder "out"}"
    "SCANNER=wayland-scanner"
  ];
  installFlags = [
    "DESTDIR=${placeholder "out"}"
  ];
  installPhase = ''
    runHook preInstall
    make install PREFIX=/ DESTDIR=$out
    runHook postInstall
  '';

  passthru.updateScript = nix-update-script {};

  meta = with lib; {
    description = "A small utility for the river Wayland compositor to rotate the focused tags";
    longDescription = ''
      river-shifttags enables navigation between tags for the river Wayland compositor.
      It can rotate multiple focused tags simultaneously and has an option to skip unoccupied tags.

      This package includes a patch adding --send-view mode to move the focused view to
      rotated tags instead of switching focused tags.
    '';
    homepage = "https://gitlab.com/akumar-xyz/river-shifttags";
    license = licenses.gpl3Plus;
    maintainers = [(import ../maintainers.nix).threeloc];
    mainProgram = "river-shifttags";
    platforms = platforms.linux;
  };
}
