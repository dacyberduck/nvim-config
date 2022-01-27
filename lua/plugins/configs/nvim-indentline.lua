local present, indentline = pcall(require,'indent_blankline')
if not present then
  print "Error: indent-blankline not found!!!"
  return 1
end

indentline.setup {
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
