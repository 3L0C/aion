{pkgs, ...}: {
  home.packages = with pkgs; [
    claude-code # Agentic coding tool that lives in your terminal
  ];
}
