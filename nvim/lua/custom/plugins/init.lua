-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return { -- NOTE: Neo-tree

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle left<CR>", {}),
		filesystem = {
			filtered_items = {
				hide_dotfiles = false, -- Show hidden files
			},
		},
	},
}
