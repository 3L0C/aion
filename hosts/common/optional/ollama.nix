{
  pkgs,
  lib,
  ...
}: {
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;

    # FIM-trained base variants, not instruct. Base variants give cleaner tab
    # completions than chat-tuned models.
    loadModels = [
      "qwen2.5-coder:14b-base"
      "qwen2.5-coder:7b-base"
    ];
    environmentVariables = {
      HIP_VISIBLE_DEVICES = "0";
      ROCR_VISIBLE_DEVICES = "0";
      OLLAMA_CONTEXT_LENGTH = "65536";
    };
  };

  # No autostart; keep the GPU free by default.
  systemd.services.ollama.wantedBy = lib.mkForce [];
  systemd.services.ollama-model-loader.wantedBy = lib.mkForce [];
}
