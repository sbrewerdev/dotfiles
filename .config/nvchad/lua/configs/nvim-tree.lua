dofile(vim.g.base46_cache .. "nvimtree")

return {
    on_attach = function(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set('n', 'A', function()
            local node = api.tree.get_node_under_cursor()
            local path = node.type == "directory" and node.absolute_path or vim.fs.dirname(node.absolute_path)
            require("easy-dotnet").create_new_item(path)
        end, opts('Create file from dotnet template'))
    end,
    actions = {
        open_file = {
            window_picker = {
                enable = false,
            },
            quit_on_open = true,
        },
    },
	filters = {
        dotfiles = false,
        custom = { ".DS_Store", "^\\._" },
    },
	disable_netrw = true,
	hijack_cursor = true,
    hijack_directories = {
        enable = false,
        auto_open = false,
    },
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = false,
		update_root = false,
	},
	view = {
		width = 35,
		preserve_window_proportions = true,
        side = "right"
	},
	renderer = {
		root_folder_label = false,
		highlight_git = true,
		indent_markers = { enable = true },
		icons = {
			glyphs = {
				default = "󰈚",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
				},
				git = { unmerged = "" },
			},
		},
	},
}
