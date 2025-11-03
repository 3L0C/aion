{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  c = config.lib.stylix.colors;
  bgra = color: "0x${c.${color + "-hex-b"}}${c.${color + "-hex-g"}}${c.${color + "-hex-r"}}ff";

  mod = "SUPER";

  # Programs
  bc = "${lib.getExe pkgs.bc}";
  kitty = "${lib.getExe pkgs.kitty}";
  terminal = "uwsm-app ${kitty}";
  rofi = "${lib.getExe config.programs.rofi.package}";
  menu = "${rofi} -show drun";
in {
  imports = [
    inputs.mango.hmModules.mango
  ];
  home.packages = with pkgs; [
    wmenu
    grim
    slurp
    wf-recorder
    wl-clip-persist
    cliphist
    wayland
  ];
  xdg.portal = {
    extraPortals = [pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk];
    config.common.default = ["wlr" "gtk"];
  };

  wayland.windowManager.mango = {
    enable = true;
    systemd.enable = true;
    settings = ''
      blur=0    # integer, Enable window blur (0-disable, 1-enable)
      blur_layer=0    # integer, Enable layer blur (0-disable, 1-enable)
      blur_optimized=1    # integer, Enable blur background cache (0-disable, 1-enable)
      blur_params_num_passes=2    # integer, Number of blur passes
      blur_params_radius=5    # integer, Blur radius
      blur_params_noise=0.02    # float, Blur noise level
      blur_params_brightness=0.9    # float, Blur brightness adjustment
      blur_params_contrast=0.9    # float, Blur contrast adjustment
      blur_params_saturation=1.2    # float, Blur saturation adjustment
      shadows=0    # integer, Enable window shadows (0-disable, 1-enable)
      shadow_only_floating=1    # integer, Only draw shadows for floating windows (0-disable, 1-enable)
      layer_shadows=0    # integer, Enable layer shadows (0-disable, 1-enable)
      shadows_size=10    # integer, Shadow size
      shadows_blur=15    # integer, Shadow blur amount
      shadows_position_x=0    # integer, Shadow X offset
      shadows_position_y=0    # integer, Shadow Y offset
      shadowscolor=0x000000ff    # hex color, Shadow color (ARGB format)
      border_radius=0    # integer, Window border radius
      no_radius_when_single=0    # integer, Disable radius when single window (0-disable, 1-enable)
      focused_opacity=1.0    # float, Opacity of focused window (0.0-1.0)
      unfocused_opacity=1.0    # float, Opacity of unfocused window (0.0-1.0)

      animations=0    # integer, Enable animations (0-disable, 1-enable)
      layer_animations=0    # integer, Enable layer animations (0-disable, 1-enable)
      animation_type_open=slide    # string, Open animation type (zoom, slide, fade, none)
      animation_type_close=slide    # string, Close animation type (zoom, slide, fade, none)
      layer_animation_type_open=slide    # string, Open layer animation type (slide,zoom, fade, none)
      layer_animation_type_close=slide    # string, Close layer animation type (slide, zoom, fade, none)
      animation_fade_in=1    # integer, Enable fade-in effect (0-disable, 1-enable)
      animation_fade_out=1    # integer, Enable fade-out effect (0-disable, 1-enable)
      tag_animation_direction=1    # integer, Tag animation direction (1-horizontal, 0-vertical)
      zoom_initial_ratio=0.3    # float, Initial zoom ratio
      zoom_end_ratio=0.8    # float, End zoom ratio
      fadein_begin_opacity=0.5    # float, Fade-in starting opacity
      fadeout_begin_opacity=0.8    # float, Fade-out starting opacity
      animation_duration_move=500    # integer, Move animation duration (ms)
      animation_duration_open=400    # integer, Open animation duration (ms)
      animation_duration_tag=350    # integer, Tag animation duration (ms)
      animation_duration_close=800    # integer, Close animation duration (ms)
      animation_duration_focus=0    # integer, Close animation duration (ms)
      animation_curve_open=0.46,1.0,0.29,1    # string, Open animation bezier curve
      animation_curve_move=0.46,1.0,0.29,1    # string, Move animation bezier curve
      animation_curve_tag=0.46,1.0,0.29,1    # string, Tag animation bezier curve
      animation_curve_close=0.08,0.92,0,1    # string, Close animation bezier curve
      animation_curve_focus=0.46,1.0,0.29,1    # string, Focus change animation bezier curve

      scroller_structs=20    # integer, The width reserved on both sides of the screen when the window size ratio is 1
      scroller_default_proportion=0.8    # float, Default scroller proportion for window width
      scroller_focus_center=0    # integer, Always make focus window center in screen (0-disable, 1-enable)
      scroller_prefer_center=0    # integer, If the last focused window is inside the monitor, don't make the focused window centered, if not , then make the focused window center (0-disable, 1-enable)
      edge_scroller_pointer_focus=1    # integer, if window not completely in the monitor,still focus it by pointer motion (0-disable, 1-enable)
      scroller_default_proportion_single=1.0    # float, Default proportion of scroller window when there is only a single window in the current tag
      scroller_proportion_preset=0.5,0.8,1.0    # string, Preset proportion of scroller window values for switch

      new_is_master=1    # integer, New window becomes master (0-disable, 1-enable)
      default_mfact=0.6    # float, Default master area factor
      default_nmaster=1    # integer, Default number of master windows
      smartgaps=0    # integer, Enable smart gaps (0-disable, 1-enable)
      center_master_overspread=0    # integer, Center master window overspread whole screen when there is no stack window,only works for center_tile layout
      center_when_single_stack=1    # integer, Center master window when there is only one stack window,only works for center_tile layout

      enable_hotarea=0    # integer, Enable hot areas (0-disable, 1-enable)
      hotarea_size=10    # integer, Hot area size in pixels
      ov_tab_mode=0    # integer, Overview tab mode (0-disable, 1-enable)
      overviewgappi=5    # integer, Inner gap in overview mode
      overviewgappo=30    # integer, Outer gap in overview mode

      xwayland_persistence=1    # integer, (0 or 1) Enable xwayland persistence (needs a relogin to take effect)
      syncobj_enable=0    # integer, (0 or 1) Enable drm_syncobj (needs a relogin to take effect)
      adaptive_sync=0    # integer, (0 or 1) Enable variable refresh rate(vrr)
      axis_bind_apply_timeout=100    # integer, Detect the intervals of consecutive scroll for axisbind
      focus_on_activate=0    # integer, (0 or 1) Focus window when window send activate event (0-disable, 1-enable)
      inhibit_regardless_of_visibility=1    # integer, (0 or 1) Invisible clients can also trigger idle inhibit
      sloppyfocus=1    # integer, (0 or 1) Focus follow mouse move
      warpcursor=1    # integer, (0 or 1) Cursor warping when focus change
      focus_cross_monitor=0    # integer, (0 or 1) Focus across monitors
      exchange_cross_monitor=0    # integer, (0 or 1) exchange two clients across monitors
      scratchpad_cross_monitor=0    # integer, (0 or 1) all monitors have the same scratchpad
      focus_cross_tag=0    # integer, (0 or 1)  Focus across tags
      view_current_to_back=1    # integer, (0 or 1)  View current tag will auto back to prev view tag
      enable_floating_snap=0    # integer, (0 or 1) Enable floating window snap
      snap_distance=30    # integer, (0 - 9999) The max distance to trigger  floating window snap
      cursor_size=${toString config.stylix.cursor.size}    # integer, (0 - 9999) Set cursor size (need relogin to apply)
      cursor_theme=${config.stylix.cursor.name}    # string, Set cursor theme (needs a relogin to apply)
      no_border_when_single=0    # interger, Don't render border when the window is alone in the tag
      cursor_hide_timeout=5    # interger(sec), 0 -9999 (0 meas disable hide cursor)| Hide cursor when timeout
      drag_tile_to_tile=1    # interger, (0 or 1) If the dragged window is a tiled window, it will retile when the drag ends
      single_scratchpad=1    # interger, only show one out of named scratchpads or the normal scratchpad

      repeat_rate=50    # integer, Keyboard repeat rate
      repeat_delay=300    # integer, Keyboard repeat delay
      numlockon=1    # integer, (0 or 1) Numlock state on startup

      disable_trackpad=0    # integer, (0 or 1) Disable trackpad
      tap_to_click=1    # integer, (0 or 1) Enable tap to click
      tap_and_drag=1    # integer, (0 or 1) Enable tap and drag
      drag_lock=1    # integer, (0 or 1) Enable drag lock
      trackpad_natural_scrolling=0    # integer, (0 or 1) Natural scrolling direction
      disable_while_typing=1    # integer, (0 or 1)  Disable trackpad while typing
      left_handed=0    # integer, (0 or 1) Left-handed mode
      middle_button_emulation=0    # integer, (0 or 1)  Middle mouse button emulation
      swipe_min_threshold=20    # integer, Minimum swipe threshold
      mouse_natural_scrolling=0    # integer, (0 or 1)  Natural scrolling for mouse
      accel_profile=2    # integer, (0 or 1 or 2)  accel mode
      accel_speed=0.0    # float, (-1 - 1)  accel speed
      scroll_method=1    # integer, (0: none, 1: two-finger, 2: edge, 4: button) Scrolling method for touchpads
      click_method=1    # integer, (0: none, 1: button areas, 2: clickfinger) Method for triggering button clicks on touchpads
      send_events_mode=0    # integer, (0: enabled, 1: disabled, 2: disabled on external mouse) Controls when events are sent from the device
      button_map=0    # integer, (0:left/right/middle, 1:left/middle/right)

      gappih=10    # integer, Horizontal inner gap
      gappiv=10    # integer, Vertical inner gap
      gappoh=24    # integer, Horizontal outer gap
      gappov=24    # integer, Vertical outer gap
      scratchpad_width_ratio=0.25    # float, (0.1-1.0) scratchpad width ratio
      scratchpad_height_ratio=0.5    # float, (0.1-1.0) scratchpad height ratio
      borderpx=6    # integer, Border width
      rootcolor=${bgra "base00"}    # hex, Root window color
      bordercolor=${bgra "base02"}    # hex, Border color
      focuscolor=${bgra "base0E"}    # hex, Focused window border color
      maximizescreencolor=${bgra "base0B"}    # hex, Maximized screen color
      urgentcolor=${bgra "base08"}    # hex, Urgent window color
      scratchpadcolor=${bgra "base0D"}    # hex, Scratchpad color
      globalcolor=${bgra "base00"}    # hex, Global window color
      overlaycolor=${bgra "base00"}    # hex, Overlay window color

      monitorrule=DP-3,0.6,1,tile,0,1,0,0,2560,1440,240    # name,mfact,nmaster,layout,transform,scale,x,y,width,height,refreshrate, Configure monitor properties
      monitorrule=HDMI-A-1,0.6,1,tile,0,1,2560,0,1920,1080,240    # name,mfact,nmaster,layout,transform,scale,x,y,width,height,refreshrate, Configure monitor properties

      bind=${mod},Q,quit    # Quit window manager
      bind=${mod},q,killclient    # Close focused window
      bind=${mod},j,focusstack,next    # Focus next/prev window in stack
      bind=${mod},k,focusstack,prev    # Focus next/prev window in stack
      bind=${mod},J,exchange_stack_client,next    # Exchange window position in stack
      bind=${mod},K,exchange_stack_client,prev    # Exchange window position in stack
      bind=${mod},S,toggleglobal    # Toggle window global state
      bind=${mod},space,togglefloating    # Toggle floating state
      bind=${mod},v,togglefullscreen    # Toggle fullscreen state
      bind=${mod},v,togglefakefullscreen    # Toggle fakefullscreen state
      bind=${mod},m,minimized    # Minimize window
      bind=${mod},M,restore_minimized    # Restore minimized window
      bind=${mod},space,zoom    # exchange with master window
      bind=${mod},y,setlayout,spiral    # Set specific layout
      bind=${mod},i,setlayout,monocle    # Set specific layout
      bind=${mod},t,setlayout,vertical_tile    # Set specific layout
      bind=${mod},T,setlayout,tile    # Set specific layout
      bind=${mod},Y,setlayout,dwindle    # Set specific layout
      bind=${mod},u,setlayout,deck    # Set specific layout
      bind=${mod},U,setlayout,center_tile    # Set specific layout
      bind=${mod},w,setlayout,scroller    # Set specific layout
      bind=${mod},W,setlayout,vertical_scroller    # Set specific layout
      bind=${mod},h,viewtoleft_have_client,0    # View left tag and focus client if present; synctag:tag action syncs to all monitors (0=no,1=yes)
      bind=${mod},l,viewtoright_have_client,0    # View right tag and focus client if present; synctag:tag action syncs to all monitors (0=no,1=yes)
      bind=CTRL+ALT,L,focusmon,HDMI-A-1    # Focus monitor,monitorName is monitor name string
      bind=CTRL+ALT,H,focusmon,DP-3    # Focus monitor,monitorName is monitor name string
      bind=SUPER,Return,spawn,uwsm-app -- ${terminal}
      bind=SUPER,r,spawn,uwsm-app -- ${menu}
      bind=SUPER+SHIFT,Return,toggle_named_scratchpad,spterm,none,${kitty} --class spterm
      bind=SUPER,apostrophe,toggle_named_scratchpad,spcalc,none,${kitty} --class spcalc -e ${bc} -lq

      windowrule=isnamedscratchpad:1,width:1280,height:800,appid:spterm
      windowrule=isnamedscratchpad:1,width:500,height:400,appid:spcalc,isfloating:1

      mousebind=SUPER,btn_left,moveresize,curmove
      mousebind=SUPER,btn_right,moveresize,curresize
    '';
    autostart_sh = ''
      wl-paste --type text --watch cliphist store &
      wl-clip-persist --clipboard regular &
      waybar -c ~/.config/waybar/mango-config.json -s ~/.config/waybar/mango-style.css &
      tmux new-session -s x-server -d &

      /usr/lib/xdg-desktop-portal-wlr &
    '';
  };
}
