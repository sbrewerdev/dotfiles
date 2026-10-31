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

if vim.g.vscode then
    map("v", "<", "<gv")
    map("v", ">", ">gv")
    map("v", "p", '"_dP', opts)

    local function vscode_action(command)
        return function()
            require("vscode").action(command)
        end
    end

    map("n", "-", vscode_action("workbench.files.action.focusFilesExplorer"), { desc = "Open File Explorer" })
    map("n", "L", vscode_action("workbench.action.nextEditor"), { desc = "Next editor" })
    map("n", "H", vscode_action("workbench.action.previousEditor"), { desc = "Previous editor" })
    map("n", "<C-h>", vscode_action("workbench.action.focusLeftGroup"), { desc = "Go to Left Window" })
    map("n", "<C-j>", vscode_action("workbench.action.focusBelowGroup"), { desc = "Go to Lower Window" })
    map("n", "<C-k>", vscode_action("workbench.action.focusAboveGroup"), { desc = "Go to Upper Window" })
    map("n", "<C-l>", vscode_action("workbench.action.focusRightGroup"), { desc = "Go to Right Window" })
    map("n", "<leader>ww", vscode_action("workbench.action.focusPreviousGroup"), { desc = "Other Window" })
    map("n", "<leader>wd", vscode_action("workbench.action.closeActiveEditor"), { desc = "Close editor" })
    map("n", "<leader>w-", vscode_action("workbench.action.splitEditorDown"), { desc = "Split Window Below" })
    map("n", "<leader>w|", vscode_action("workbench.action.splitEditorRight"), { desc = "Split Window Right" })
    return
end

-- Open Oil File Explorer
map("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil File Explorer" })
map("n", "<leader>-", "<CMD>Oil --float<CR>", { desc = "Toggle Oil File Explorer" })

-- Map to next buffer (e.g., Shift-L)
map("n", "L", "<Cmd>bnext<CR>", { desc = "Next buffer" })
-- Map to previous buffer (e.g., Shift-H)
map("n", "H", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })
-- Delete current buffer
-- map("n", "<leader>bd", "<Cmd>bdelete<CR>", { desc = "Close Tab" })

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

-- ═══════════════════════════════════════════════════════════
-- FOLDING NAVIGATION (for code organization)
-- ═══════════════════════════════════════════════════════════

-- Close all folds except current one (great for focus)
map("n", "zv", "zMzvzz", { desc = "Close all folds except the current one" })

-- ═══════════════════════════════════════════════════════════
-- Plugin stuff (for managing plugins)
-- ═══════════════════════════════════════════════════════════
map("n", "<leader>pu", "<cmd>lua vim.pack.update()<CR>")

vim.g.copilot_no_tab_map = true

map("i", "<C-g>", 'copilot#Accept("")', {
    expr = true,
    replace_keycodes = false,
    desc = "Accept Copilot suggestion",
})
map("n", "<leader>ge", "<cmd>Copilot enable<cr>", { desc = "Enable Copilot" })
map("n", "<leader>gd", "<cmd>Copilot disable<cr>", { desc = "Disable Copilot" })
map("n", "<leader>gs", "<cmd>Copilot status<cr>", { desc = "Copilot Status" })
