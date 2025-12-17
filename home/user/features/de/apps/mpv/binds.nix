{
  programs.mpv.bindings = {
    # Save and quit
    "Q" = "run \"mpv-save\" \"\${path}\" \"\${working-directory}\" ; quit-watch-later";
    "CTRL+q" = "quit-watch-later";

    # Better speed controls
    "]" = "add speed +0.25";
    "[" = "add speed -0.25";

    # Default but needed(?) after using custom osc.lua with thumbnailer
    "DEL" = "script-message osc-visibility cycle";

    # Play/Pause binds
    "MBTN_LEFT" = "cycle pause ; run \"mpv-track\" \"\${input-ipc-server}\"";
    "SPACE" = "cycle pause ; run \"mpv-track\" \"\${input-ipc-server}\"";
    "MBTN_RIGHT" = "cycle fullscreen";

    # Looping
    "y" = "ab-loop";
    "CTRL+L" = "ab-loop"; # set/clear A-B loop points
    "L" = "cycle-values loop-file \"inf\" \"no\""; # toggle infinite looping
    "CTRL+l" = "cycle-values loop-playlist \"inf\" \"no\"";

    # Play/Pause/Skip using right hand nav keys
    "h" = "seek -2";
    "H" = "seek -5";
    "J" = "add chapter -1";
    "K" = "add chapter 1";
    "l" = "seek 10";

    # seek-to.lua
    "ctrl+g" = "script-message-to seek_to toggle-seeker";

    # Debanding keybind
    "b" = "cycle-values deband \"yes\" \"no\"";
    "i" = "cycle interpolation";
    "D" = "cycle deinterlace";

    # Video sync toggle (disable for files with PTS issues causing choppiness)
    "R" = "cycle-values video-sync \"display-resample\" \"audio\"; show-text \"video-sync: \${video-sync}\"";

    # Volume
    "AXIS_UP" = "add volume 5";
    "AXIS_DOWN" = "add volume -5";
    "WHEEL_UP" = "add volume 5";
    "WHEEL_DOWN" = "add volume -5";

    # Skipping
    "RIGHT" = "seek 10";
    "LEFT" = " seek -5";
    "CTRL+WHEEL_UP" = "seek 10";
    "CTRL+WHEEL_DOWN" = "seek -10";
    "MBTN_FORWARD" = "seek 5";
    "MBTN_BACK" = "seek -5";

    # Next/Prev file
    "Enter" = "playlist-next";
    "ctrl+enter" = "playlist-prev";

    # Subtitle Track change
    "s" = "cycle sub";

    # Subtitle scaling
    "F" = "add sub-scale -0.1";
    "B" = "add sub-scale +0.1";

    # Audio Track change
    "a" = "cycle audio";

    # Screenshot WITH subs
    "S" = "async screenshot";

    # Screenshot WITHOUT subs
    "ctrl+s" = "screenshot video";
    "e" = "script-binding stats/display-stats";
    "E" = "script-binding stats/display-stats-toggle";

    # Show cached video
    "j" = "show-text \"\${demuxer-cache-time}\"";
    "alt+a" = "run \"yt-opts\" \"-aw\" \"\${path}\"; show-text \"downloading audio for webms\"";
    "alt+A" = "run \"yt-opts\" \"-a\" \"\${path}\"; show-text \"downloading audio\"";
    "alt+v" = "run \"yt-opts\" \"-v\" \"\${path}\"; show-text \"downloading video\"";
    "alt+p" = "run \"yt-opts\" \"-ap\" \"\${path}\"; show-text \"downloading audio playlist\"";
    "alt+P" = "run \"yt-opts\" \"-vp\" \"\${path}\"; show-text \"downloading video playlist\"";
    "alt+m" = "run \"notify-send\" \"mpv-message\" \"media-title: \${media-title}\\nfilename: \${filename}\\npath: \${path}\"";
    "alt+w" = "run \"wsg2ytdlp-mpv\" \"\${path}\" \"\${media-title}\"; show-text \"downloading webm\"";
    "alt+W" = "run \"wsg2ytdlp-mpv-playlist\" \"\${pid}\" ; show-text \"downloading webm playlist\"";
    "alt+u" = "run \"mpv2ytdlp-playlist\" \"umpv_socket\" ; show-text \"downloading youtube playlist\"";
    "alt+x" = "run \"webm2audio\" \"\${path}\"; show-text \"ripping webm audio\"";
    "alt+r" = "run \"mpv-rename\" \"-a\" \"\${filename}\" \"\${path}\" \"\${pid}\" \"\${media-title}\"; show-text \"renaming webm\"";
    "alt+R" = "run \"mpv-rename\" \"-m\" \"\${filename}\" \"\${path}\" \"\${pid}\"; show-text \"manually renaming webm\"";
    "M" = "show-text \"File marked\"; run \"mpv-tracker\" \"\${path}\"";
    "ctrl+m" = "show-text \"Saved to playlist\"; run \"mpv-playlist\" \"--mark\" \"\${path}\"";
  };
}
