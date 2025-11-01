{
  config,
  pkgs,
  inputs,
  ...
}: let
  hexToMango = hex: alpha: "0x${builtins.substring 1 (-1) hex}${alpha}";
  toMango = hex: hexToMango hex "ff";
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
    glib
    wayland
  ];
  xdg.portal = {
    extraPortals = [pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk];
    config.common.default = ["wlr" "gtk"];
  };

  wayland.windowManager.mango = {
    enable = true;
    settings = ''
      monitorrule=DP-3,0.55,1,spiral,0,1,0,0,2560,1440,240
      monitorrule=HDMI-A-1,0.55,1,spiral,0,1,2560,0,2560,1440,240
      repeat_rate=50
      repeat_delay=300
      numlockon=1
      xkb_rules_layout=us
      tap_to_click=1
      tap_and_drag=1
      trackpad_natural_scrolling=0
      disable_while_typing=1
      left_handed=0
      accel_profile=0
      accel_speed=0.0
      env=XCURSOR_SIZE,24
      env=HYPRCURSOR_SIZE,24
      borderpx=6
      gappih=10
      gappiv=10
      gappoh=10
      gappov=10
      no_border_when_single=1
      smartgaps=0
      focuscolor=${toMango config.themeSpec.border}
      animations=0
      new_is_master=0
      enable_hotarea=0
      warpcursor=1
      sloppyfocus=1
      axis_bind_apply_timeout=100
      drag_tile_to_tile=1
      enable_floating_snap=0
      snap_distance=32
      tagrule=id:1,layout_name:spiral
      tagrule=id:2,layout_name:spiral
      tagrule=id:3,layout_name:spiral
      tagrule=id:4,layout_name:spiral
      tagrule=id:5,layout_name:spiral
      tagrule=id:6,layout_name:spiral
      tagrule=id:7,layout_name:spiral
      tagrule=id:8,layout_name:spiral
      tagrule=id:9,layout_name:spiral

      bind=SUPER,Return,spawn,kitty
      bind=SUPER,p,spawn,wmenu-run -l 10
      bind=SUPER,1,view,1,0
      bind=SUPER,2,view,2,0
      bind=SUPER,3,view,3,0
      bind=SUPER,4,view,4,0
      bind=SUPER,5,view,5,0
      bind=SUPER,6,view,6,0
      bind=SUPER,7,view,7,0
      bind=SUPER,8,view,8,0
      bind=SUPER,9,view,9,0
      bind=SUPER,0,view,0,0
      bind=SUPER+SHIFT,1,tag,1,0
      bind=SUPER+SHIFT,2,tag,2,0
      bind=SUPER+SHIFT,3,tag,3,0
      bind=SUPER+SHIFT,4,tag,4,0
      bind=SUPER+SHIFT,5,tag,5,0
      bind=SUPER+SHIFT,6,tag,6,0
      bind=SUPER+SHIFT,7,tag,7,0
      bind=SUPER+SHIFT,8,tag,8,0
      bind=SUPER+SHIFT,9,tag,9,0
      bind=SUPER+SHIFT,0,tag,0,0
      bind=SUPER,j,focusstack,next
      bind=SUPER,k,focusstack,prev
      bind=SUPER,f,focusstack,0
      bind=SUPER,h,viewtoleft,0
      bind=SUPER,l,viewtoright,0
      bind=SUPER+SHIFT,h,tagtoleft,0
      bind=SUPER+SHIFT,l,tagtoright,0
      bind=SUPER,Prior,viewtoleft,0
      bind=SUPER+SHIFT,Prior,tagtoleft,0
      bind=SUPER,Next,viewtoright,0
      bind=SUPER+SHIFT,Next,tagtoright,0
      bind=SUPER,y,setlayout,spiral
      bind=SUPER+SHIFT,y,setlayout,dwindle
      bind=SUPER,i,setlayout,monocle
      bind=SUPER,t,setlayout,tile
      bind=SUPER,u,setlayout,deck
      bind=SUPER+SHIFT,u,setlayout,center_tile

      # Window management
      bind=SUPER,q,killclient,
      bind=SUPER,space,zoom
      bind=SUPER+SHIFT,space,togglefloating,
      bind=SUPER+SHIFT,f,togglefloating,
      bind=SUPER,v,togglefullscreen,
      bind=SUPER,Tab,view,-1,0
      bind=SUPER,backslash,view,-1,0
      bind=SUPER,semicolon,setmfact,+0.05
      bind=SUPER,g,setmfact,-0.05
      bind=SUPER,a,togglegaps,
      bind=SUPER,z,incgaps,+3
      bind=SUPER,x,incgaps,-3
      bind=SUPER,Left,focusmon,left
      bind=SUPER,Right,focusmon,right
      bind=SUPER+SHIFT,Left,tagmon,left,0
      bind=SUPER+SHIFT,Right,tagmon,right,0
      bind=SUPER+SHIFT,j,exchange_client,down
      bind=SUPER+SHIFT,k,exchange_client,up
      bind=SUPER+SHIFT,Return,toggle_named_scratchpad,spterm,none,kitty --class spterm
      bind=SUPER,apostrophe,toggle_named_scratchpad,spcalc,none,kitty --class spcalc -e bc -lq

      windowrule=isnamedscratchpad:1,width:1280,height:800,appid:spterm
      windowrule=isnamedscratchpad:1,width:500,height:400,appid:spcalc,isfloating:1
      bind=,XF86AudioMute,spawn,pamixer -t
      bind=,XF86AudioRaiseVolume,spawn,pamixer --allow-boost -i 5
      bind=,XF86AudioLowerVolume,spawn,pamixer --allow-boost -d 5
      bind=,XF86AudioPrev,spawn,playerctl previous
      bind=,XF86AudioNext,spawn,playerctl next
      bind=,XF86AudioPlay,spawn,playerctl play-pause
      bind=,XF86AudioStop,spawn,playerctl stop
      bind=,XF86MonBrightnessUp,spawn,brightnessctl set +10%
      bind=,XF86MonBrightnessDown,spawn,brightnessctl set 10%-
      windowrule=tags:1,appid:LibreWolf
      windowrule=tags:3,appid:firefox
      windowrule=tags:3,appid:kitty,title:anime_lf
      windowrule=tags:3,appid:kitty,title:aniwiki
      windowrule=tags:4,appid:brave-browser
      windowrule=tags:4,appid:Lutris
      windowrule=tags:5,appid:steam
      windowrule=tags:5,appid:fate.exe,isfloating:1
      windowrule=tags:6,appid:transmission-gtk
      windowrule=tags:6,appid:transmission
      windowrule=tags:7,appid:kdenlive
      windowrule=tags:8,appid:Gimp
      windowrule=tags:9,appid:KeePassXC
      windowrule=isfloating:1,appid:mpv,title:fmpv
      windowrule=isfloating:1,appid:kitty,title:pulsemixer
      windowrule=isfloating:1,appid:steam,title:Friends List
      mousebind=SUPER,btn_left,moveresize,curmove
      mousebind=SUPER,btn_right,moveresize,curresize
      mousebind=NONE,btn_left,toggleoverview,-1
      mousebind=NONE,btn_right,killclient,0
    '';
    autostart_sh = ''
      #!/bin/sh

      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
      systemctl --user import-environment QT_QPA_PLATFORMTHEME &
      dunst &
      wl-paste --type text --watch cliphist store &
      wl-clip-persist --clipboard regular &
      waybar -c ~/.config/waybar/mango-config.json -s ~/.config/waybar/mango-style.css &
      tmux new-session -s x-server -d &
      setsid -f wpctl-settings &
      mpd &
      /usr/lib/xdg-desktop-portal-wlr &
    '';
  };
}
