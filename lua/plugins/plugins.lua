local configs = {
  -- Useful plugins
  "plugins.configs.nvim-impatient",

  -- Treesitter
  "plugins.configs.nvim-treesitter",

  -- Lsp
  "plugins.configs.nvim-lspconfig",

  -- Snippets
  "plugins.configs.nvim-snippets",

  -- Completion
  "plugins.configs.nvim-completion",

  -- Telescope and plugins
  "plugins.configs.nvim-telescope",

  -- Colorschemes
  "plugins.configs.nvim-colorscheme",

  -- Statusline and Tabline
  "plugins.configs.nvim-statusline",
  "plugins.configs.nvim-bufferline",

  -- Misc plugins
  "plugins.configs.nvim-gitsigns",
  "plugins.configs.nvim-colorizer",
  "plugins.configs.nvim-indentline",
  "plugins.configs.nvim-comment",
  "plugins.configs.nvim-whichkey",
}

for i = 1, #configs, 1 do
  require(configs[i])
end
