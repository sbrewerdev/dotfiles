local o = vim.opt

o.number = true
o.relativenumber = true
o.showmode = false
o.ruler = false
o.cmdheight = 0

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autoindent = true
o.smartindent = true
o.wrap = false
o.winborder = "rounded"

o.swapfile = false
o.backup = false
o.undofile = true

o.incsearch = true
o.inccommand = "split"
o.ignorecase = true
o.smartcase = true

o.termguicolors = true
o.background = "dark"
o.signcolumn = "yes"
o.scrolloff = 8
o.fillchars = { eob = " " }

o.backspace = { "start", "eol", "indent" }

o.splitright = true
o.splitbelow = true

vim.opt.isfname:append("@-@")
o.updatetime = 50
o.colorcolumn = "120"

o.clipboard:append("unnamedplus") -- use system clipboard as default register
o.hlsearch = true

vim.g.editorconfig = true
