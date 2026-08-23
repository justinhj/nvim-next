-- Adds Delete buffer with C-d

MiniPick.registry.buffers = function(local_opts)
  local delete_cur = function()
    local matches = MiniPick.get_picker_matches()
    if not (matches and matches.current and matches.current.bufnr) then
      return
    end
    local bufnr = matches.current.bufnr

    if _G.MiniBufremove then
      MiniBufremove.wipeout(bufnr, false) -- add `, true` to force
    else
      pcall(vim.api.nvim_buf_delete, bufnr, { force = false })
    end

    local items = MiniPick.get_picker_items() or {}
    MiniPick.set_picker_items(vim.tbl_filter(function(item)
      return item.bufnr ~= bufnr
    end, items))
  end

  return MiniPick.builtin.buffers(local_opts, {
    mappings = {
      wipeout = { char = '<C-d>', func = delete_cur },
    },
  })
end
