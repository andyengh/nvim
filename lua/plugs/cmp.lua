local cmp = require'cmp'
local lspkind = require'lspkind'
local luasnip = require('luasnip')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local handlers = require('nvim-autopairs.completion.handlers')

local completeopt=menu,menuone,noselect


  lspkind.init({
    symbol_map = {
      Copilot = "",
    },
  })

  cmp.setup({
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol",
        max_width = 50,
        symbol_map = { Copilot = "" }
      })
    },
    snippet = {
      expand = function(args)
        print "expand"
        luasnip.lsp_expand(args.body)
      end
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
    }),
    sources = cmp.config.sources({
      { name = 'luasnip' }, -- For luasnip users.
      { name = 'path'},
      { name = 'copilot', group_index = 2},
      { name = 'nvim_lsp', group_index = 2  },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  -- cmp.setup.cmdline(':', {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = cmp.config.sources({
  --     { name = 'path' }
  --   }, {
  --     { name = 'cmdline' }
  --   })
  -- })

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})

  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done({
      filetypes = {
        -- "*" is a alias to all filetypes
        ["*"] = {
          ["("] = {
            kind = {
              cmp.lsp.CompletionItemKind.Function,
              cmp.lsp.CompletionItemKind.Method,
            },
            handler = handlers["*"]
          }
        },
        lua = {
          ["("] = {
            kind = {
              cmp.lsp.CompletionItemKind.Function,
              cmp.lsp.CompletionItemKind.Method
            },
            ---@param char string
            ---@param item item completion
            ---@param bufnr buffer number
            handler = function(char, item, bufnr)
              -- Your handler function. Inpect with print(vim.inspect{char, item, bufnr})
            end
          }
        },
        -- Disable for tex
        tex = false
      }
    })
  )

  cmp.setup({
    mapping = {
      ['<Tab>'] = cmp.mapping(function(fallback)
          local col = vim.fn.col('.') - 1
          if cmp.visible() then
            cmp.select_next_item(select_opts)
          elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            fallback()
          else
            cmp.complete()
          end
        end, {'i', 's'}),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item(select_opts)
        else
          fallback()
        end
      end, {'i', 's'}),
      ["<CR>"] = cmp.mapping.confirm({
        -- this is the important line
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
    }
  })

