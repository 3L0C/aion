{
  xdg.configFile."yt-dlp/wsg-video.conf".text = ''
    -o ~/Videos/webms/youtube/%(title)s.%(ext)s

    --no-playlist

    -f "[filesize<=5M]"+bestaudio
  '';
}
