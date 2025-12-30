{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = ''
      local g   = vim.g
      local o   = vim.o
      local opt = vim.opt

      -- Makes neovim and host OS clipboard play nicely with each other
      o.clipboard = 'unnamedplus'

      -- Case insensitive searching UNLESS /C or capital in search
      o.ignorecase = true
      o.smartcase = true

      -- Undo and backup options
      o.backup = false
      o.writebackup = false
      o.undofile = true
      o.swapfile = false

      -- Remember 50 items in commandline history
      o.history = 50

      -- Better buffer splitting
      o.splitright = true
      o.splitbelow = true
      opt.mouse = "a"

      -- Map <leader> to space
      g.mapleader = ','
      g.maplocalleader = ','

      -- Set some sane defaults
      o.title = true
      o.mouse = 'a'
      opt.hlsearch = false
      opt.ruler = false
      o.encoding = 'utf-8'
      g.wildmode = { 'longest', 'list', 'full' }
    '';
  };
}
