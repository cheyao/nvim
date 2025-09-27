require "nvchad.options"

-- add yours here!

vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

local o = vim.o
o.smarttab = true
o.shiftwidth = 4
o.smoothscroll = true
o.tabstop = 4
o.expandtab = true
o.smartcase = true
o.foldlevel = 99
o.relativenumber = true
o.number = true
o.foldmethod = 'expr'
o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- o.cursorlineopt ='both' -- to enable cursorline!
