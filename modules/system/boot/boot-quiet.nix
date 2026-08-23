# Quiet boot that still shows LUKS/FIDO2 prompts
{
  flake.modules.nixos.boot-quiet = {
    boot = {
      # Level 3 keeps systemd-cryptsetup prompts visible; level 0 would suppress
      # FIDO2 touch prompts.
      consoleLogLevel = 3;
      kernelParams = [
        "loglevel=3"
        "quiet"
        "rd.udev.log_level=3"
        # Needed for LUKS/FIDO2 prompts in systemd initrd
        "rd.systemd.show_status=true"
        "udev.log_level=3"
        "vt.global_cursor_default=0"
      ];

      initrd.verbose = false;
      loader.timeout = 3;
    };
  };
}
