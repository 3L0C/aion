{pkgs, ...}: {
  home.packages = with pkgs; [
    master.claude-code # Agentic coding tool that lives in your terminal
  ];

  programs.codex.enable = true;
}
