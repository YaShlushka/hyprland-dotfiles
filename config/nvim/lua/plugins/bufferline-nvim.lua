return {
	{	"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		version = "*",
		config = function()
			require("bufferline").setup({
				options = {
					close_command = function(bufnr)
						require("bufdelete").bufdelete(bufnr, true)
					end,
					right_mouse_command = function(bufnr)
						require("bufdelete").bufdelete(bufnr, true)
					end,
					-- остальные опции bufferline
				}
			})
		end,
	}
}
