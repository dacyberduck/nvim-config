local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>Lspsaga lsp_finder<CR>', opts)
  buf_set_keymap("n", "K",  "<cmd>Lspsaga hover_doc<cr>", opts)
  buf_set_keymap("n", "gr", "<cmd>Lspsaga rename<cr>", opts)
  buf_set_keymap("n", "gx", "<cmd>Lspsaga code_action<cr>", opts)
  buf_set_keymap("x", "gx", ":<c-u>Lspsaga range_code_action<cr>", opts)
  buf_set_keymap("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
  buf_set_keymap("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
  buf_set_keymap("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
  buf_set_keymap('n', 'gq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwp', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>lbf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]],
      false
    )
  end

  protocol.CompletionItemKind = {
    "", -- Text
    "", -- Method
    "", -- Function
    "", -- Constructor
    "", -- Field
    "", -- Variable
    "", -- Class
    "ﰮ", -- Interface
    "", -- Module
    "", -- Property
    "", -- Unit
    "", -- Value
    "", -- Enum
    "", -- Keyword
    "﬌", -- Snippet
    "", -- Color
    "", -- File
    "", -- Reference
    "", -- Folder
    "", -- EnumMember
    "", -- Constant
    "", -- Struct
    "", -- Event
    "ﬦ", -- Operator
    "" -- TypeParameter
  }
end

local function update_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.documentationFormat = {"markdown", "plaintext"}
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.preselectSupport = true
  capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
  capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
  capabilities.textDocument.completion.completionItem.deprecatedSupport = true
  capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
  capabilities.textDocument.completion.completionItem.tagSupport = {valueSet = {1}}
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
      "kind"
    }
  }

  return capabilities
end

vim.diagnostic.config {
  severity_sort = true,
  signs = true,
  underline = false, -- Do not underline code
  update_in_insert = true,
  virtual_text = false
  -- virtual_text = {
  -- 	prefix = "",
  -- 	spacing = 0,
  -- },
}

-- Diagnostic symbols
vim.fn.sign_define("DiagnosticSignError", {text = "", numhl = "DiagnosticSignError", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignInfo", {text = "", numhl = "DiagnosticSignInfo", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint", {text = "", numhl = "DiagnosticSignHint", texthl = "DiagnosticSignHint"})
vim.fn.sign_define("DiagnosticSignWarn", {text = "", numhl = "DiagnosticSignWarn", texthl = "DiagnosticSignWarn"})

local max_width = math.max(math.floor(vim.o.columns * 0.7), 100)
local max_height = math.max(math.floor(vim.o.lines * 0.3), 30)
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = {
      prefix = "",
      spacing = 0
    },
    signs = true,
    underline = true,
    update_in_insert = false -- update diagnostics insert mode
  }
)
vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    -- border = "rounded",
    max_width = max_width,
    max_height = max_height
  }
)
vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    -- border = "rounded",
    max_width = max_width,
    max_height = max_height
  }
)
vim.lsp.handlers["textDocument/codeLens"] =
  vim.lsp.with(
  vim.lsp.handlers.code_lens,
  {
    -- border = "rounded",
    max_width = max_width,
    max_height = max_height
  }
)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local nvim_lsp = require('lspconfig')
local servers = { 'clangd', 'pyright', 'rls', 'tsserver' }
for _, server in ipairs(servers) do
  -- load a config file if present
  -- server config files must reside in plugins/configs/nvim-lspconfig/ directory
  -- derver config file name must be like 'lsp-<server-name>.lua' (Ex: lsp-clangd.lua)
  local present, server_conf = pcall(require,('plugins.configs.nvim-lspconfig.lsp-'..server))
  if not present then server_conf = {} end
  server_conf.on_attach = on_attach
  server_conf.capabilities = update_capabilities()
  server_conf.flags = { debounce_text_changes = 150, }
  nvim_lsp[server].setup(server_conf)
end

require('lspsaga').setup{
  finder_action_keys = {
    quit = { 'q', '<Esc>' },
  },
  code_action_keys = {
    quit = { 'q', '<Esc>' },
  },
  rename_action_keys = {
    quit = { '<Esc>', '<C-c>' },
  },
  rename_prompt_prefix = ">"
}
require('lsp_signature').setup {
  fix_pos = true,
  hint_prefix = " ",
  max_height = 22,
  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  handler_opts = {
    border = "single" -- double, single, shadow, none
  },
}
