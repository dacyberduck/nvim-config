local configs = {
  -- Impatient plugin
  "plugins.configs.nvim-impatient",

  -- Treesitter
  "plugins.configs.nvim-treesitter",

  -- Colorschemes
  "plugins.configs.nvim-colorscheme",

  -- Telescope and plugins
  "plugins.configs.nvim-telescope",

  -- Statusline and Tabline
  "plugins.configs.nvim-statusline",

  -- Misc plugins
  "plugins.configs.nvim-gitsigns",
  "plugins.configs.nvim-colorizer",
  "plugins.configs.nvim-indentline",
  "plugins.configs.nvim-comment",
  "plugins.configs.nvim-whichkey",
}

for i = 1, #configs, 1 do
  -- pcall(require,configs[i])
  require(configs[i])
end
