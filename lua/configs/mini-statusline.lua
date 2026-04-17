local statusline = require('mini.statusline')

statusline.setup({
  content = {
    active = function()
      local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
      local git           = statusline.section_git({ trunc_width = 75 })
      local diagnostics   = vim.diagnostic.status()
      local filename      = statusline.section_filename({ trunc_width = 140 })
      local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })
      local progress      = vim.ui.progress_status()
      local is_busy       = vim.bo.busy > 0 and ' 󰜺 ' or ''
      local battery       = require("battery").get_status_line()

      return statusline.combine_groups({
        { hl = mode_hl,                 strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git } },
        '%<', -- Truncate here
        { hl = 'MiniStatuslineFilename', strings = { filename, is_busy } },
        { hl = 'MiniStatuslineDevinfo',  strings = { diagnostics } },
        '%=', -- Right align
        { hl = 'MiniStatuslineDevinfo',  strings = { progress } },
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { battery, "%l:%c" } },
      })
    end,

    -- Matches your lualine 'inactive_sections'
    inactive = function()
      local filename = statusline.section_filename({ trunc_width = 140 })
      return statusline.combine_groups({
        { hl = 'MiniStatuslineInactive', strings = { filename } },
      })
    end
  },
  -- If you want to use symbols for separators, you define them here:
  set_vim_settings = true,
})
