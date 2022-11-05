local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettierd,
    formatting.black.with({ extra_args = { "--fast", "-l 100" } }),
    diagnostics.eslint_d.with({diagnostics_format = '[eslint] #{m}\n(#{c})'}),
    diagnostics.pylint.with({ extra_args = { "--load-plugins=pylint_odoo", "-e odoolint" } }),
  },
})
