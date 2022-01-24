local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_compiled_path = vim.fn.stdpath("config").."/lua/packer_compiled.lua"
local present, packer = pcall(require,'packer')

if not present then
  -- clone packer if a packer.nvim directory does not
  -- exist at packer_path
  if vim.fn.isdirectory(packer_path) ~= 1 then
    print "Cloning packer..."
    -- remove the dir before cloning
    vim.fn.delete(packer_path, "rf")
    -- clone packer
    vim.fn.system({
      "git",
      "clone",
      "https://github.com/wbthomason/packer.nvim",
      "--depth",
      "20",
      packer_path
    })
    print("Successfully cloned packer at " .. packer_path)
  end
  -- try to add packer using packadd
  if pcall(vim.cmd,"packadd packer.nvim") then
    present, packer = pcall(require, "packer")
  end
  -- if packer is still not loaded, error out
  if not present then
    print("Error: couldn't load packer!!! disabling plugins!!!")
    return 1
  end
end

require('plugins.packer')
require('plugins.plugins')
require('plugins.autocmds')
