{pkgs, ...}: {
  programs.mpv = {
    scripts = [pkgs.custom.mpvScripts.streamsave];
    scriptOpts = {
      streamsave = {
        # General Options

        # Default writing directory is the current working directory.
        # Relative and absolute paths as well as ~/ and ~~/ meta paths are accepted.
        save_directory = "";
        # <ab|current|continuous|chapter|segments>
        dump_mode = "continuous";
        # <yes|no>
        fallback_write = "no";
        # <increment|range|timestamp|overwrite|chapter>
        output_label = "increment";

        # <.ext>
        force_extension = "";
        # <title>
        force_title = "";

        # <yes|no>
        range_marks = "no";
        track_packets = "no";

        # Automation Options

        # <yes|no>
        autostart = "no";
        # <no|HH:MM:SS>
        autoend = "no";

        # <yes|no>
        hostchange = "no";
        on_demand = "no";
        # <no|HH:MM:SS>
        quit = "no";

        # <yes|no>
        piecewise = "no";
      };
    };
  };
}
