-- Legendary keymaps
-- Legendary is archived but it still works nicely

require("legendary").setup({
  keymaps = {
    { "<leader><leader>l", ":luafile %<CR>", description = "Lua evaluate current file" },
    -- Easier window movement
    { "<C-h>", "<C-w>h" },
    { "<C-j>", "<C-w>j" },
    { "<C-k>", "<C-w>k" },
    { "<C-l>", "<C-w>l" },
    -- -- Lsp code action
    -- { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
    -- Snipe https://github.com/yangmillstheory/vim-snipe
    -- { "<leader><leader>f", "<Plug>(snipe-f)" },
    -- { "<leader><leader>F", "<Plug>(snipe-F)" },
  },
  autocmds = {
    -- This fixes annoying auto comments on newline
    { "FileType", [[lua vim.opt_local.formatoptions:remove {'o', 'r'}]] },
  },
  commands = {
    -- easily create user commands
    {
      ":LSPFormat",
      function()
        vim.lsp.buf.format()
      end,
      description = "Format the file using the lsp support",
    },
  },
})
