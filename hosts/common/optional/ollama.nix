{
  pkgs,
  lib,
  ...
}: {
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    loadModels = [
      "qwen2.5-coder:14b-base"
      "qwen2.5-coder:7b-base"
    ];
    environmentVariables = {
      HIP_VISIBLE_DEVICES = "0";
      ROCR_VISIBLE_DEVICES = "0";
    };
  };
  systemd.services.ollama.wantedBy = lib.mkForce [];
  systemd.services.ollama-model-loader.wantedBy = lib.mkForce [];
}
