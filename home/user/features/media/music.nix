{pkgs, ...}: {
  home.packages = with pkgs; [
    mpc # Minimalist command line interface to MPD
    ncmpcpp # Featureful ncurses based MPD client
  ];
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
  };
}
