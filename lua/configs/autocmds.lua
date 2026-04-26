local my_augroup = vim.api.nvim_create_augroup('CustomSettings', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = my_augroup,
  pattern = '*', -- apply to all filetypes
  callback = function()
    -- This fixes annoying auto comments on newline
    vim.opt_local.formatoptions:remove({ 'r', 'o' })
  end,
  desc = 'Disable auto-commenting on new lines'
})
