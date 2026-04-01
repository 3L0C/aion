{pkgs, ...}: {
  home.packages = with pkgs; [
    ffmpeg # Complete solution to record, convert and stream audio and video
    mkvtoolnix-cli # Set of tools to create, edit and inspect Matroska files
    html-tidy # A tool to tidy down your HTML code to a clear style
    custom.scripts.media # Unified media player controller (mpc, mpv, playerctl)
    custom.scripts.converter-sh # Convert a screen recording to GIF and muted WebM.
  ];
}
