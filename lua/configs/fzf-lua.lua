require "fzf-lua".setup { defaults = { git_icons = false } }

vim.api.nvim_set_keymap(
  "n",
  "<Leader>ff",
  [[<Cmd>lua require('fzf-lua').files({resume = false})<CR>]],
  { nowait = false, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>lg",
  [[<Cmd>lua require('fzf-lua').live_grep()<CR>]],
  { nowait = false, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>lc",
  [[<Cmd>lua require('fzf-lua').live_grep({resume = true})<CR>]],
  { nowait = false, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>cb",
  [[<Cmd>lua require('fzf-lua').grep_curbuf()<CR>]],
  { nowait = false, silent = true }
)

-- Add gr and gD from lsp mappings to here to use the 
-- fzf-lua mappings
