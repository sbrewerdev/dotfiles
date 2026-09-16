require("vim._core.ui2").enable({
    enable = true,
    msg = {
        target = "cmd",
        pager = { height = 0.5 },
        dialog = { height = 0.5 },
        cmd = { height = 0.5 },
        msg = { height = 0.5 },
    }
})

require("core")
require("plugins")
require("current-theme")

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { '<filetype>' },
--   callback = function() vim.treesitter.start() end,
-- })
