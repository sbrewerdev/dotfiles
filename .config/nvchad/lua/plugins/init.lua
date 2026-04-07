return {
    -- {
    --     "uhs-robert/oasis.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("oasis").setup {
    --             style = "abyss",
    --             transparent = true,
    --         } -- (see Configuration below for all customization options)
    --         -- vim.cmd.colorscheme "oasis-abyss" -- After setup, apply theme (or any style like "oasis-night")
    --     end,
    -- },
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        opts = require "configs.conform",
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
            },
            ensure_installed = {
                "lua-language-server",

                "xmlformatter",
                "csharpier",
                "prettier",

                "stylua",
                "bicep-lsp",
                "html-lsp",
                "css-lsp",
                "eslint-lsp",
                "typescript-language-server",
                "json-lsp",
                "rust-analyzer",

                "roslyn",
            },
        },
    },
    {
        "alexghergh/nvim-tmux-navigation",
        lazy = false,
        opts = {
            enabled = true,
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        opts = function()
            return require "configs.nvim-tree"
        end,
    },
    {
        "echasnovski/mini.nvim",
        lazy = false,
        version = false,
        enabled = true,
        config = function()
            require "configs.mini"
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        enabled = true,
        opts = {},
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require "configs.noice"
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        lazy = false,
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = require "configs.render-markdown",
    },
    {
        "bullets-vim/bullets.vim",
        lazy = false,
        config = function()
            vim.g.bullets_delete_last_bullet_if_empty = 1
        end,
    },
    {
        "hat0uma/csvview.nvim",
        ---@module "csvview"
        ---@type CsvView.Options
        opts = {
            parser = { comments = { "#", "//" } },
            view = {
                --- @type integer
                spacing = 1,

                ---@type CsvView.Options.View.DisplayMode
                display_mode = "border",
            },
            keymaps = {
                -- Text objects for selecting fields
                textobject_field_inner = { "if", mode = { "o", "x" } },
                textobject_field_outer = { "af", mode = { "o", "x" } },
                -- Excel-like navigation:
                -- Use <Tab> and <S-Tab> to move horizontally between fields.
                -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
                -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
                jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
                jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
                jump_next_row = { "<Enter>", mode = { "n", "v" } },
                jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
            },
        },
        cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    },
    -- test new blink
    -- { import = "nvchad.blink.lazyspec" },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "lua",
                "markdown",
                "markdown_inline",
                "bash",
                "vim",
                "vimdoc",
                "hyprlang",
                "html",
                "css",

                "c_sharp",
                "razor",
            },
        },
    },
    {
        "ianklapouch/wildberries.nvim",
        name = "wildberries",
    },
    {
        "seblyng/roslyn.nvim",
        ---@module 'roslyn.config'
        ---@type RoslynNvimConfig
        ft = { "cs", "razor" },
        opts = {
            -- your configuration comes here; leave empty for default settings
        },
    },
}
