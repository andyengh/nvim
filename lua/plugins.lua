-- PLUGINS

-- Install packer.
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute(
    '!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
    augroup Packer
      autocmd!
      autocmd BufWritePost init.lua PackerCompile
    augroup end
  ]],
  false
)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use 'tpope/vim-surround'
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'} }
  -- use 'folke/tokyonight.nvim'
  -- use 'dikiaap/minimalist'
  use 'sainnhe/sonokai'
  use 'maxmellon/vim-jsx-pretty'
  use 'bluz71/vim-moonfly-colors'
  use 'tanvirtin/monokai.nvim'
  use 'itchyny/lightline.vim' -- Fancier statusline
  -- Add git related info in the signs columns and popups
  use 'f-person/git-blame.nvim' 
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  use 'karb94/neoscroll.nvim'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'}
  use { 
    'alexghergh/nvim-tmux-navigation',
    config = function()
      require'nvim-tmux-navigation'.setup {
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
            left = "<C-h>",
            down = "<C-j>",
            up = "<C-k>",
            right = "<C-l>",
            last_active = "<C-\\>",
            next = "<C-Space>",
        }
      }
  end
  }
  -- completatoin
  use 'hrsh7th/nvim-cmp'
  use { "zbirenbaum/copilot.lua",
  event = { "VimEnter" },
  config = function()
    vim.defer_fn(function()
      require("copilot").setup()
    end, 100)
  end,
  }
  use { "zbirenbaum/copilot-cmp",
  after = { "copilot.lua" },
  config = function ()
    require("copilot_cmp").setup()
  end
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'onsails/lspkind.nvim'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use {
    'windwp/nvim-autopairs',
    config = function() require'nvim-autopairs'.setup {} end}
  use 'windwp/nvim-ts-autotag'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'nikvdp/ejs-syntax'
  use 'norcalli/nvim-colorizer.lua'
  use 'lewis6991/spellsitter.nvim'
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        dimming = {
          alpha = 0.25, -- amount of dimming
          -- we try to get the foreground from the highlight groups or fallback color
          color = { "Normal", "#ffffff" },
          term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
          inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
        },
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use 'RRethy/vim-illuminate'
  use {
    'tanvirtin/vgit.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use "petertriho/nvim-scrollbar"
  use 'jamestthompson3/nvim-remote-containers'

end
)
