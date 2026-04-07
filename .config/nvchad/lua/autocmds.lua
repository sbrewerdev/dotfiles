require("nvchad.autocmds")

-- Create an augroup for Markdown autosave
local markdown_autosave = vim.api.nvim_create_augroup("AutoSaveMarkdown", { clear = true })

-- Create an autocommand that triggers on InsertLeave, CursorHold, and CursorHoldI for *.md files
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    group = markdown_autosave,
    pattern = { "*.md" },
    command = "silent! write",
})
-- On setting the filetype to markdown, create a buffer-local mapping for dd
-- which deletes a line and then writes the file.
vim.api.nvim_create_autocmd("FileType", {
    group = markdown_autosave,
    pattern = "markdown",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', 'dd', 'dd:write<CR>', { noremap = true, silent = true })
        -- vim.api.nvim_buf_set_keymap(0, 'n', '<leader>x', ':ToggleCheckbox<cr>:write<cr>', { noremap = true, silent = true })
    end,
})

