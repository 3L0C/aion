{pkgs, ...}: {
  home.packages = with pkgs; [
    pamixer # Pulseaudio command line mixer
    pulsemixer # CLI and curses mixer for pulseaudio
    playerctl # mpris media player controller and lib for spotify, vlc, audacious, bmp, xmms2, and others
    alsa-utils # Advanced Linux Sound Architecture - Utilities
    alsa-plugins # Additional ALSA plugins
  ];
}
