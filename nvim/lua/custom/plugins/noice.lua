return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			cmdline = {
				enabled = true, -- Enable Noice's cmdline UI
				view = "cmdline_popup", -- Use the popup view for the cmdline
				format = {
					cmdline = { pattern = "^:", icon = "", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
					filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
					lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
					help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
					input = { view = "cmdline_input", icon = "󰥻 " },
				},
			},
			views = {
				cmdline_popup = {
					position = {
						row = "70%", -- Vertically center the popup
						col = "50%", -- Horizontally center the popup
					},
					size = {
						width = 80, -- Fixed width; adjust as needed
						height = "auto", -- Height adjusts automatically based on content
					},
					border = {
						style = "rounded", -- Rounded borders
					},
					win_options = {
						winblend = 10, -- Increase winblend for more transparency (adjust 0-100 as desired)
					},
				},
			},
			presets = {
				bottom_search = false, -- Disable preset bottom search cmdline
				command_palette = false, -- Disable preset command palette
				long_message_to_split = false, -- Keep long messages in their default view
				inc_rename = false, -- Disable incremental rename input dialog
				lsp_doc_border = false, -- Disable border for LSP docs
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
}
