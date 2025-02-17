-- Setup autotabs and indents
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.softtabstop = 4

require("config.lazy")

-- Configure Telescope 
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal left<CR>')
vim.keymap.set('n', '<leader>g', ':Neotree float git_status<CR>')

require('onedark').load()
