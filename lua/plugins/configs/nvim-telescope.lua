require('project_nvim')
require('telescope').load_extension('projects')
require('telescope').load_extension('file_browser')

require('telescope').setup{
  defaults = {
    color_devicons = true,
    borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
    path_display = {"smart"},
    layout_config = {
      horizontal = {
        width_padding = 0.1,
        height_padding = 0.1,
        preview_width = 0.55,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 0.1,
        preview_width = 0.5,
      },
    },
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
      },
    },
  },
  pickers = {
    file_browser = {
      hidden = true,
    },
    find_files = {
      hidden = 1,
    },
  },
}

vim.api.nvim_set_keymap("n","<Leader>tt", '<Cmd>Telescope<CR>', { noremap = true })
vim.api.nvim_set_keymap('n','<leader>tp','<Cmd>Telescope projects<CR>',{noremap = true})
vim.api.nvim_set_keymap('n','<leader>tf','<Cmd>lua require "telescope".extensions.file_browser.file_browser()<CR>',{noremap = true})
