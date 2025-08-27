return {
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true,
		opts = {
			disable_filetype = { "markdown", "txt", "" },
		}
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	}
}
