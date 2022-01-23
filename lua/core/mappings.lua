-- mappings
local function map(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts or {})
end

-- Normal mode
map("n","<C-s>",       '<Cmd>write<CR>', { noremap = true })
map("n","<C-l>",       '<Cmd>set hls!<CR>', { noremap = true })
map("n","H",           'g^', { noremap = true })
map("n","L",           'g$', { noremap = true })
map("n","Y",           'yg$', { noremap = true })
map("n","]b",          '<Cmd>bnext<CR>', { noremap = true })
map("n","[b",          '<Cmd>bprev<CR>', { noremap = true })
map("n","<A-q>",       '<Cmd>bd<CR>', { noremap = true })
map("n","<A-Q>",       '<Cmd>q<CR>', { noremap = true })
map("n","<A-Tab>",     '<Cmd>bnext<CR>', { noremap = true })
map("n","<A-h>",       '<C-w>h', { noremap = true })
map("n","<A-j>",       '<C-w>j', { noremap = true })
map("n","<A-k>",       '<C-w>k', { noremap = true })
map("n","<A-l>",       '<C-w>l', { noremap = true })
map("n","<A-H>",       '<Cmd>vertical resize +5<CR>', { silent = true })
map("n","<A-L>",       '<Cmd>vertical resize -5<CR>', { silent = true })
map("n","<A-J>",       '<Cmd>resize -5<CR>', { silent = true })
map("n","<A-K>",       '<Cmd>resize +5<CR>', { silent = true })
map("n","<A-t>",       '<Cmd>split | resize 10 | term<CR>i', {noremap = true})

-- Insert mode
map("i","<C-s>",       '<Esc><Cmd>write<CR>', { noremap = true })
map("i","<C-h>",       '<C-w>', { noremap = true })
map("i","<C-BS>",      '<C-w>', { noremap = true })

-- Visual mode
map("v","H",           'g^', { noremap = true })
map("v","L",           'g$', { noremap = true })
map("v",".",           '<Cmd>normal.<CR>', { silent = true })
map("v","<",           '<gv', { noremap = true })
map("v",">",           '>gv', { noremap = true })

-- Command mode
map("c","<C-b>",       '<Left>', { noremap = true })
map("c","<C-f>",       '<Right>', { noremap = true })
map("c","<C-h>",       '<C-w>', { noremap = true })
map("c","<C-BS>",      '<C-w>', { noremap = true })

-- Terminal mode
map("t","<A-q>",       '<C-\\><C-n> <Cmd>bd!<CR>', {noremap = true})
map("t","<A-h>",       '<C-\\><C-n> <C-w>h', { noremap = true })
map("t","<A-j>",       '<C-\\><C-n> <C-w>j', { noremap = true })
map("t","<A-k>",       '<C-\\><C-n> <C-w>k', { noremap = true })
map("t","<A-l>",       '<C-\\><C-n> <C-w>l', { noremap = true })
map("t","<A-K>",       '<Cmd>resize +5<CR>', { silent = true })
map("t","<A-J>",       '<Cmd>resize -5<CR>', { silent = true })
