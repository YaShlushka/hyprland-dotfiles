-- defines
local bind = vim.keymap.set
local opts = { noremap = true, silent = true }
local builtin = require('telescope.builtin')

-- copy on Ctrl + C
bind("v", "<C-c>", '"+y', opts)

-- cut on Ctrl + X
bind("v", "<C-x>", '"+d', opts)

-- select all on Ctrl + A
bind("n", "<C-a>", "ggVG", opts)
bind("i", "<C-a>", "<Esc>ggVG", opts)

-- delete when selected on Backspace or Delete
bind("v", "<BS>", '"_d', opts)
bind("v", "<Del>", '"_d', opts)

-- paste on Ctrl + V
bind("i", "<C-v>", '<Esc>"+p`]a', opts)
bind("n", "<C-v>", '"+p`]', opts)

-- Neotree toggle on Ctrl + t
bind("i", "<C-t>", "<Cmd>Neotree toggle<CR>", opts)
bind("n", "<C-t>", "<Cmd>Neotree toggle<CR>", opts)
bind("v", "<C-t>", "<Cmd>Neotree toggle<CR>", opts)

-- Nvim surround
bind("v", "(", "<Plug>(nvim-surround-visual))", { remap = true })
bind("v", "{", "<Plug>(nvim-surround-visual)}", { remap = true })
bind("v", "[", "<Plug>(nvim-surround-visual)]", { remap = true })
bind("v", "'", "<Plug>(nvim-surround-visual)'", { remap = true })
bind("v", "\"", "<Plug>(nvim-surround-visual)\"", { remap = true })

-- commentory on Ctrl + /
bind("n", "<C-/>", "<Cmd>CommentToggle<CR>", opts)
bind("v", "<C-/>", ":'<,'>CommentToggle<CR>gv", opts)
bind("i", "<C-/>", "<Cmd>CommentToggle<CR>", opts)

-- telescope binds
bind('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
bind('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
bind('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
bind('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

bind('n', '<C-f>', builtin.find_files, opts)
bind('n', '<C-g>', builtin.live_grep, opts)
bind('n', '<C-b>', builtin.buffers, opts)
bind('n', '<C-h>', builtin.help_tags, opts)

bind('i', '<C-f>', builtin.find_files, opts)
bind('i', '<C-g>', builtin.live_grep, opts)
bind('i', '<C-b>', builtin.buffers, opts)
bind('i', '<C-h>', builtin.help_tags, opts)

-- formatting
bind("n", "<A-F>", function() require("conform").format() end, opts)
