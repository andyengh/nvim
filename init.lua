-- GENERAL SETTINGS
-- Dependencies
require("plugins")
require("keybindings")
require("lsp")

-- Plugin specific configs.
require("plugs.telescope")
require("plugs.luasnip")
require("plugs.lspkind")
require("plugs.cmp")
require("plugs.nvimtree")
require("plugs.null-ls")
require("plugs.barbar")
require('neoscroll').setup()
require('vgit').setup()
require("scrollbar").setup()
require('nvim-ts-autotag').setup()

-- Incremental live completion.
vim.o.inccommand = 'nosplit'

-- Set highlight on search.
vim.o.hlsearch = false

-- Make line numbers default.
vim.wo.number = true
vim.wo.relativenumber = true

-- Do not save when switching buffers.
vim.o.hidden = true

-- Enable mouse mode.
vim.o.mouse = 'a'

-- Enable break indent.
vim.o.breakindent = true

-- Save undo history.
vim.opt.undofile = true

-- Decrease update time.
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme.
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd[[
  colorscheme sonokai
  set colorcolumn=100
  autocmd FileType python setlocal shiftwidth=4 tabstop=4
]]
--tab spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

--Set statusbar.
vim.g.lightline = {
  colorscheme = 'sonokai',
  active = {
    left = {
      { 'mode', 'paste' },
      { 'gitbranch', 'readonly', 'filename', 'modified' }
    }
  },
  component_function = { gitbranch = 'FugitiveHead' },
}

-- Highlight on yank.
vim.api.nvim_exec(
  [[
    augroup YankHighlight
      autocmd!
      autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
  ]],
  false
)

-- Y yank until the end of line.
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })
