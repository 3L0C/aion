{
  flake.modules.homeManager.mpv = {pkgs, ...}: {
    programs.mpv.enable = true;

    # MPV helper scripts
    home.packages = with pkgs.custom.mpvUserScripts; [
      mpv-save # script to save mpv position on quit
      hmpv # wrapper for mpv-homehub script
    ];
  };
}
