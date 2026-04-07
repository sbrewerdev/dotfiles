--: Bearded Bear Themes
vim.pack.add({
	{ src = "https://github.com/Ferouk/bearded-nvim" },
})

local bearded = require("bearded")

bearded.setup({
    flavor = "surprising-blueberry", -- any flavor slug
    transparent = true,
})

vim.cmd.colorscheme("bearded")
