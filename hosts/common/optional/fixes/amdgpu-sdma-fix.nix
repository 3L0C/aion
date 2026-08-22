# Workaround for AMD GPU SDMA ring timeouts on RX 7800 XT (navi32)
# See: https://wiki.archlinux.org/title/AMDGPU#Freezes_with_'[drm]_IP_block:gmc_v8_0_is_hung!'_kernel_error
{
  boot.kernelParams = [
    # Recover the GPU instead of a full hang
    "amdgpu.gpu_recovery=1"
  ];
}
