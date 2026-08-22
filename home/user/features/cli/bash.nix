{
  programs.bash = {
    enable = true;
    initExtra = ''
      # Distinct from zsh for easy identification
      PS1='\n\[\033[1;32m\][\u@\h:\w]\$\[\033[0m\] '
    '';
  };
}
