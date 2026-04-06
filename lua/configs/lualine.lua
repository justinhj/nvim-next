local nvimbattery = {
  function()
    return require("battery").get_status_line()
  end,
}

local chatty_ai = {
  function()
    return require("chatty-ai").status()
  end,
}

local filename_widget = {
  "filename",
  file_status = true,
  newfile_staus = true,
  path = 0,
  symbols = {
    modified = " ",
    readonly = " ",
    unnamed = "[No Name]",
    newfile = " ",
  },
}

local diagnostics_widget = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "info", "hint" },
  symbols = {
    error = " ",
    warn = " ",
    info = " ",
  },
}

local styles = {
  powerline = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  plain = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  plain_separators = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "│", right = "│" },
  },
  slant_low = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  slant_high = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  round = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  pixel = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
}

local style = styles.plain
require("lualine").setup({
  options = {
    section_separators = style.section_separators,
    component_separators = style.component_separators,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { filename_widget, diagnostics_widget },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location", nvimbattery, chatty_ai },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename_widget, diagnostics_widget },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
