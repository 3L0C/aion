{pkgs, ...}: {
  home.packages = with pkgs; [
    highlight # Fast and flexible source code highlighter - CLI version
    ffmpeg # Complete solution to record, convert and stream audio and video
    mkvtoolnix-cli # Set of tools to create, edit and inspect Matroska files
    html-tidy # A tool to tidy down your HTML code to a clear style
  ];
}
