return {
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  settings = {
    pylsp = {
          plugins = {
            mccabe = { enabled = false },
        pycodestyle = { enabled = false },
        flake8 = {
          enabled = true,
          ignore = { "E501", "E302", "W" },
          maxLineLength = 120,
        },
      },
    },
  },
}
