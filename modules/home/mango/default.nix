{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    wmenu
  ];

  wayland.windowManager.mango = {
    enable = true;
    settings = ''
      bind=SUPER,Return,spawn,kitty
      bind=SUPER,p,spawn,wmenu-run -l 10
      bind=SUPER,1,comboview,1
      bind=SUPER,2,comboview,2
      bind=SUPER,3,comboview,3
      bind=SUPER,4,comboview,4
      bind=SUPER,5,comboview,5
      bind=SUPER,6,comboview,6
      bind=SUPER,7,comboview,7
      bind=SUPER,8,comboview,8
      bind=SUPER,9,comboview,9
      bind=SUPER,j,focusstack,next
      bind=SUPER,k,focusstack,prev
      bind=SUPER,i,incnmaster,+1
      bind=SUPER,d,incnmaster,-1
      bind=SUPER,h,setmfact,-0.05
      bind=SUPER,l,setmfact,+0.05
      bind=SUPER+SHIFT,Return,zoom
      bind=SUPER,code:60,focusmon,right
      bind=SUPER+shift,code:60,tagmon,right,0
      bind=SUPER+shift,c,killclient
      bind=SUPER+SHIFT,Up,exchange_client,up
      bind=SUPER+SHIFT,Down,exchange_client,down
      bind=SUPER+SHIFT,Left,exchange_client,left
      bind=SUPER+SHIFT,Right,exchange_client,right
      bind=SUPER,t,setlayout,tile
      bind=SUPER,f,togglefloating # Sorry no floating layouts
      bind=SUPER,m,setlayout,monocle
      bind=SUPER,v,setlayout,vertical_grid
      bind=SUPER+SHIFT,v,setlayout,vertical_scroller
      tagrule=id:1,layout_name:tile
      tagrule=id:2,layout_name:tile
      tagrule=id:3,layout_name:tile
      tagrule=id:4,layout_name:tile
      tagrule=id:5,layout_name:tile
      tagrule=id:6,layout_name:tile
      tagrule=id:7,layout_name:tile
      tagrule=id:8,layout_name:tile
      tagrule=id:9,layout_name:tile

      animations=0
      gappih=0
      gappiv=0
      gappoh=0
      gappov=0
      borderpx=1
      no_border_when_single=1
      focuscolor=0x005577ff
      mousebind=SUPER,btn_left,moveresize,curmove
      mousebind=SUPER,btn_right,moveresize,curresize
      mousebind=NONE,btn_left,toggleoverview,-1
      mousebind=NONE,btn_right,killclient,0
      new_is_master=0
      enable_hotarea=0
      warpcursor=1
      sloppyfocus=1
      axis_bind_apply_timeout=100
      drag_tile_to_tile=1
      enable_floating_snap=0
      snap_distance=30
    '';
    autostart_sh = ''
    '';
  };
}
