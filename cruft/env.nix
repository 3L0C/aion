{config, ...}: {
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
    BROWSER = "firefox";
    PASSMAN = "keepassxc";
    MPV_SOCKET_DIR = "/tmp/mpvSockets";
    DMENU_ARGS = "-c -l 20 -bw 4";
    MPC_TMP_DIR = "/tmp/mpc";
    MPC_TMP_FILE = "/tmp/mpc/current-song.txt";
    XINITRC = "${config.xdg.configHome}/x11/xinitrc";
    NOTMUCH_CONFIG = "${config.xdg.configHome}/notmuch-config";
    WGETRC = "${config.xdg.configHome}/wget/wgetrc";
    INPUTRC = "${config.xdg.configHome}/shell/inputrc";
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    WINEPREFIX = "${config.xdg.dataHome}/wineprefixes/default";
    KODI_DATA = "${config.xdg.dataHome}/kodi";
    PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
    ANDROID_SDK_HOME = "${config.xdg.configHome}/android";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    GOPATH = "${config.xdg.dataHome}/go";
    ANSIBLE_CONFIG = "${config.xdg.configHome}/ansible/ansible.cfg";
    UNISON = "${config.xdg.dataHome}/unison";
    WEECHAT_HOME = "${config.xdg.configHome}/weechat";
    MBSYNCRC = "${config.xdg.configHome}/mbsync/config";
    ELECTRUMDIR = "${config.xdg.dataHome}/electrum";
    LESSHISTFILE = "-";
    LESS = "-R --mouse --wheel-lines=5";
    LESS_TERMCAP_mb = "\\e[1;31m"; # Begin blinking
    LESS_TERMCAP_md = "\\e[1;36m"; # Begin bold
    LESS_TERMCAP_me = "\\e[0m"; # End mode
    LESS_TERMCAP_so = "\\e[01;44;33m"; # Begin standout
    LESS_TERMCAP_se = "\\e[0m"; # End standout
    LESS_TERMCAP_us = "\\e[1;32m"; # Begin underline
    LESS_TERMCAP_ue = "\\e[0m"; # End underline
    QT_QPA_PLATFORMTHEME = "qt5ct";
    MOZ_USE_XINPUT2 = "1"; # Enable smooth scrolling and touchpad gestures
    _JAVA_AWT_WM_NONREPARENTING = "1";
    AWT_TOOLKIT = "MToolkit wmname LG3D";
    DOOMDIR = "${config.home.homeDirectory}/.config/doom";
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = "1";

    SFEEDPATH = "${config.xdg.configHome}/sfeed";
  };
}
