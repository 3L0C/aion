{pkgs, ...}: {
  home.packages = with pkgs; [
    ocl-icd # OpenCL ICD Bindings - Required for OpenCL applications
    xorg.libXft # FreeType-based font drawing library for X - X11 compatibility
  ];
}
