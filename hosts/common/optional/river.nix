# River 0.4.x Wayland Compositor configuration
# System-level setup for River 0.4.x with UWSM session management.
# The programs.river-uwsm module handles:
#   - River 0.4.x installation (via river-no-session overlay)
#   - Window manager installation (oxbow by default; configurable)
#   - UWSM session file creation (registers compositor `river`)
{...}: {
  imports = [
    ./wayland.nix
  ];

  programs.river-uwsm.enable = true;
}
