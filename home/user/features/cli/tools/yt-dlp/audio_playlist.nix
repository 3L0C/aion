{
  xdg.configFile."yt-dlp/audio_playlist.conf".text = ''
    -o "~/Music/tank/youtube/playlists/%(playlist)s/%(playlist_index)04d - %(title)s.%(ext)s"
    -f 'ba'
  '';
}
