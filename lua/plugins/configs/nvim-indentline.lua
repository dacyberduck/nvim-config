require("indent_blankline").setup {
  -- use_treesitter = true,
  filetype_exclude = {
    "aerial",
    "alpha",
    "help",
    "gitcommit",
    "dashboard",
    "NvimTree",
    "packer",
    "lspinfo",
    "Startify",
    "TelescopePrompt",
    "TelescopeResults",
    "terminal",
    "Trouble",
    "undotree",
    "ChadTree",
  },
  buftype_exclude = { "terminal", "nofile" },
}