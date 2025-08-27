local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.pywal"),
	require("plugins.neotree"),
	require("plugins.lualine"),
	require("plugins.auto-pairs"),
	require("plugins.nvim-surround"),
	require("plugins.comment-nvim"),
	require("plugins.bufferline-nvim"),
	require("plugins.treesitter"),
	{"neovim/nvim-lspconfig"},
	{"hrsh7th/cmp-nvim-lsp"},
	{"hrsh7th/cmp-buffer"},
	{"hrsh7th/cmp-path"},
	{"hrsh7th/cmp-cmdline"},
	{"hrsh7th/cmp-vsnip"},
	{"hrsh7th/vim-vsnip"},
	{"rafamadriz/friendly-snippets"},
	{"hrsh7th/nvim-cmp"},
	require("plugins.mason"),
	require("plugins.telescope"),
	require("plugins.conform"),
	require("plugins.bufdelete")
})
