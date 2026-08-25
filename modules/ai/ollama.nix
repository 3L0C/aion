# Ollama LLM server on 127.0.0.1:11434. The GPU package variant and
# the device pin are host slices (see modules/hosts/yuki/ollama.nix).
{
  flake.modules.nixos.ollama = { lib, ... }: {
    services.ollama = {
      enable = true;

      # FIM-trained base variants, not instruct. Base variants give cleaner tab
      # completions than chat-tuned models.
      loadModels = [
        "qwen2.5-coder:14b-base"
        "qwen2.5-coder:7b-base"
      ];
    };

    # No autostart; keep the GPU free by default.
    systemd.services.ollama.wantedBy = lib.mkForce [ ];
    systemd.services.ollama-model-loader.wantedBy = lib.mkForce [ ];
  };
}
