{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave # Web browser that blocks ads and trackers by default (binary release)
    chromium # A web browser built for speed, simplicity, and security
    firefox # Fast, Private & Safe Web Browser
    librewolf # Community-maintained fork of Firefox, focused on privacy, security and freedom
    rofi # A window switcher, application launcher and dmenu replacement
    kdePackages.dolphin # KDE File Manager
    kdePackages.qtsvg # Add svg icon support to dolphin
    lf # A terminal file manager inspired by ranger
    chafa # Image-to-text converter supporting a wide range of symbols and palettes, transparency, animations, etc
    pcmanfm # Extremely fast and lightweight file manager
    vlc # Free and open source cross-platform multimedia player and framework
    supersonic # Lightweight cross-platform desktop client for Subsonic music servers
    feishin # Full-featured Subsonic/Jellyfin compatible desktop music player
    gimp3 # GNU Image Manipulation Program
    mupdf # Lightweight PDF and XPS viewer
    kdePackages.okular # Document Viewer
    sioyek # A PDF viewer designed for reading research papers and technical books
    gnucash # Personal and small-business financial-accounting application
    gnumeric # Spreadsheet application for GNOME
    thunderbird # Standalone mail and news reader from mozilla.org
    steam # Valve's digital software delivery system
    lutris # Open Gaming Platform

    kdePackages.filelight # View disk usage information
    gnome-disk-utility # Udisks graphical front-end
    slurp # Select a region in a Wayland compositor
    pavucontrol # PulseAudio Volume Control

    obs-studio
    pavucontrol
    soundwireserver
    video-trimmer
    vlc
    gnome-calculator # Application that solves mathematical equations
    mission-center # GUI resources monitor
    zenity # Tool to display dialogs from the commandline and shell scripts
  ];
}
