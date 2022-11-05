require'nvim-tree'.setup {
  view = {
    side = 'left'
  }
}

vim.api.nvim_set_keymap(
  'n', '<C-n>',
  [[<cmd>NvimTreeToggle<CR>]],
  { noremap = true, silent = true })
