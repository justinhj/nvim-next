-- Some useful utility functions
local M = {}

M.create_lsp_attach_autocmd = function()
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
end

-- Verify a config file exists for an lsp server. This should be in the lsp folder.
M.has_lsp_config = function(server_name)
  local config_path = vim.fn.stdpath("config")
  local target_path = vim.fs.joinpath(config_path, "lsp", server_name .. ".lua")
  if vim.uv.fs_stat(target_path) then
    return true
  else
    return false
  end
end

return M
