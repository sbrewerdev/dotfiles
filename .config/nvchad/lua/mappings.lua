require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Nvim Tmux Navigation
map("n", "<C-h>", "<CMD>NvimTmuxNavigateLeft<CR>", { desc = "Focus Left" })
map("n", "<C-j>", "<CMD>NvimTmuxNavigateDown<CR>", { desc = "Focus Lower" })
map("n", "<C-k>", "<CMD>NvimTmuxNavigateUp<CR>", { desc = "Focus Upper" })
map("n", "<C-l>", "<CMD>NvimTmuxNavigateRight<CR>", { desc = "Focus Right" })

-- Clear highlights
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Window Splits
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make window splits equal in size" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split window" })

-- File Navigation Nice-to-haves
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Executable Perms
map("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true })

-- Turn tabs into spaces to make lsp errors go away on Erik's crappy code
map("n", "<leader>rt", ":retab<CR>i<ESC>", { desc = "Retab" })

-- Keybind to quit, I don't ever be using this.
map("n", "<leader>qa", ":q<CR>", { desc = "Quit" })

-- Ctrl + s to save
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Navigating between buffers
map("n", "<S-l>", function()
    require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-h>", function()
    require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<S-x>", function()
    require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- NvimTree Keybinds
local nvimtree_api = require "nvim-tree.api"
map("n", "<leader>bm", nvimtree_api.marks.bulk.move, { desc = "Move Bookmarked" })
