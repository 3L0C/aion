{
  boot = {
    consoleLogLevel = 3;
    kernelParams = [
      "loglevel=3"
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=true"
      "udev.log_level=3"
      "vt.global_cursor_default=0"
    ];

    initrd.verbose = false;
    loader.timeout = 3;
  };
}
