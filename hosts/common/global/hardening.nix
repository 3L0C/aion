{
  security.protectKernelImage = true;
  security.sudo = {
    execWheelOnly = true; # Only wheel group can execute sudo
    wheelNeedsPassword = true; # Require password for wheel group (NOPASSWD rules still work as exceptions)
  };
  boot.kernel.sysctl = {
    "fs.protected_fifos" = 2; # Protect FIFO files in sticky directories
    "fs.protected_regular" = 2; # Protect regular files in sticky directories
    "fs.protected_hardlinks" = 1; # Prevent hardlink privilege escalation
    "fs.protected_symlinks" = 1; # Prevent symlink following attacks
    "fs.suid_dumpable" = 2; # Allow core dumps for SUID programs (Wine debugging)
    "kernel.dmesg_restrict" = 1; # Restrict dmesg to privileged users
    "kernel.kptr_restrict" = 2; # Hide kernel pointers (even from root)
    "kernel.sysrq" = 0; # Disable SysRq key (potential security risk)
    "kernel.yama.ptrace_scope" = 2; # Allow debugging by same user (not 3 - Wine needs this)
    "kernel.io_uring_disabled" = 0; # MUST BE 0 - Wine/Proton/DXVK require io_uring
    "kernel.perf_event_paranoid" = 2; # Allow performance monitoring (MangoHud, etc.)
    "kernel.unprivileged_bpf_disabled" = 0; # Allow for compatibility

    "dev.tty.ldisc_autoload" = 0; # Disable TTY line discipline autoload
    "net.core.bpf_jit_harden" = 2; # Harden BPF JIT compiler
  };

  # Prevent root login on any TTY
  environment.etc.securetty.text = "";
  systemd.coredump.settings.Coredump = {
    Storage = "external";
    ProcessSizeMax = "2G";
    ExternalSizeMax = "2G";
    MaxUse = "5G";
  };
}
