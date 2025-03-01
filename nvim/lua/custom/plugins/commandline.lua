return {
	{
		"hrsh7th/cmp-cmdline",
		dependencies = {
			"hrsh7th/nvim-cmp", -- make sure nvim-cmp is installed
		},
		config = function()
			local cmp = require("cmp")
			local api = vim.api

			-- Define your desired floating window dimensions.
			local width = 60
			local height = 10
			local center_window = {
				-- Use 'editor' as the reference for absolute screen positioning.
				relative = "editor",
				anchor = "NW", -- We'll calculate col/row so top-left is at our computed position.
				row = math.floor((vim.o.lines - height) / 2 - 1), -- adjust for command line height
				col = math.floor((vim.o.columns - width) / 2),
				width = width,
				height = height,
				border = "rounded",
			}

			-- Setup for '/' search mode using buffer completion.
			cmp.setup.cmdline("/", {
				window = {
					completion = center_window,
					documentation = center_window,
				},
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Setup for ':' command-line mode using both path and cmdline sources.
			cmp.setup.cmdline(":", {
				window = {
					completion = center_window,
					documentation = center_window,
				},
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" }, -- adjust as needed
						},
					},
				}),
			})
		end,
		opts = {
			treat_trailing_slash = true, -- automatically removes trailing slashes from path completions
		},
	},
}
