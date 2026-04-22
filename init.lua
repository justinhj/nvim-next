-- Justin's simple lua config
-- 0.12.x+ required

-- Set up VIM global options

-- Choose the leader key. Don't forget to go onto online forums
-- and argue for hours over which is the best key for this
-- Defines the leader key for custom shortcut mappings
vim.g.mapleader = ","
-- Prevents showing extra messages when using completion
vim.opt.shortmess:append("c")
-- Sets the height of the command line area at the bottom
vim.opt.cmdheight = 2
-- Displays the line number for the current line
vim.opt.number = true
-- Displays line numbers relative to the current cursor position
vim.opt.relativenumber = true
-- Time in milliseconds to wait for a mapped sequence to complete
vim.opt.timeoutlen = 500
-- Time in milliseconds of inactivity before calling CursorHold or writing to swap
vim.opt.updatetime = 4000
-- Ignores case when searching patterns
vim.opt.ignorecase = true
-- Automatically switches to case-sensitive search if a capital letter is used
vim.opt.smartcase = true
-- Enables 24-bit RGB colors in the terminal
vim.opt.termguicolors = true
-- Configures the behavior of the insert mode completion menu
vim.opt.completeopt = "menu,menuone,noselect,popup"
-- Number of spaces that a <Tab> character represents
vim.opt.tabstop = 2
-- Number of spaces to use for each step of automatic indentation
vim.opt.shiftwidth = 2
-- Number of spaces that a <Tab> counts for during editing operations
vim.opt.softtabstop = 2
-- Converts tabs into spaces when typing
vim.opt.expandtab = true
-- Automatically inserts an extra level of indentation in some cases
vim.opt.smartindent = true
-- Makes <Tab> insert 'shiftwidth' number of spaces at the start of a line
vim.opt.smarttab = true
-- Autocompletion
vim.o.autocomplete = true

-- New UI opt-in
require('vim._core.ui2').enable({})

-- Plugins for treesitter and lsp server management
vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main' },
})

-- Add each lsp server you want to enable here
local lsp_servers = {
  'pylsp',
  'clangd',
  'zls',
  'rust_analyzer',
  'lua_ls',
  'ts_ls',
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = lsp_servers,
  automatic_enable = false,
})

-- NOTE configs are in the lsp folder

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("*", {
  capabilities = capabilities,
})

-- Enable LSP completion (this connects LSP to the native menu)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
  callback = function(args)
    local client_id = args.data.client_id
    if not client_id then
      return
    end

    local client = vim.lsp.get_client_by_id(client_id)
    if client and client:supports_method("textDocument/completion") then
      -- Enable native LSP completion for this client + buffer
      vim.lsp.completion.enable(true, client_id, args.buf, {
        autotrigger = true, -- auto-show menu as you type (recommended)
        -- You can also set { autotrigger = false } and trigger manually with <C-x><C-o>
      })
    end
  end,
})

-- Verify a config file exists for an lsp server. This should be in the lsp folder.
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

require("nvim-treesitter.config").setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})

-- Quality of life plugins. Colorthemes, keymaps etc
vim.pack.add({
  { src = "https://github.com/shaunsingh/nord.nvim" },
})

vim.cmd('colorscheme nord')

-- Treat .dig files as yaml
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.dig',
  callback = function()
    vim.bo.filetype = 'yaml'
  end,
})

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

-- My own plugin for showing battery power levels in the statusline
vim.pack.add({
  {
    src = 'https://github.com/justinhj/battery.nvim',
    version = 'remove-plenary',
  },
})

require('configs/battery')

-- Small selection of mini plugins
vim.pack.add({
  {
    src = 'https://github.com/nvim-mini/mini.nvim',
    version = 'main',
  } })

require('mini.files').setup()
require('mini.git').setup()
require('mini.icons').setup()
require('mini.pick').setup()

require('configs/mini-clue')
require('configs/mini-statusline')

-- Key remapping and autocommands

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

-- User Commands

-- vim.pack

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

-- Experimental: Leap
vim.pack.add({ { src = 'https://codeberg.org/andyg/leap.nvim', version = 'main' } })

vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
