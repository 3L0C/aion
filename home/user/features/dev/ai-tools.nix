{pkgs, ...}: {
  home.packages = with pkgs; [
    master.claude-code # Agentic coding tool that lives in your terminal
    pi-coding-agent # Coding agent CLI with read, bash, edit, write tools and session management
  ];

  programs.codex.enable = true;
}
