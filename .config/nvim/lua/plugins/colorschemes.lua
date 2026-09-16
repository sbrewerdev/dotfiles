vim.pack.add({
	{ src = "https://github.com/Ferouk/bearded-nvim", name = "bearded" },
	{ src = "https://github.com/folke/tokyonight.nvim", name = "tokyonight" },
	{ src = "https://github.com/rebelot/kanagawa.nvim", name = "kanagawa" },
    { src = "https://github.com/AvengeMedia/base46", name = "base46" },
	-- { src = "https://github.com/pankvitek/bonbon.nvim" },
})

local bearded = require("bearded")
-- bearded.setup({
-- 	flavor = "surprising-blueberry", -- any flavor slug
-- 	transparent = true,
-- })

local tokyonight = require("tokyonight")
-- tokyonight.setup({
-- 	style = "night",
-- 	transparent = true,
-- })

local kanagawa = require("kanagawa")
-- kanagawa.setup({
-- 	theme = "dragon",
-- 	transparent = true,
-- })

local base46 = require("base46")
base46.setup({
    transparency = true,
})

-- vim.pack.add({"https://github.com/pankvitek/bonbon.nvim"})
-- require('bonbon').colorscheme()

-- vim.cmd.colorscheme("bonbon")
-- vim.cmd.colorscheme("bearded")
-- vim.cmd.colorscheme("tokyonight")
-- vim.cmd.colorscheme("kanagawa")
