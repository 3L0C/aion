# Virtual "Noise Canceling Source" microphone with RNNoise. Input only;
# output is untouched. RNNoise requires 48000 Hz.
{pkgs, ...}: {
  # PipeWire 1.6's filter-graph LADSPA loader resolves `plugin` against
  # LADSPA_PATH and appends `.so`. The field must be a library name only,
  # and the package must be on LADSPA_PATH.
  services.pipewire.extraLadspaPackages = [pkgs.rnnoise-plugin.ladspa];

  services.pipewire.extraConfig.pipewire."99-input-denoising" = {
    "context.modules" = [
      {
        name = "libpipewire-module-filter-chain";
        args = {
          "node.description" = "Noise Canceling Source";
          "media.name" = "Noise Canceling Source";
          "filter.graph" = {
            nodes = [
              {
                type = "ladspa";
                name = "rnnoise";
                plugin = "librnnoise_ladspa";
                label = "noise_suppressor_mono";
                control = {
                  "VAD Threshold (%)" = 80.0;
                  "VAD Grace Period (ms)" = 200;
                  "Retroactive VAD Grace (ms)" = 0;
                };
              }
            ];
          };
          "capture.props" = {
            "node.name" = "capture.rnnoise_source";
            "node.passive" = true;
            "audio.rate" = 48000;
          };
          "playback.props" = {
            "node.name" = "rnnoise_source";
            "media.class" = "Audio/Source";
            "audio.rate" = 48000;
          };
        };
      }
    ];
  };
}
