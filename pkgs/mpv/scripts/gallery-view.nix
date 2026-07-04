{
  lib,
  pkgs,
  fetchFromGitHub,
  unstableGitUpdater,
  enablePlaylistView ? true,
  enableContactSheet ? true,
}:
pkgs.mpvScripts.buildLua {
  pname = "mpv-gallery-view";
  version = "0-unstable-2024-09-27";

  src = fetchFromGitHub {
    owner = "occivink";
    repo = "mpv-gallery-view";
    rev = "4a8e664d52679fff3f05f29aa7a54b86150704bc";
    hash = "sha256-u4PQtTKdE357G1X+Ag0Dexd/jhmZVsAXxdUgEp8bMPw=";
  };

  postPatch = ''
    # Create the script directory structure
    mv scripts gallery-view

    # Create main.lua that loads only the enabled components
    cat > gallery-view/main.lua << 'EOF'
    -- mpv-gallery-view main entry point
    -- This file loads the enabled components based on nix build configuration

    -- Load gallery-thumbgen
    script_dir = mp.get_script_directory()
    mp.commandv("load-script", script_dir .. "/gallery-thumbgen.lua")

    ${lib.optionalString enablePlaylistView ''
      -- Load playlist-view
      mp.commandv("load-script", script_dir .. "/playlist-view.lua")
    ''}

    ${lib.optionalString enableContactSheet ''
      -- Load contact-sheet
      mp.commandv("load-script", script_dir .. "/contact-sheet.lua")
    ''}
    EOF

    # Copy enabled script files to the directory
    mv script-modules gallery-view/

    ${lib.optionalString enablePlaylistView ''
      substituteInPlace gallery-view/playlist-view.lua \
        --replace-fail "~~/script-modules/?.lua;" \
                        "$out/share/mpv/scripts/gallery-view/script-modules/?.lua;"
    ''}

    ${lib.optionalString enableContactSheet ''
      substituteInPlace gallery-view/contact-sheet.lua \
        --replace-fail "~~/script-modules/?.lua;" \
                        "$out/share/mpv/scripts/gallery-view/script-modules/?.lua;"
    ''}
  '';

  scriptPath = "gallery-view";

  passthru.updateScript = unstableGitUpdater {};

  meta = {
    description = "Gallery-view scripts for mpv";
    longDescription = ''
      mpv-gallery-view provides a gallery view for mpv that allows you to
      navigate through multiple files in a grid-like interface.

      Enabled components:
      ${lib.optionalString enablePlaylistView "- Playlist view interface"}
      ${lib.optionalString enableContactSheet "- Contact sheet grid view"}
    '';
    homepage = "https://github.com/occivink/mpv-gallery-view";
    license = lib.licenses.unlicense;
    maintainers = [(import ../../maintainers.nix).threeloc];
  };
}
