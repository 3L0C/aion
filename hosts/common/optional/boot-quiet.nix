# Quiet boot that still shows LUKS/FIDO2 prompts
{
  boot = {
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
}
