# Media Processing Tools
# Command-line tools for video/audio processing, syntax highlighting, and HTML
# formatting These are development and content creation utilities
{
  flake.modules.homeManager.media = { pkgs, ... }: {
    home.packages = with pkgs; [
      ffmpeg # Complete solution to record, convert and stream audio and video
      mkvtoolnix-cli # Set of tools to create, edit and inspect Matroska files
      custom.scripts.media # Unified media player controller (mpc, mpv, playerctl)
      custom.scripts.converter-sh # Convert a screen recording to GIF and muted WebM.
    ];
  };
}
