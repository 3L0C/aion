{pkgs, ...}: {
  home.packages = with pkgs; [
    avahi # Service Discovery for Linux using mDNS/DNS-SD
    cups # OpenPrinting CUPS printing system
    nssmdns # mDNS/DNS-SD Name Service Switch plugin
    sof-firmware # Sound Open Firmware
    dmidecode # Desktop Management Interface table utilities
    hwdata # Hardware identification data
    lshw # Hardware configuration information tool
    microcode-amd # AMD processor microcode updates
    ocl-icd # OpenCL ICD Bindings
    python3 # Python 3 interpreter
  ];
}
