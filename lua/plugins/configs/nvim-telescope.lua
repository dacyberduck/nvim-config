local present, telescope = pcall(require,'telescope')
if not present then
  print "Error: telescope not found!!!"
  return 1
end

telescope.setup{
  defaults = {
    borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
    path_display = {"smart"},
    layout_config = {
      horizontal = {
        preview_width = 0.52,
      },
    },
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
      },
    },
  },
  pickers = {
    find_files = {
      theme = 'ivy',
      hidden = 1,
    },
    live_grep = {
      theme = 'ivy',
      hidden = 1,
    },
    grep_string = {
      theme = 'ivy',
      hidden = 1,
    },
  },
  extensions = {
    file_browser = {
      theme = 'ivy',
      hidden = 1,
      grouped = 1,
    },
    project = {
      hidden_files = 1,
    },
  },
}

require('project_nvim').setup()
telescope.load_extension('projects')
telescope.load_extension('file_browser')

vim.api.nvim_set_keymap("n","<Leader>tt", '<Cmd>Telescope<CR>', { noremap = true })
vim.api.nvim_set_keymap('n','<leader>tp','<Cmd>Telescope projects<CR>',{noremap = true})
vim.api.nvim_set_keymap('n','<leader>tf','<Cmd>lua require "telescope".extensions.file_browser.file_browser()<CR>',{noremap = true})
