-- vim.pack.add({
--     { src = "https://github.com/saghen/blink.cmp" },
--     { src = "https://github.com/saghen/blink.lib" },
-- })
-- local cmp = require('blink.cmp')
-- cmp.build():wait(60000)
-- cmp.setup({
--     keymap = { preset = "super-tab" },
--     snippets = { preset = "luasnip" },
--     appearance = {
--         nerd_font_variant = "mono",
--         use_nvim_cmp_as_default = false,
--     },
--     completion = {
--         documentation = { auto_show = false },
--     },
--     sources = {
--         default = { "lsp", "path", "snippets", "buffer" },
--     },
--     fuzzy = { implementation = "prefer_rust_with_warning" },
--
-- })

-- blink v1.*

vim.pack.add({
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("^1"),
	},
})

-- Lazy load on first insert mode entry (may not necessary)
local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	group = group,
	once = true,
	callback = function()
		require("blink.cmp").setup({
			keymap = { preset = "super-tab" },
            snippets = { preset = "luasnip" },
			appearance = {
				nerd_font_variant = "mono",
				use_nvim_cmp_as_default = false,
			},
			completion = {
				documentation = { auto_show = false },
			},
			sources = {
				default = { "snippets", "lsp", "path", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		})
	end,
})
