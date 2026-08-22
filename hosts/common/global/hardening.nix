# Kernel and system hardening, relaxed where Wine/Proton gaming needs it
{
  security.protectKernelImage = true;

  security.sudo = {
    execWheelOnly = true;
    wheelNeedsPassword = true; # NOPASSWD rules still work as exceptions
  };

  boot.kernel.sysctl = {
    "fs.protected_fifos" = 2;
    "fs.protected_regular" = 2;
    "fs.protected_hardlinks" = 1;
    "fs.protected_symlinks" = 1;
    "fs.suid_dumpable" = 2; # Allow core dumps for SUID programs (Wine debugging)

    "kernel.dmesg_restrict" = 1;
    "kernel.kptr_restrict" = 2;
    "kernel.sysrq" = 0;

    "kernel.yama.ptrace_scope" = 2; # Not 3 — Wine needs same-user debugging
    "kernel.io_uring_disabled" = 0; # Must stay 0 — Wine/Proton/DXVK require io_uring
    "kernel.perf_event_paranoid" = 2; # Allow performance monitoring (MangoHud, etc.)
    "kernel.unprivileged_bpf_disabled" = 0;

    # Do not set kernel.core_pattern here. systemd-coredump owns it via the
    # pipe pattern (see systemd.coredump below).

    "dev.tty.ldisc_autoload" = 0;

    "net.core.bpf_jit_harden" = 2;
  };

  # Prevent root login on any TTY
  environment.etc.securetty.text = "";

  # Core dumps stay enabled for Wine/game debugging; manage via coredumpctl.
  # Set Storage=none to disable.
  systemd.coredump.settings.Coredump = {
    Storage = "external";
    ProcessSizeMax = "2G";
    ExternalSizeMax = "2G";
    MaxUse = "5G";
  };
}
