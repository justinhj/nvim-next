require('mini.files').setup()

-- This autocmd triggers when the mini files window opens and sets up 
-- Return key handling that differs from the default... it opens a directory
-- into the right window Or if it is a file it closes the explorer and shows
-- the file in the original buffer that opened the explorer.
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set('n', '<CR>', function()
      local entry = MiniFiles.get_fs_entry()
      if entry == nil then
        return
      end

      if entry.fs_type == 'directory' then
        MiniFiles.go_in({ close_on_file = false })
      else
        MiniFiles.go_in({ close_on_file = true })
      end
    end, { buffer = buf_id, desc = 'Open and close explorer' })
  end,
})
