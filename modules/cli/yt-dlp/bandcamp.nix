{
  flake.modules.homeManager.yt-dlp = {
    xdg.configFile."yt-dlp/band.conf".text = ''
      # yt-dlp configuration for Bandcamp
      -o "~/Music/Bandcamp/%(uploader)s/%(album)s/%(track_number)02d - %(title)s.%(ext)s"

      --format "best[ext=mp3]/best[ext=flac]/best[ext=m4a]/best"

      --embed-metadata
      --add-metadata

      --embed-thumbnail
      --convert-thumbnails jpg

      --write-info-json
      --write-description

      --retries 3
      --fragment-retries 3

      # User agent to avoid blocks
      --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"

      --sleep-interval 1
      --max-sleep-interval 5

      --ignore-errors

      --write-annotations

      --embed-subs
      --convert-subs srt

      --no-mtime
    '';
  };
}
