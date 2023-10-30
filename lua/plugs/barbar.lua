local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<S-TAB>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<TAB>', '<Cmd>BufferNext<CR>', opts)
map('n', '<Leader>q', '<Cmd>BufferClose<CR>', opts)

