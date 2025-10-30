{ config, pkgs, ... }:
{
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c547", ATTR{power/wakeup}="disabled"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="046d", ATTR{power/wakeup}="disabled"
  '';
  systemd.services.disable-logitech-wakeup = {
    description = "Disable Logitech USB receiver wakeup";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
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
  systemd.services.log-usb-wakeup-status = {
    description = "Log USB wakeup status for debugging";
    wantedBy = [ "multi-user.target" ];
    after = [ "disable-logitech-wakeup.service" ];
    serviceConfig = {
      Type = "oneshot";
    };
    script = ''
      echo "=== USB Wakeup Status Report ===" 
      for device in /sys/bus/usb/devices/*; do
        if [ -f "$device/idVendor" ] && [ -f "$device/idProduct" ] && [ -f "$device/power/wakeup" ]; then
          vendor=$(cat "$device/idVendor" 2>/dev/null)
          product=$(cat "$device/idProduct" 2>/dev/null)
          wakeup=$(cat "$device/power/wakeup" 2>/dev/null)
          manufacturer=$(cat "$device/manufacturer" 2>/dev/null || echo "Unknown")
          product_name=$(cat "$device/product" 2>/dev/null || echo "Unknown")
          
          if [ "$vendor" = "046d" ]; then
            echo "Logitech Device: $vendor:$product - $manufacturer $product_name - Wakeup: $wakeup"
          fi
        fi
      done
    '';
  };
}
