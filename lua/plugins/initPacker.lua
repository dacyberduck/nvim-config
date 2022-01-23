local packer_compiled_path = vim.fn.stdpath("config").."/lua/packer_compiled.lua"
local packer = require('packer')

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
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use {"nvim-treesitter/playground", after = "nvim-treesitter"}
    use {"p00f/nvim-ts-rainbow", after = "nvim-treesitter"}
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Lsp
    use "neovim/nvim-lspconfig"
    use "jose-elias-alvarez/null-ls.nvim"
    use "nvim-lua/lsp_extensions.nvim"
    use "tami5/lspsaga.nvim"
    use "onsails/lspkind-nvim"
    use "ray-x/lsp_signature.nvim"
    use "kosayoda/nvim-lightbulb"
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Snippets
    use("hrsh7th/vim-vsnip")
    use("hrsh7th/vim-vsnip-integ")
    use("rafamadriz/friendly-snippets")
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Completion
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use {"hrsh7th/cmp-path", after = "nvim-cmp"}
    use {"hrsh7th/cmp-buffer", after = "nvim-cmp"}
    use {"hrsh7th/cmp-nvim-lua", after = "nvim-cmp"}
    use {"hrsh7th/cmp-cmdline", after = "nvim-cmp"}
    use {"ray-x/cmp-treesitter", after = "nvim-cmp"}
    use {"hrsh7th/cmp-vsnip", after = "nvim-cmp"}
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
    -- Colorschemes
    use "rebelot/kanagawa.nvim"
    use "luisiacc/gruvbox-baby"
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Statusline and Tab/Bufferline
    use "feline-nvim/feline.nvim"
    use "noib3/nvim-cokeline"
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Misc plugins
    use {"lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim"}
    use "norcalli/nvim-colorizer.lua"
    use "lukas-reineke/indent-blankline.nvim"
    use "terrortylor/nvim-comment"
    use "ellisonleao/glow.nvim"
    use "folke/which-key.nvim"
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  end
)
