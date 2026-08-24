{
  flake.modules.homeManager.mpv = {
    lib,
    pkgs,
    ...
  }: {
    programs.mpv.config = {
      # GENERAL
      osc = true;
      correct-pts = true;
      cursor-autohide = 1500;
      input-ar-delay = 500;
      input-ar-rate = 20;
      input-default-bindings = true;
      input-doubleclick-time = 200;
      msg-color = false;
      msg-module = true;
      msg-level = "input=error,demux=error";
      ytdl = true;
      load-stats-overlay = false;

      # AUDIO
      # ad-queue-enable = true;
      volume = 100;
      ad = "lavc:libdcadec";
      ad-lavc-threads = 0;
      ad-queue-max-bytes = "32MiB";
      ad-queue-max-samples = 96000;
      ad-queue-max-secs = 2;
      ao = "pipewire";
      audio-exclusive = false;
      audio-format = "s32";
      audio-pitch-correction = true;
      # audio-samplerate = 96000;
      autosync = 30;
      # af = "scaletempo2";

      # LANG
      alang = "'ja,jpn,en,eng'";

      # SUBS
      demuxer-readahead-secs = 10;
      sub-ass-force-margins = true;
      sub-ass-override = "force";
      sub-font-size = 48;
      sub-color = "#FFFFFFFF";
      sub-border-size = 2;
      sub-border-color = "#000000";
      sub-pos = 95;
      sub-margin-y = 90;
      sub-auto = "fuzzy";
      sub-file-paths = "subs:sub:subtitles:Subtitles:Subs:Sub";
      sub-scale-with-window = true;
      sub-ass-scale-with-window = true;

      # VIDEO
      vd-lavc-threads = 0;
      vd-queue-max-bytes = "2GiB";
      vd-queue-max-samples = 60;
      vd-queue-max-secs = 2;

      # VIDEO PROFILE
      profile = "gpu-hq";
      hwdec = "auto";
      gpu-api = "vulkan";
      vo = "gpu-next";

      # COLORS
      # target-prim = "auto";
      # target-trc = "auto";
      # tone-mapping = "reinhard";
      # tone-mapping-desaturate = "0.9";
      # tone-mapping-desaturate-exponent = "0";
      # hdr-compute-peak = false;
      # gamut-clipping = false;

      # ON SCREEN DISPLAY
      osd-bar = false;
      osd-font-size = 36;
      osd-bold = false;

      #VLC Screenshots
      screenshot-template = "~/Pictures/mpv/vlcsnap-%F-T%wH.%wM.%wS.%wT-F%{estimated-frame-number}v%#01n";
      screenshot-format = "png";

      # WINDOW
      keep-open = true;
      force-window = "yes";
      taskbar-progress = true;
      window-dragging = false;

      # CACHE
      cache-pause-initial = false;
      cache-pause = false;
      demuxer-max-bytes = 150000000; # 150 MB
      demuxer-max-back-bytes = 75000000; # 75 MB
      demuxer-seekable-cache = true;
      force-seekable = true;
      cache = true;
      demuxer-lavf-buffersize = 524288; # Bytes
      gpu-shader-cache-dir = "~~/shaders/shader-cache-dir/";
      icc-cache-dir = "~~/icc/icc-cache-dir/";
      stream-buffer-size = "5MiB"; # KiB, MiB

      # SCALE
      video-sync = "display-resample";

      # Youtube-dl to yt-dlp
      script-opts = "ytdl_hook-ytdl_path=${lib.getExe pkgs.yt-dlp}";

      # Loop playlist
      loop-playlist = "inf";
    };
  };
}
