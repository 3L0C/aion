{pkgs, ...}: {
  home.packages = with pkgs; [
    gdb # GNU Debugger
    gef # GDB Enhanced Features - GDB plugin with extra features
    valgrind # Memory debugging and profiling tool
  ];
}
