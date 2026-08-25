{
  stdenv,
  lib,
  fetchFromGitHub,
  unstableGitUpdater,
  bash,
  makeWrapper,
  mpv,
  jq,
  socat,
  perl,
}:
stdenv.mkDerivation {
  pname = "mpv-scripts";
  version = "0-unstable-2026-03-31";
  src = fetchFromGitHub {
    owner = "3L0C";
    repo = "mpv-scripts";
    rev = "9ee9cb09eb9249c3be4a15fa3bda6207eaae6a15";
    hash = "sha256-ycT9td4/HHheTUXfqwfLRGYOPCMcIuWr6++i2+t90/k=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [
    bash
    jq
    mpv
    socat
    perl
  ];

  installPhase = ''
    mkdir -p $out/bin

    # Copy all executable scripts
    find . -type f -executable | while read script; do
      script_name=$(basename "$script")
      cp "$script" "$out/bin/$script_name"
      chmod +x "$out/bin/$script_name"

      # Wrap each script with necessary PATH additions
      wrapProgram "$out/bin/$script_name" \
        --prefix PATH : ${
          lib.makeBinPath [
            bash
            jq
            mpv
            socat
            perl
          ]
        }
    done
  '';

  passthru.updateScript = unstableGitUpdater { };

  meta = with lib; {
    description = "Some scripts to interface with mpv via sockets";
    homepage = "https://github.com/3L0C/mpv-scripts";
    # Upstream has no LICENSE file. gpl3 is deprecated, so use the more
    # conservative gpl3Only per repo convention.
    license = licenses.gpl3Only;
    maintainers = [ (import ../_maintainers.nix).threeloc ];
    platforms = platforms.unix;
  };
}
