return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		config = function()
			require("neo-tree").setup({
				window = {
					width = 25,
					close_if_last_window = true,
					mappings = {
						-- ["<2-LeftMouse>"] = "open_tabnew",
						["<2-LeftMouse>"] = "open",
						["<C-n>"] = "add",
						["<Del>"] = "delete",
						["a"] = "none",
						["d"] = "none"
					},
				},
				filesystem = {
					filtered_items = {
						visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
						hide_dotfiles = false,
						hide_gitignored = false,
    				},
				},
			})
		end,
	}
}
