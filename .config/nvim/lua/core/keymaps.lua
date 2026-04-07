local opts = { noremap = true, silent = true }
local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Insert Mode Keybinds
map("i", "jk", "<ESC>l")

-- Visual Mode Keybinds
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves lines down in visual selection" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves lines up in visual selection" })

-- Normal Mode Keybinds
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Open Oil File Explorer
map("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil File Explorer" })
map("n", "<leader>-", "<CMD>Oil --float<CR>", { desc = "Toggle Oil File Explorer" })

-- Map to next buffer (e.g., Shift-L)
map("n", "L", "<Cmd>bnext<CR>", { desc = "Next buffer" })
-- Map to previous buffer (e.g., Shift-H)
map("n", "H", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })

-- ═══════════════════════════════════════════════════════════
-- WINDOW MANAGEMENT (splitting and navigation)
-- ═══════════════════════════════════════════════════════════

-- Move between windows with Ctrl+hjkl (like tmux)
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize windows with Ctrl+Shift+arrows (macOS friendly)
map("n", "<C-S-Up>", "<cmd>resize +5<CR>", opts)
map("n", "<C-S-Down>", "<cmd>resize -5<CR>", opts)
map("n", "<C-S-Left>", "<cmd>vertical resize -5<CR>", opts)
map("n", "<C-S-Right>", "<cmd>vertical resize +5<CR>", opts)

-- Window splitting
map("n", "<leader>ww", "<C-W>p", { desc = "Other Window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- ═══════════════════════════════════════════════════════════
-- SMART TEXT EDITING
-- ═══════════════════════════════════════════════════════════

-- Better indenting (stay in visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Better paste (doesn't replace clipboard with deleted text)
map("v", "p", '"_dP', opts)

-- auto close pairs
-- map("i", "'", "''<left>") -- commented out - smart!
map("i", "`", "``<left>")
map("i", '"', '""<left>')
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")
map("i", "<", "<><left>")

-- ═══════════════════════════════════════════════════════════
-- FOLDING NAVIGATION (for code organization)
-- ═══════════════════════════════════════════════════════════

-- Close all folds except current one (great for focus)
map("n", "zv", "zMzvzz", { desc = "Close all folds except the current one" })

map("n", "<leader>pu", "<cmd>lua vim.pack.update()<CR>")
