{
  stdenv,
  lib,
  fetchFromGitHub,
  bash,
  makeWrapper,
  mpv,
  jq,
  socat,
  perl,
}:
stdenv.mkDerivation {
  pname = "mpv-scripts";
  version = "666ee5c";
  src = fetchFromGitHub {
    owner = "3L0C";
    repo = "mpv-scripts";
    rev = "666ee5ce5f229b7695bb73a9e40e445584d5bbf4";
    sha256 = "sha256-zcMjIH1Tb/Aw1Lb6ZtFsoP7Qc+0yvFlt0LkFJ6FwqtM=";
  };

  nativeBuildInputs = [makeWrapper];
  buildInputs = [bash jq mpv socat perl];

  installPhase = ''
    mkdir -p $out/bin

    # Copy all executable scripts
    find . -type f -executable | while read script; do
      script_name=$(basename "$script")
      cp "$script" "$out/bin/$script_name"
      chmod +x "$out/bin/$script_name"

      # Wrap each script with necessary PATH additions
      wrapProgram "$out/bin/$script_name" \
        --prefix PATH : ${lib.makeBinPath [bash jq mpv socat perl]}
    done
  '';

  meta = with lib; {
    description = "Some scripts to interface with mpv via sockets";
    homepage = "https://github.com/3L0C/mpv-scripts";
    license = licenses.gpl3;
    maintainers = ["3L0C"];
    platforms = platforms.unix;
  };
}
