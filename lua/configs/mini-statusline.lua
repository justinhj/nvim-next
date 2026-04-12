local statusline = require('mini.statusline')

statusline.setup({
  content = {
    active = function()
      local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
      local git           = statusline.section_git({ trunc_width = 75 })
      local diff          = statusline.section_diff({ trunc_width = 75 })
      local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
      local filename      = statusline.section_filename({ trunc_width = 140 })
      local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })

      local battery = require("battery").get_status_line()

      return statusline.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
        { hl = 'MiniStatuslineDevinfo',  strings = { git, diff } },
        -- '%<', -- Truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        { hl = 'MiniStatuslineDevinfo',  strings = { diagnostics } },
        '%=', -- Right align split
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo, '%p%%' } },
        { hl = mode_hl,                  strings = { "%l:%c", battery } },
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
