# ROCm on the yuki GPUs. Device 0 is the discrete 7800 XT; without
# the pin, ollama splits models onto the gfx1036 iGPU because it
# sees more free memory there.
{
  flake.modules.nixos."hosts/yuki" = {pkgs, ...}: {
    services.ollama = {
      package = pkgs.ollama-rocm;
      environmentVariables = {
        HIP_VISIBLE_DEVICES = "0";
        ROCR_VISIBLE_DEVICES = "0";
        OLLAMA_CONTEXT_LENGTH = "65536";
      };
    };
  };
}
