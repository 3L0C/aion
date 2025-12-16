{
  programs.bash = {
    enable = true;
    initExtra = ''
      PS1='\[\033[1;34m\]\w\[\033[0m\]\n\$ '
    '';
  };
}
