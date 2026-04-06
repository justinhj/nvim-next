-- Justin's amazing lua config
-- 0.12.0 required

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
vim.opt.completeopt = "menu,menuone,noselect"
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
vim.opt.completeopt = "menu,menuone,noselect,popup"

-- Provides support for managing LSP and Treesitter
vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = 'main' },
})

require("mason").setup()
require("mason-lspconfig").setup({
  -- TODO Add any that you want everywhere
  ensure_installed = {
    "lua_ls",
    "pylsp",
  },
  automatic_enable = true,
})

-- Enable LSPs
-- NOTE configs are in the lsp folder

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
        autotrigger = true,   -- auto-show menu as you type (recommended)
        -- You can also set { autotrigger = false } and trigger manually with <C-x><C-o>
      })
    end
  end,
})

vim.lsp.enable('pylsp') -- Python
vim.lsp.enable('clangd') -- C/C++
vim.lsp.enable('zls') -- Zig
vim.lsp.enable('rust_analyzer') -- Rust

-- Treesitter

require("nvim-treesitter.config").setup({
  ensure_installed = { "python",  },
  auto_install = true,
  highlight = {
    enable = true,
  },
})

-- Quality of life plugins. Colorthemes, keymaps etc

vim.pack.add({
  { src = "https://github.com/shaunsingh/nord.nvim" },
  { src = "https://github.com/mrjones2014/legendary.nvim" },
})

vim.cmd('colorscheme nord')
require('configs/legendary-keymaps')

-- New UI opt-in
require('vim._core.ui2').enable({})

-- Treat .dig files as yaml
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.dig',
  callback = function()
    vim.bo.filetype = 'yaml'
  end,
})

-- Selectively use colorizer
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

-- fzf-lua
-- File finding and search

vim.pack.add({
 { src = 'https://github.com/ibhagwan/fzf-lua' },
})

require('configs/fzf-lua')

-- which-key

vim.pack.add({
 { src = 'https://github.com/folke/which-key.nvim' },
})

require("which-key").setup({ delay = 1000 })

vim.pack.add({
 { src = 'https://github.com/justinhj/battery.nvim' },
 { src = 'https://github.com/nvim-lua/plenary.nvim' },
})

require("battery").setup({
  update_rate_seconds = 60,
  show_status_when_no_battery = false,
  show_plugged_icon = true,
  show_unplugged_icon = false,
  show_percent = true,
  vertical_icons = true,
  multiple_battery_selection = 1,
})

-- status line

vim.pack.add({
 { src = 'https://github.com/nvim-lualine/lualine.nvim' },
 { src = 'https://github.com/nvim-lualine/lualine.nvim' },
})

require('configs/lualine')
