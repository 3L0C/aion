{
  lib,
  pkgs,
  ...
}: {
  services.open-webui = {
    enable = true;
    package = pkgs.stable.open-webui;

    host = "127.0.0.1";
    port = 8080;
    openFirewall = false;

    environment = {
      WEBUI_AUTH = "False";
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
      ENABLE_OPENAI_API = "False";
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
    };
  };
  systemd.services.open-webui.wantedBy = lib.mkForce [];
}
