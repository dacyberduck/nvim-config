local definitions = {
  lsp = {
    {"CursorHold,CursorHoldI", "*", "Lspsaga show_line_diagnostics"}
  },
}

for grounp_name, definition in pairs(definitions) do
  vim.api.nvim_command('augroup ' .. grounp_name)
  vim.api.nvim_command('autocmd!')
  for _, def in pairs(definition) do
    local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
    vim.api.nvim_command(command)
  end
  vim.api.nvim_command('augroup END')
end
