local get_hex = require("cokeline.utils").get_hex
require('cokeline').setup({
  show_if_buffers_are_at_least = 2,
  mappings = {
    cycle_prev_next = true,
  },
  default_hl = {
    focused = {
      fg = get_hex('TablineSel', 'fg'),
      bg = get_hex('TablineSel', 'bg')
    },
    unfocused = {
      fg = get_hex('Tabline', 'fg'),
      bg = get_hex('Tabline', 'bg'),
    },
  },

  components = {
    {
      text = function(buffer) return (buffer.index ~= 1) and '▏' or '' end,
      hl = {
        fg = get_hex('Normal', 'fg')
      },
    },
    {
      text = function(buffer) return '    ' .. buffer.filename .. '    ' end,
      hl = {
        style = function(buffer) return buffer.is_focused and 'bold' or nil end,
      }
    },
    {
      text = '',
      delete_buffer_on_left_click = true,
    },
    {
      text = '  ',
    },
  },
})
