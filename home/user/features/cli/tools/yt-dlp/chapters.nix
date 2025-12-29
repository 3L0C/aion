{
  xdg.configFile."yt-dlp/chapters.conf".text = ''
    --split-chapters
    -f "bv*+ba/b"
    -P "/tmp/yt-dlp"
    -o "chapter:~/Videos/webms/youtube/playlists/%(uploader)s/%(title)s/%(section_number)02d - %(section_title)s.%(ext)s"
  '';
}
