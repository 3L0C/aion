{
  lib,
  pkgs,
  enablePlaylistView ? true,
  enableContactSheet ? true,
}:
pkgs.mpvScripts.mpv-gallery-view.overrideAttrs (oldAttrs: {
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
  installPhase = ''
    runHook preInstall
    mkdir -p "$out/share/mpv/scripts"
    cp -a gallery-view "$out/share/mpv/scripts/gallery-view"
    runHook postInstall
  '';
  dontFixup = false;

  scriptPath = "gallery-view";
  passthru = {
    inherit (oldAttrs.passthru) updateScript;
    scriptName = "gallery-view";
  };

  meta =
    oldAttrs.meta
    // {
      description = "Gallery-view scripts for mpv";
      longDescription = ''
        mpv-gallery-view provides a gallery view for mpv that allows you to
        navigate through multiple files in a grid-like interface.

        Enabled components:
        ${lib.optionalString enablePlaylistView "- Playlist view interface"}
        ${lib.optionalString enableContactSheet "- Contact sheet grid view"}
      '';
      maintainers = [(import ../../maintainers.nix).threeloc];
    };
})
