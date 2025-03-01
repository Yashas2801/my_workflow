return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false, -- Ensures it loads on startup
	opts = {
		-- Main dashboard configuration
		dashboard = {
			enabled = true,
			width = 60,
			row = nil, -- dashboard position. nil for center
			col = nil, -- dashboard position. nil for center
			pane_gap = 4, -- empty columns between vertical panes
			autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
			preset = {
				pick = nil, -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					-- Added <leader>l for Lazygit (accessible from dashboard)
					{ icon = " ", key = "l", desc = "Lazygit", action = ":lua Snacks.lazygit.open()" },
				},
				header = [[

██╗   ██╗ ██╗     ███████╗ ██╗
██║   ██║ ██║     ██╔════╝ ██║
██║   ██║ ██║     ███████╗ ██║
╚██╗ ██╔╝ ██║     ╚════██║ ██║
   ╚████╔╝  ███████╗███████║ ██║  
  ╚═══╝   ╚══════╝╚══════╝ ╚═╝

███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
			},
			-- Rest of the dashboard config remains unchanged
			formats = {
				icon = function(item)
					if item.file and (item.icon == "file" or item.icon == "directory") then
						return M.icon(item.file, item.icon)
					end
					return { item.icon, width = 2, hl = "icon" }
				end,
				footer = { "%s", align = "center" },
				header = { "%s", align = "center" },
				file = function(item, ctx)
					local fname = vim.fn.fnamemodify(item.file, ":~")
					fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
					if #fname > ctx.width then
						local dir = vim.fn.fnamemodify(fname, ":h")
						local file = vim.fn.fnamemodify(fname, ":t")
						if dir and file then
							file = file:sub(-(ctx.width - #dir - 2))
							fname = dir .. "/…" .. file
						end
					end
					local dir, file = fname:match("^(.*)/(.+)$")
					return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
				end,
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
				{
					section = "terminal",
					cmd = "ascii-image-converter https://raw.githubusercontent.com/Yashas2801/my_workflow/ac4c2b5b892fd004ac0db545fe56f251514f5986/cpu_vector.jpg -b -c -n",
					random = 10,
					pane = 2,
					indent = 4,
					height = 40,
				},
			},
		},

		-- Indent configuration (unchanged)
		indent = {
			priority = 1,
			enabled = true,
			char = "│",
			only_scope = false,
			only_current = false,
			hl = "SnacksIndent",
			animate = {
				enabled = vim.fn.has("nvim-0.10") == 1,
				style = "out",
				easing = "linear",
				duration = {
					step = 20,
					total = 500,
				},
			},
			scope = {
				enabled = true,
				priority = 200,
				char = "│",
				underline = false,
				only_current = false,
				hl = "SnacksIndentScope",
			},
			chunk = {
				enabled = false,
				only_current = false,
				priority = 200,
				hl = "SnacksIndentChunk",
				char = {
					corner_top = "┌",
					corner_bottom = "└",
					horizontal = "─",
					vertical = "│",
					arrow = ">",
				},
			},
			filter = function(buf)
				return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
			end,
		},

		-- Animation settings (unchanged)
		animate = {
			duration = 20,
			easing = "linear",
			fps = 60,
		},

		-- Notifier configuration (unchanged)
		notifier = {
			timeout = 3000,
			width = { min = 40, max = 0.4 },
			height = { min = 1, max = 0.6 },
			margin = { top = 0, right = 1, bottom = 0 },
			padding = true,
			sort = { "level", "added" },
			level = vim.log.levels.TRACE,
			icons = {
				error = " ",
				warn = " ",
				info = " ",
				debug = " ",
				trace = " ",
			},
			keep = function(notif)
				return vim.fn.getcmdpos() > 0
			end,
			style = "compact",
			top_down = true,
			date_format = "%R",
			more_format = " ↓ %d lines ",
			refresh = 50,
		},

		-- Lazygit integration (unchanged, except for optional global keybinding comment)
		lazygit = {
			configure = true, -- Automatically configure lazygit with Neovim colorscheme
			config = {
				os = { editPreset = "nvim-remote" },
				gui = {
					nerdFontsVersion = "3", -- Use Nerd Fonts v3
				},
			},
			theme_path = vim.fn.stdpath("cache") .. "/lazygit-theme.yml",
			theme = {
				[241] = { fg = "Special" },
				activeBorderColor = { fg = "MatchParen", bold = true },
				cherryPickedCommitBgColor = { fg = "Identifier" },
				cherryPickedCommitFgColor = { fg = "Function" },
				defaultFgColor = { fg = "Normal" },
				inactiveBorderColor = { fg = "FloatBorder" },
				optionsTextColor = { fg = "Function" },
				searchingActiveBorderColor = { fg = "MatchParen", bold = true },
				selectedLineBgColor = { bg = "Visual" },
				unstagedChangesColor = { fg = "DiagnosticError" },
			},
			win = {
				style = "lazygit",
			},
			-- Optional: For a global <leader>l keybinding, add this elsewhere in your config:
			-- vim.keymap.set("n", "<leader>l", ":lua Snacks.lazygit.open()<CR>", { noremap = true, silent = true })
		},
	},
}
