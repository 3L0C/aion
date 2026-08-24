{
  flake.modules.homeManager.yt-dlp = {
    xdg.configFile."yt-dlp/wsg-video.conf".text = ''
      -o ~/Videos/YouTube/%(title)s.%(ext)s

      --no-playlist

      -f "[filesize<=5M]"+bestaudio
    '';
  };
}
