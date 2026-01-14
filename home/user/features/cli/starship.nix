{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = "$hostname$directory$git_branch$git_status$cmd_duration$shell\n$character";
      add_newline = false;
      hostname = {
        ssh_only = false;
        format = "[$hostname]($style) ";
        style = "bold green";
      };
      directory = {
        format = "[$path]($style) ";
        style = "bold blue";
        truncation_length = 4;
        truncate_to_repo = false;
      };
      git_branch = {
        format = "\\([$branch]($style)";
        style = "bold purple";
      };
      git_status = {
        format = "([ : ](bold white)[$all_status$ahead_behind]($style))\\) ";
        style = "bold red";
        conflicted = "=";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
        untracked = "?";
        stashed = "\\$";
        modified = "!";
        staged = "+";
        renamed = "»";
        deleted = "✘";
      };
      cmd_duration = {
        format = "took [$duration]($style) ";
        style = "bold yellow";
        min_time = 2000;
      };
      character = {
        success_symbol = "[λ](bold white)";
        error_symbol = "[λ](bold red)";
      };
      shell = {
        disabled = false;
        format = "[$indicator]($style) ";
        style = "bold yellow";
        zsh_indicator = ""; # hide for normal shell
        bash_indicator = "bash";
        fish_indicator = "fish";
        nu_indicator = "nu";
      };

      # Disable noisy modules
      package.disabled = true;
      nodejs.disabled = true;
      python.disabled = true;
      rust.disabled = true;
      golang.disabled = true;
      java.disabled = true;
      ruby.disabled = true;
      php.disabled = true;
      lua.disabled = true;
      perl.disabled = true;
      aws.disabled = true;
      gcloud.disabled = true;
      azure.disabled = true;
      docker_context.disabled = true;
      kubernetes.disabled = true;
    };
  };
}
