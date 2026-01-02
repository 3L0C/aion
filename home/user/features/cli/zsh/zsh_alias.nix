{
  programs.zsh.shellAliases = {
    vim = "nvim";
    vimdiff = "nvim -d";
    e = "$EDITOR";
    v = "$EDITOR";
    se = "sudoedit";
    cp = "cp -iv";
    mv = "mv -iv";
    rm = "rm -vI";
    mkd = "mkdir -pv";
    grep = "grep --color=auto";
    diff = "diff --color=auto";
    ip = "ip -c";
    ccat = "highlight --out-format=ansi";
    ka = "killall";
    g = "git";
    p = "python3";
    z = "zathura";
    bc = "bc -ql";
    yt = "yt-dlp --add-metadata -i";
    yta = "yt -x -f bestaudio/best";
    ffmpeg = "ffmpeg -hide-banner";
    fmpv = "mpv --x11-name=fmpv";
    sctl = "systemctl";
    sys = "systemctl";
    tks = "tmux kill-session";
    tls = "tmux ls";
    rsync2 = "rsync --info=progress2 --partial -auvzs";
    debsync = "rsync -avP";
    sf = "grep -R -i --exclude='*.log' --exclude='*.supp'";
    pf = "printf '%s\\n'";
    cht = "cht.sh";
    magit = "nvim -c MagitOnly";
    pypi-up = "p -m build && twine upload dist/*";
    update = "sudo nixos-rebuild switch";
    upgrade = "sudo nixos-rebuild switch --upgrade";
  };
}
