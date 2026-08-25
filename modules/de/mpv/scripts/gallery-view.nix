{
  flake.modules.homeManager.mpv = { pkgs, ... }: {
    programs.mpv = {
      # Gallery-view scripts for mpv
      scripts = [ pkgs.mpvScripts.mpv-gallery-view ];
      bindings = {
        "g" = "script-binding playlist_view/playlist-view-toggle";
      };
      scriptOpts = {
        contact_sheet = {
          # mpv-gallery-view | https://github.com/occivink/mpv-gallery-view
          # This is the settings file for scripts/contact-sheet.lua
          # File placement: script-opts/contact_sheet.conf
          # Settings which are also present in script-opts/playlist_view.conf are only documented in that file
          # Defaults: https://github.com/occivink/mpv-gallery-view/blob/master/script-opts/contact_sheet.conf

          # on Windows:
          #thumbs_dir=%APPDATA%\mpv\gallery-thumbs-dir
          #generate_thumbnails_with_mpv=yes
          # everywhere else:
          #thumbs_dir=~/.cache/thumbnails/mpv-gallery
          #generate_thumbnails_with_mpv=no

          # create thumbs_dir if it doesn't exist
          # mkdir_thumbs=yes

          gallery_position = "{ (ww - gw) / 2, (wh - gh) / 2}";
          gallery_size = "{ 9 * ww / 10, 9 * wh / 10 }";
          min_spacing = "{ 15, 15 }";
          thumbnail_size = "(ww * wh <= 1366 * 768) and {192, 108} or {288, 162}";
          max_thumbnails = "64";

          # timespan between two thumbnails
          # can either be a percentage of the video duration or a number of seconds
          time_distance = "2%";

          # in chapter mode, a thumbnail is shown for every chapter, instead of regular intervals
          chapter_mode = "no";
          # time offset in seconds from the start of the chapter, to take the thumbnail
          # to deal with fades to black
          chapter_mode_time_offset = "2";
          # if the video does not have chapters, fall back to using time steps
          chapter_mode_fallback_to_time_steps = "yes";

          # seek to the currently selected time when the contact-sheet is toggled off
          seek_on_toggle_off = "no";
          # close the contact-sheet when seeking to a particular thumbnail
          close_on_seek = "yes";
          # pause the current video when the contact-sheet is opened
          pause_on_start = "yes";
          # resume the current video when the contact-sheet is closed
          resume_on_stop = "only-if-did-pause";

          # unlike in playlist-view, this can be set to "selection", "everywhere" or "no"
          show_text = "selection";
          show_millisecond_precision = "yes";
          text_size = "28";

          background_color = "333333";
          background_opacity = "33";
          normal_border_color = "BBBBBB";
          normal_border_size = "1";
          selected_border_color = "E5E4E5";
          selected_border_size = "6";
          highlight_previous = "yes";
          previous_border_color = "EBC5A7";
          previous_border_size = "4";
          placeholder_color = "222222";

          command_on_open = "";
          command_on_close = "";

          # enables mousewheel navigation and click-to-select
          mouse_support = "yes";
          # the bindings when the contact sheet is active, their meaning should be self-explanatory
          UP = "UP";
          DOWN = "DOWN";
          LEFT = "LEFT";
          RIGHT = "RIGHT";
          PAGE_UP = "PGUP";
          PAGE_DOWN = "PGDWN";
          FIRST = "HOME";
          LAST = "END";
          RANDOM = "r";
          ACCEPT = "ENTER";
          CANCEL = "ESC";
        };

        gallery_worker = {
          # mpv-gallery-view | https://github.com/occivink/mpv-gallery-view
          # This is the settings file for scripts/gallery-thumbgen.lua and its copies
          # File placement: script-opts/gallery_worker.conf
          # Defaults: https://github.com/occivink/mpv-gallery-view/blob/master/script-opts/gallery_worker.conf

          # accepts a |-separated list of URL patterns which gallery.lua should thumbnail using youtube-dl.
          # The patterns are matched after the http(s):// part of the URL.
          #^ matches the beginning of the URL, $ matches its end, and you should use % before any of the characters ^$()%|,.[]*+-? to match that character.
          #
          #Examples
          #  will exclude any URL that starts with http://youtube.com or https://youtube.com:
          #     ytdl_exclude=^youtube%.com
          #  will exclude any URL that ends with .mkv or .mp4:
          #     ytdl_exclude=%.mkv$|%.mp4$
          #  See more lua patterns here: https://www.lua.org/manual/5.1/manual.html#5.4.1
          #
          #See also: ytdl_hook-exclude in mpv's manpage.
          ytdl_exclude = "";
        };

        playlist_view = {
          # mpv-gallery-view | https://github.com/occivink/mpv-gallery-view
          # This is the settings file for scripts/playlist-view.lua
          # File placement: script-opts/playlist_view.conf
          # Defaults: https://github.com/occivink/mpv-gallery-view/blob/master/script-opts/playlist_view.conf

          # thumbnail directory in which to create and look for thumbnails
          # on Unix-like platforms:
          #thumbs_dir=~/.cache/thumbnails/mpv-gallery
          # on Windows:
          #thumbs_dir=%APPDATA%\mpv\gallery-thumbs-dir
          # note that not all env vars get expanded, only '~' and 'APPDATA' do

          # create thumbs_dir if it doesn't exist
          # mkdir_thumbs=yes

          # use mpv instead of ffmpeg for thumbnail generation
          # slightly slower and does not support transparency, but does not require additional ffmpeg/ffprobe executables
          # yes on Windows, no on other plateforms
          #generate_thumbnails_with_mpv=no

          # all options below are platform-independent

          # fine-grained controls for the geometry of the gallery
          # each option can have a fixed value, or dynamic by using the following variables:
          # ww, wh: mpv window width, mpv window height (always available)
          # gx, gy: gallery horizontal position, gallery vertical position
          # gw, gh: gallery width, gallery height
          # sw, sh: minimum spacing width, minimum spacing height
          # tw, th: thumbnail width, thumbnail height
          # these strings are interpreted using the lua equivalent of "eval" so math functions and logical conditions can be used
          # if an option references variables, they will be computed in the appropriate order
          # (for example, if gallery_width == 5 * thumbnail_width, thumbnail_size will be computed before gallery_size)
          # in case of cyclical dependencies, the script will abort
          # example
          # -------
          # make the gallery centered
          gallery_position = "{ (ww - gw) / 2, (wh - gh) / 2 }";
          # make the gallery's size 9/10 the size of the window
          gallery_size = "{ 9 * ww / 10, 9 * wh / 10 }";
          # with at least 15 pixels of spacing between each thumbnail
          min_spacing = "{ 15, 15 }";
          # and two thumbnail size presets for Windows smaller/bigger than 1366 x 768
          thumbnail_size = "(ww * wh <= 1366 * 768) and {192, 108} or {288, 162}";
          # it is recommended to use discrete increments for thumbnail_size since a new thumbnail needs to be generated for each size

          # limit the number of thumbnails visible, even if more could be shown
          # 64 is the maximum due to limitations in mpv
          max_thumbnails = "64";

          # the position in the file at which to take the thumbnail
          # can either be a percentage of the video duration, or a number of seconds
          take_thumbnail_at = "20%";

          # load to the selected video when the playlist-view is toggled off
          load_file_on_toggle_off = "no";
          # close the playlist-view when loading a video
          close_on_load_file = "yes";
          # pause the current video when the playlist-view is opened
          pause_on_start = "yes";
          # resume the current video when the playlist-view is closed
          # can be yes, no, or only-if-did-pause
          # in the latter case, will only resume if the video was actually paused by opening the playlist-view
          resume_on_stop = "only-if-did-pause";
          # automatically start the playlist-view when mpv is started
          start_on_mpv_startup = "no";
          # automatically start the playlist-view when the current file is finished
          # only has an effect when keep-open=always
          start_on_file_end = "yes";
          # if the currently playing file changes, set the selection to the new one
          follow_playlist_position = "no";
          # when loading a file, remember the time-position of the previous
          # and restart from there if it's loaded again
          remember_time_position = "yes";

          # show the filename below each thumbnail
          show_text = "yes";
          # use the playlist title if it exists instead of the filename
          show_title = "yes";
          strip_directory = "yes";
          strip_extension = "yes";
          text_size = "28";

          # colors are defined in hexadecimal in Blue Green Red (BGR) order
          # if multiple colors should be active, they get evenly blended
          # opacity is defined between 00 (opaque) and FF (transparent)
          background_color = "333333";
          background_opacity = "33";
          normal_border_color = "BBBBBB";
          normal_border_size = "1";
          selected_border_color = "E5E4E5";
          selected_border_size = "6";
          # show a special border around the currently playing file
          highlight_active = "yes";
          active_border_color = "EBC5A7";
          active_border_size = "4";
          flagged_border_color = "96B58D";
          flagged_border_size = "4";
          placeholder_color = "222222";

          # arbitrary commands that are run when the playlist-view is opened/closed
          # this can be used for lowering video settings when the gallery is active, since
          # high-quality video settings can result in slowdown of the gallery
          command_on_open = "";
          command_on_close = "";

          # the path of the 'flags' file that is written when you exit mpv
          flagged_file_path = "./mpv_gallery_flagged";

          mouse_support = "yes";
          UP = "UP";
          DOWN = "DOWN";
          LEFT = "LEFT";
          RIGHT = "RIGHT";
          PAGE_UP = "PGUP";
          PAGE_DOWN = "PGDWN";
          FIRST = "HOME";
          LAST = "END";
          RANDOM = "r";
          ACCEPT = "ENTER";
          CANCEL = "ESC";
          # this only removes entries from the playlist, not the underlying file
          REMOVE = "DEL";
          FLAG = "SPACE";
        };
      };
    };
  };
}
