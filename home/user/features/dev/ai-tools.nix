{pkgs, ...}: {
  home.packages = with pkgs; [
    unstable.claude-code # Agentic coding tool that lives in your terminal
  ];
}
