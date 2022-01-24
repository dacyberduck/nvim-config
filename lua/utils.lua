local M = {}

-- map a key globally
function M.map_key(mode,lhs,rhs,opts)
  vim.api.nvim_set_keymap(mode,lhs,rhs,opts or {})
end

-- map key for buffer only
function M.buf_map_key(buf,mode,lhs,rhs,opts)
  vim.api.nvim_buf_set_keymap(buf or 0,mode,lhs,rhs,opts or {})
end

-- takes a list of augroups and their
-- commands and creates augroup cmds
-- see autocmd.lua for better understanding
function M.create_augroups(definitions)
  for grounp_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup ' .. grounp_name)
    vim.api.nvim_command('autocmd!')
    for _, def in pairs(definition) do
      vim.api.nvim_command('autocmd ' .. def)
    end
    vim.api.nvim_command('augroup END')
  end
end

-- shamelessly taken from cokeline
-- takes two inputs, hlgroup and attr
-- returns the hex color code
-- example: get_hex("Tabline", "fg")
-- will return the hex of Tabline foreground
function M.get_hex(hlgroup_name, attr)
  local hlgroup_ID = vim.fn.synIDtrans(vim.fn.hlID(hlgroup_name))
  local hex = vim.fn.synIDattr(hlgroup_ID, attr)
  return hex ~= '' and hex or 'NONE'
end

return M
