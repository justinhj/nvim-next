local map = vim.keymap.set

map('i', '<C-Space>', function() vim.lsp.completion.get() end, { desc = 'Trigger LSP completion' })

-- MiniFiles
map('n', '<leader>fe', function() MiniFiles.open() end, { desc = 'Open MiniFiles explorer' })

-- Lua evaluate current file
map('n', '<leader><leader>l', ':luafile %<CR>', { desc = 'Lua evaluate current file' })

-- Easier window movement
map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to bottom window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to top window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Mini Jump2d
map({ 'n', 'x', 'o' }, 's', function()
  MiniJump2d.start(MiniJump2d.builtin_opts.query)
end, { silent = true, nowait = true, desc = 'Mini Jump2d to query', noremap = true })

-- Mini Pick
map('n', '<Leader>ff', function()
  require('mini.pick').builtin.files({ tool = 'fd' })
end, { silent = true, nowait = false, desc = 'Pick files' })

map('n', '<Leader>lg', function()
  require('mini.pick').builtin.grep({ tool = 'rg' })
end, { silent = true, nowait = false, desc = 'Pick grep' })

map('n', '<Leader>ll', function()
  require('mini.pick').builtin.grep_live({ tool = 'rg' })
end, { silent = true, nowait = false, desc = 'Pick grep_live' })

map('n', '<Leader>lc', function()
  require('mini.pick').builtin.resume()
end, { silent = true, nowait = false, desc = 'Pick resume' })
