{pkgs, ...}: {
  programs.mpv = {
    scripts = [pkgs.custom.mpvScripts.sub-select];
    scriptOpts = {
      sub_select = {
        force_enable = "yes";
        select_audio = "no";
        observe_audio_switches = "no";
        explicit_forced_subs = "no";
        config = "~~/script-opts";
      };
    };
  };

  xdg.configFile = {
    "mpv/script-opts/sub-select.json".text = ''
      [
          {
              "alang": [ "j[ap]n?" ],
              "slang": [ "eng?", "und", "jpn?" ],
              "blacklist": [
                  "sings/songs",
                  "signs?",
                  "songs?",
                  "english %(translation only%)",
                  "signs & songs",
                  "s&s"
              ]
          },
          {
              "alang": "eng?",
              "slang": "eng?",
              "whitelist": [ "sign", "song" ]
          },
          {
              "alang": [ "eng?", "no" ],
              "slang": "no"
          },
          {
              "alang": "*",
              "slang": "eng?"
          },
          {
              "alang": "*",
              "slang": "und"
          },
          {
              "alang": "*",
              "slang": "forced"
          }
      ]
    '';
  };
}
