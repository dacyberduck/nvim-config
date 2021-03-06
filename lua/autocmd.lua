local definitions = {
  bufs = {
    "BufWritePre /tmp/* setlocal noundofile",
    "BufWritePre COMMIT_EDITMSG setlocal noundofile",
    "BufWritePre MERGE_MSG setlocal noundofile",
    "BufWritePre *.tmp setlocal noundofile",
    "BufWritePre *.bak setlocal noundofile",
    "BufWritePre *.tsx lua vim.api.nvim_command('Format')",
    "BufWritePre *.go lua require('internal.golines').golines_format()",
  };

  wins = {
    -- Highlight current line only on focused window
    "WinEnter,BufEnter,InsertLeave * if ! &cursorline && &filetype !~# '^(dashboard|clap_)' && ! &pvw | setlocal cursorline | endif",
    "WinLeave,BufLeave,InsertEnter * if &cursorline && &filetype !~# '^(dashboard|clap_)' && ! &pvw | setlocal nocursorline | endif",
    -- Equalize window dimensions when resizing vim window
    "VimResized * tabdo wincmd =",
    -- Check if file changed when its window is focus, more eager than 'autoread'
    "FocusGained * checktime",
  };

  ft = {
    "BufNewFile,BufRead *.toml  setf toml",
    "FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>",
  };

  yank = {
    "TextYankPost * silent! lua vim.highlight.on_yank({higroup='IncSearch', timeout=400})",
  };

  term = {
    "WinEnter,BufEnter,TermEnter term://* startinsert",
    "WinLeave,BufLeave,TermLeave term://* stopinsert",
  };
}

require('utils').create_augroups(definitions)
