-- Neovim Configuration inspired by YetAnotherNeovimConfig
-- Author: dacyberduck <thecyberduck@tutanota.com>

-- disable unused inbuilt plugins
vim.g.loaded_gzip              = 1
vim.g.loaded_tar               = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_zip               = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_getscript         = 1
vim.g.loaded_getscriptPlugin   = 1
vim.g.loaded_vimball           = 1
vim.g.loaded_vimballPlugin     = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_netrwSettings     = 1
vim.g.loaded_netrwFileHandlers = 1

-- create cache_dir and sub directories
-- check if the dir exists and create if not
local cache_dir = vim.fn.stdpath('cache')
if vim.fn.isdirectory(cache_dir) == 0 then
  os.execute("mkdir -p " .. cache_dir)
end
for _,dir in pairs({"/undo","/backup","/swap"}) do
  if vim.fn.isdirectory(cache_dir .. dir) == 0 then
    os.execute("mkdir -p " .. cache_dir .. dir)
  end
end

-- map leader key to space
vim.g.mapleader = " "
vim.api.nvim_set_keymap('n', ' ', '', {noremap = true})
vim.api.nvim_set_keymap('x', ' ', '', {noremap = true})

require('core')
require('plugins')
