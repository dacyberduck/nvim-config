local cache_dir = vim.fn.stdpath('cache')
local opt = vim.opt

-- https://github.com/neovim/neovim/blob/master/src/nvim/options.lua
opt.termguicolors   = true
opt.autochdir       = true
opt.backspace:append("indent,eol,start")
opt.backup          = true
opt.backupdir       = cache_dir .. "/backup"
opt.backupskip:append("/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim")
opt.belloff         = 'all'
opt.clipboard:append('unnamed,unnamedplus')
opt.compatible      = false
opt.completeopt     = 'menuone,noselect'
opt.confirm         = true
opt.directory       = cache_dir .. "/swap"
opt.encoding        = 'utf-8'
opt.errorbells      = false
opt.hidden          = true
opt.history         = 1000
opt.hlsearch        = true
opt.ignorecase      = true
opt.incsearch       = true
opt.laststatus      = 2
opt.lazyredraw      = true
opt.magic           = true
opt.mouse:append('niv')
opt.path:append("**10")
opt.ruler           = true
opt.shell           = '/bin/bash'
opt.shiftround      = true
opt.shortmess:append("Aac")
opt.showbreak       = "﬌ "
opt.showmatch       = true
opt.showmode        = false
opt.smartcase       = true
opt.smarttab        = true
opt.splitbelow      = true
opt.splitright      = true
opt.tabpagemax      = 20
opt.title           = true
opt.ttyfast         = true
opt.undodir         = cache_dir .. "/undo"
opt.visualbell      = false
opt.wildignore:append(".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**")
opt.wildignorecase  = true
opt.wildmenu        = true
opt.wrap            = true
opt.writebackup     = true
opt.autoindent      = true
opt.autoread        = true
opt.complete        = '.,w,b,k'
opt.dictionary      = 'spell'
opt.expandtab       = true
opt.modeline        = true
opt.shiftwidth      = 2
opt.smartindent     = true
opt.softtabstop     = -1
opt.spelllang       = 'en'
opt.swapfile        = true
opt.syntax          = 'on'
opt.tabstop         = 2
opt.undofile        = true
opt.undolevels      = 1000
opt.breakindent     = true
opt.breakindentopt  = "shift:2,min:20"
opt.conceallevel    = 2
opt.cursorline      = true
opt.foldenable      = true
opt.foldlevel       = 1
opt.foldmethod      = 'indent'
opt.foldminlines    = 100
opt.foldnestmax     = 10
opt.linebreak       = true
opt.list            = true
opt.listchars:append('tab:→ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨')
opt.number          = true
opt.relativenumber  = true
opt.scrolloff       = 5
opt.sidescrolloff   = 5
opt.spell           = false

require('core.mappings')
require('core.autocmds')
