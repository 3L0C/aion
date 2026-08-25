# Open-WebUI front-end for the local ollama server
{
  flake.modules.nixos.open-webui =
    {
      lib,
      pkgs,
      ...
    }:
    {
      services.open-webui = {
        enable = true;

        # Pin to stable. Unstable open-webui pulls ctranslate2 4.8.1, which has a
        # broken fixed-output hash and fails to build. Drop this override when
        # upstream fixes the hash.
        package = pkgs.stable.open-webui;

        host = "127.0.0.1";
        port = 8080;
        openFirewall = false;

        environment = {
          # Single-user localhost setup. To re-enable auth later, wipe the
          # open-webui data dir.
          WEBUI_AUTH = "False";
          OLLAMA_BASE_URL = "http://127.0.0.1:11434";
          ENABLE_OPENAI_API = "False";
          # Assignment to `environment` replaces the module's telemetry-off
          # defaults, so restate them.
          ANONYMIZED_TELEMETRY = "False";
          DO_NOT_TRACK = "True";
          SCARF_NO_ANALYTICS = "True";
        };
      };

      systemd.services.open-webui.wantedBy = lib.mkForce [ ];
    };
}
