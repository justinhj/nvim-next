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

-- Provides support for managing LSP and Treesitter
vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
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

vim.lsp.enable('pylsp') -- Python
vim.lsp.enable('clangd') -- C/C++

-- Treesitter

require("nvim-treesitter.config").setup({
  ensure_installed = { "python", "lua", "vim", "vimdoc", "query" },
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

