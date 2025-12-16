{
  programs.bash = {
    enable = true;
    initExtra = ''
      PS1='\n\[\033[1;32m\][\u@\h:\w]\$\[\033[0m\] '
    '';
  };
}
