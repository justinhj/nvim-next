-- User Commands

-- vim.pack

-- Remove inactive packages
vim.api.nvim_create_user_command('VimPackDelInactive', function()
  local unused = vim.iter(vim.pack.get())
      :filter(function(x) return not x.active end)
      :map(function(x) return x.spec.name end)
      :totable()

  vim.pack.del(unused)
end, { desc = 'Remove inactive packages' })

-- lsp related

vim.api.nvim_create_user_command('LSPFormat', function()
  vim.lsp.buf.format()
end, { desc = 'Format the file using the LSP support' })
