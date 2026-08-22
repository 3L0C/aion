# Disable wake-on-USB for Logitech receivers (ID 046d:c547 and any 046d)
{pkgs, ...}: {
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c547", ATTR{power/wakeup}="disabled"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="046d", ATTR{power/wakeup}="disabled"
  '';

  # Fallback for devices the udev rules miss at boot
  systemd.services.disable-logitech-wakeup = {
    description = "Disable Logitech USB receiver wakeup";
    wantedBy = ["multi-user.target"];
    after = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      # Wait for USB devices to be detected
      ${pkgs.coreutils}/bin/sleep 2

      for device in /sys/bus/usb/devices/*; do
        if [ -f "$device/idVendor" ] && [ -f "$device/idProduct" ]; then
          vendor=$(cat "$device/idVendor" 2>/dev/null)
          product=$(cat "$device/idProduct" 2>/dev/null)

          if [ "$vendor" = "046d" ]; then
            if [ -w "$device/power/wakeup" ]; then
              echo "Disabling wakeup for Logitech device $vendor:$product"
              echo disabled > "$device/power/wakeup" 2>/dev/null || true
            fi
          fi
        fi
      done
    '';
  };
}
