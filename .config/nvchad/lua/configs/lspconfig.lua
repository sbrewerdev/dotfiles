require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls" }
vim.lsp.enable(servers)

local mason_root = require("mason.settings").current.install_root_dir

vim.lsp.config("roslyn", {})
