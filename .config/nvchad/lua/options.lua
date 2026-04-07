require "nvchad.options"

vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/snippets"

-- add yours here!

local o = vim.o


o.relativenumber = true
o.number = true

o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autoindent = true

o.smartindent = true

o.wrap = false

o.cursorline = false

o.incsearch = true

o.termguicolors = true
-- o.background = "dark"
o.signcolumn = "yes"
o.scrolloff = 8
-- o.colorcolumn = "150"

o.updatetime = 50

-- o.clipboard:append("unnamedplus") -- use system clipboard as default register

o.splitright = true
o.splitbelow = true

o.swapfile = false
