-- justinhj Neovim config
-- 0.12.0 or later required

-- New UI opt-in
require('vim._core.ui2').enable({})

require('configs.autocmds')
require('configs.cmds')
require('configs.options')
require('configs.keymaps')

-- Plugins for treesitter and lsp server management (Mason)
vim.pack.add({
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
})

-- Setup LSP

-- Add each lsp server you want to enable here
-- Add the config to the lsp folder
-- Each LSP server will be added by Mason and enabled
local lsp_servers = {
  'pylsp',
  'clangd',
  'zls',
  'rust_analyzer',
  'lua_ls',
  'ts_ls',
}

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = lsp_servers,
  automatic_enable = false,
})

-- Enable snippets (built in)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('*', {
  capabilities = capabilities,
})

-- Enable LSP completion (this connects LSP to the native menu)

local function has_lsp_config(server_name)
  local config_path = vim.fn.stdpath("config")
  local target_path = vim.fs.joinpath(config_path, "lsp", server_name .. ".lua")
  if vim.uv.fs_stat(target_path) then
    return true
  else
    return false
  end
end

vim.iter(lsp_servers):each(
function(lsp_server)
  if not has_lsp_config(lsp_server) then
    vim.api.nvim_echo({ { 'Warning. lsp server ' .. lsp_server .. ' has no config file in the config lsp folder.' , 'WarningMsg' } }, true, {})
    else
      vim.lsp.enable(lsp_server)
  end
end
)

-- Treesitter

require('nvim-treesitter.config').setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})

-- Quality of life plugins. Colorthemes, keymaps etc
vim.pack.add({
  { src = 'https://github.com/shaunsingh/nord.nvim' },
})

vim.cmd('colorscheme nord')

-- Colorizer shows html and other colour encodings in their colour
vim.pack.add({
  { src = 'https://github.com/NvChad/nvim-colorizer.lua' },
})

require 'colorizer'.setup {
  'css',
  'javascript',
  html = {
    mode = 'foreground',
  }
}

-- vim.opt.runtimepath:append("~/projects/battery.nvim")

-- My own plugin for showing battery power levels in the statusline
vim.pack.add({
  {
    src = 'https://github.com/justinhj/battery.nvim',
    version = 'main',
  },
})
require('configs/battery')

-- Small selection of mini plugins
vim.pack.add({
  {
    src = 'https://github.com/nvim-mini/mini.nvim',
    version = 'main',
  } })

require('mini.extra').setup()
require('mini.git').setup()
require('mini.icons').setup()
require('mini.jump2d').setup()
require('mini.pick').setup()

require('configs/mini-files')
require('configs/mini-clue')
require('configs/mini-statusline')

-- Key remapping, autocommands and user commands


