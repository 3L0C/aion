{pkgs, ...}: {
  home.packages = with pkgs; [
    dolphin-emu # Gamecube/Wii/Triforce emulator for x86_64 and ARMv8
  ];
}
