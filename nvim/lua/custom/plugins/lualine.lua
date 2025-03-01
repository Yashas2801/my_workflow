return {
	"nvim-lualine/lualine.nvim",
	priority = 1000,
	lazy = false, -- Ensures lualine loads on startup
	opts = (function()
		-- Define Catppuccin palettes for each flavour
		local catppuccin = {
			latte = {
				red = "#d20f39", -- Latte red
				grey = "#6c6f85", -- Latte subtext/grey
				black = "#eff1f5", -- Latte base (light background)
				white = "#4c4f69", -- Latte text
				light_green = "#40a02b", -- Latte green
				orange = "#fe8019", -- Latte peach/orange
				green = "#40a02b", -- Latte green
			},
			frappe = {
				red = "#e78284", -- Frappe red
				grey = "#949cbb", -- Frappe grey
				black = "#303446", -- Frappe base (dark background)
				white = "#c6d0f5", -- Frappe text
				light_green = "#a6d189", -- Frappe green
				orange = "#e5c890", -- Frappe peach/orange
				green = "#a6d189", -- Frappe green
			},
			macchiato = {
				red = "#ed8796", -- Macchiato red
				grey = "#a5adcb", -- Macchiato grey
				black = "#303446", -- Macchiato base (dark background)
				white = "#cad3f5", -- Macchiato text
				light_green = "#a6da95", -- Macchiato green
				orange = "#f5a97f", -- Macchiato peach/orange
				green = "#a6da95", -- Macchiato green
			},
			mocha = {
				red = "#f38ba8", -- Mocha red
				grey = "#484f5c", -- Even darker Mocha grey
				black = "#1e1e2e", -- Mocha base (dark background)
				white = "#cdd6f4", -- Mocha text
				light_green = "#a6e3a1", -- Mocha green
				orange = "#fab387", -- Mocha peach/orange
				green = "#a6e3a1", -- Mocha green
			},
		}

		-- Change this value to "latte", "frappe", "macchiato", or "mocha"
		local selected_flavor = "mocha"
		local colors = catppuccin[selected_flavor]

		local theme = {
			normal = {
				a = { fg = colors.white, bg = colors.black },
				b = { fg = colors.white, bg = colors.grey },
				c = { fg = colors.black, bg = colors.white },
				z = { fg = colors.white, bg = colors.black },
			},
			insert = { a = { fg = colors.black, bg = colors.light_green } },
			visual = { a = { fg = colors.black, bg = colors.orange } },
			replace = { a = { fg = colors.black, bg = colors.green } },
		}

		-- Define empty as a function returning an empty string.
		local empty = function()
			return ""
		end

		-- Process sections to insert empty gaps and set proper separators.
		local function process_sections(sections)
			for name, section in pairs(sections) do
				local left = name:sub(9, 10) < "x"
				for pos = 1, (name ~= "lualine_z" and #section or #section - 1) do
					table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white } })
				end
				for id, comp in ipairs(section) do
					if type(comp) ~= "table" then
						comp = { comp }
						section[id] = comp
					end
					comp.separator = left and { right = "" } or { left = "" }
				end
			end
			return sections
		end

		local function search_result()
			if vim.v.hlsearch == 0 then
				return ""
			end
			local last_search = vim.fn.getreg("/")
			if not last_search or last_search == "" then
				return ""
			end
			local searchcount = vim.fn.searchcount({ maxcount = 9999 })
			return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
		end

		local function modified()
			if vim.bo.modified then
				return "+"
			elseif vim.bo.modifiable == false or vim.bo.readonly == true then
				return "-"
			end
			return ""
		end

		return {
			options = {
				theme = theme,
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = process_sections({
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					"diff",
					{
						"diagnostics",
						source = { "nvim" },
						sections = { "error" },
						diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
					},
					{
						"diagnostics",
						source = { "nvim" },
						sections = { "warn" },
						diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
					},
					{ "filename", file_status = false, path = 1 },
					{ modified, color = { bg = colors.red } },
					{
						"%w",
						cond = function()
							return vim.wo.previewwindow
						end,
					},
					{
						"%r",
						cond = function()
							return vim.bo.readonly
						end,
					},
					{
						"%q",
						cond = function()
							return vim.bo.buftype == "quickfix"
						end,
					},
				},
				lualine_c = {},
				lualine_x = {},
				lualine_y = { search_result, "filetype" },
				lualine_z = { "%l:%c", "%p%%/%L" },
			}),
			inactive_sections = {
				lualine_c = { "%f %y %m" },
				lualine_x = {},
			},
			tabline = {},
			extensions = {},
		}
	end)(),
}
