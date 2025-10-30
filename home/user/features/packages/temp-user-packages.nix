{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pamixer # Pulseaudio command line mixer
    foot # Fast, lightweight, and minimalistic Wayland terminal emulator
    kitty # A modern, hackable, featureful, OpenGL-based terminal emulator

    gimp3 # GNU Image Manipulation Program
    chafa # Image-to-text converter supporting a wide range of symbols and palettes, transparency, animations, etc
    grim # Screenshot utility for Wayland

    kdePackages.kdenlive # A non-linear video editor for Linux using the MLT video framework
    obs-studio # Free, open source software for live streaming and recording

    gnucash # Personal and small-business financial-accounting application
    gnumeric # Spreadsheet application for GNOME

    thunderbird # Standalone mail and news reader from mozilla.org

    htop-vim # Interactive process viewer with a Vim keybindings patch

    pamixer # Pulseaudio command-line mixer like amixer
    pulsemixer # CLI and curses mixer for pulseaudio
    playerctl # mpris media player controller and lib for spotify, vlc, audacious, bmp, xmms2, and others
    lxappearance # Feature-rich GTK+ theme switcher of the LXDE Desktop
    libsForQt5.qt5ct # Qt5 Configuration Utility
    kdePackages.qt6ct # Qt 6 Configuration Utility
    nwg-look # GTK settings editor adapted to work on wlroots-based compositors
    font-manager # A simple font management application for GTK+ Desktop Environments
    qbittorrent # An advanced BitTorrent client programmed in C++, based on Qt toolkit and libtorrent-rasterbar
    gallery-dl # Command-line program to download image-galleries and collections from several image hosting sites
    yt-dlp # A youtube-dl fork with additional features and fixes
    glow # Command-line markdown renderer
    virt-manager # Desktop user interface for managing virtual machines
    virt-viewer # A lightweight interface for interacting with the graphical display of virtualized guest OS
    wl-clipboard # Command-line copy/paste utilities for Wayland

    keepassxc # Cross-platform community-driven port of Keepass password manager
    seahorse # GNOME application for managing PGP keys
    gnome-keyring # Stores passwords and encryption keys

    mullvad-vpn # The Mullvad VPN client app for desktop
    veracrypt # Disk encryption with strong security based on TrueCrypt
    ncmpcpp # Featureful ncurses based MPD client inspired by ncmpc
    mpc # Minimalist command line interface to MPD
    android-file-transfer # Android MTP client with minimalistic UI
    scrcpy # Display and control your Android device

    ffmpegthumbnailer # Lightweight video thumbnailer that can be used by file managers
    epub-thumbnailer # EPUB e-books thumbnailer for file managers that make use of python-pillow
    xchm # Viewer for CHM files (GUI front-end to chmlib)

    xdg-desktop-portal # Desktop integration portals for sandboxed apps
    xdg-desktop-portal-gtk # A backend implementation for xdg-desktop-portal using GTK
    kdePackages.xdg-desktop-portal-kde # A backend implementation for xdg-desktop-portal using Qt/KF5
    xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots
  ];
}
