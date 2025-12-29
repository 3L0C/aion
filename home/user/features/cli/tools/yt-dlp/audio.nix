{
  xdg.configFile."yt-dlp/audio.conf".text = ''
    -o "~/Music/tank/youtube/%(uploader)s/%(title)s.%(ext)s"
    -f 'ba'
    --no-playlist
  '';
}
