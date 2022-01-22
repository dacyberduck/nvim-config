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
    vim.fn.system({"git","clone","https://github.com/wbthomason/packer.nvim","--depth","20",packer_path})
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

-- init packer with custom options
packer.init {
  compile_path = packer_compiled_path,
  display = {
    open_fn = function()
      return require("packer.util").float({border = "single"})
    end,
    prompt_border = "single",
    border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"},
  },
  git = {
    clone_timeout = 600, -- Timeout for git clones, in seconds
  },
  auto_clean = true,
  compile_on_sync = true,
  auto_reload_compiled = true,
}

-- startup packer
return packer.startup(
  function()
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    --  let packer manage itself
    use "wbthomason/packer.nvim"
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- neovim impatient
    use "lewis6991/impatient.nvim"
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
    }
    use {
      "nvim-treesitter/playground",
      after = "nvim-treesitter"
    }
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Lsp
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Completion
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Telescope and plugins
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        { "kyazdani42/nvim-web-devicons", opt = true },
      },
    }
    use "ahmedkhalf/project.nvim"
    use "nvim-telescope/telescope-file-browser.nvim"
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Git plugins
    use {
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim"
    }
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- load packer_compiled.lua
    if vim.fn.filereadable(packer_compiled_path) == 1 then
      require('packer_compiled')
    else
      packer.sync()
    end
  end
)
