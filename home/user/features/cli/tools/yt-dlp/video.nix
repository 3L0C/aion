{
  xdg.configFile."yt-dlp/video.conf".text = ''
    -o "~/Videos/webms/youtube/to-sort/%(uploader)s/%(title)s.%(ext)s"

    --no-playlist
  '';
}
