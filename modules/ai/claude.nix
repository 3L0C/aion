{
  flake.modules.homeManager.claude = {pkgs, ...}: {
    # Agentic coding tool that lives in your terminal
    home.packages = [pkgs.master.claude-code];
  };
}
