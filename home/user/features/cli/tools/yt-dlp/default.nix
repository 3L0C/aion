{
  lib,
  pkgs,
  ...
}: let
  # Generate a yt-dlp config at ~/.config/yt-dlp/<name>.conf.
  #   output:     exact -o argument (include quotes where wanted)
  #   format:     -f value (wrapped in single quotes); null emits the
  #               commented-out quality placeholder instead
  #   noPlaylist: append --no-playlist (default true)
  mkYtdlpConf = {
    name,
    output,
    format ? null,
    noPlaylist ? true,
  }: {
    name = "yt-dlp/${name}.conf";
    value.text =
      ''
        -o ${output}

      ''
      + (
        if format != null
        then ''
          -f '${format}'
        ''
        else ''
          #-f "bv*+ba/b"
        ''
      )
      + lib.optionalString noPlaylist ''

        --no-playlist
      '';
  };

  ytdlpConfs = [
    {
      name = "audio";
      output = ''"~/Music/tank/youtube/%(uploader)s/%(title)s.%(ext)s"'';
      format = "ba";
    }
    {
      name = "audio_playlist";
      output = ''"~/Music/tank/youtube/playlists/%(playlist)s/%(playlist_index)04d - %(title)s.%(ext)s"'';
      format = "ba";
      noPlaylist = false;
    }
    {
      name = "audio-soundcloud";
      output = "~/Music/tank/non-vaporwave/s/Soundcloud/%(title)s.%(ext)s";
      format = "140";
    }
    {
      name = "audio_webm";
      output = ''"~/Music/tank/wsg-worthy/%(uploader)s/%(title)s.%(ext)s"'';
      format = "ba";
      noPlaylist = false;
    }
    {
      name = "audio-webms";
      output = "~/Music/tank/wsg-worthy/%(title)s.%(ext)s";
      format = "140";
    }
    {
      name = "audio-webms-playlist";
      output = "~/Music/tank/youtube/playlists/%(title)s.%(ext)s";
      format = "ba";
      noPlaylist = false;
    }
    {
      name = "video";
      output = ''"~/Videos/webms/youtube/to-sort/%(uploader)s/%(title)s.%(ext)s"'';
    }
    {
      name = "video_playlist";
      output = ''"~/Videos/webms/youtube/playlists/to-sort/%(playlist)s/%(playlist_index)04d - %(title)s.%(ext)s"'';
      noPlaylist = false;
    }
  ];
in {
  imports = [
    ./band.nix
    ./chapters.nix
    ./wsg-video.nix
  ];

  xdg.configFile = builtins.listToAttrs (map mkYtdlpConf ytdlpConfs);

  home.packages = with pkgs; [
    yt-dlp # A youtube-dl fork with additional features and fixes
  ];
}
