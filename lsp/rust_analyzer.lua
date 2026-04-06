return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      allFeatures = true,
      overrideCommand = {
        "cargo",
        "clippy",
        "--workspace",
        "--message-format=json",
        "--all-targets",
        "--all-features",
      },
      assist = {
        importGranularity = "module",
        importPrefix = "by_self",
      },
      inlayHints = {
        enable = false,
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
    },
  }
}
