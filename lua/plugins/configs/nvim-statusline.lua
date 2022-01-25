local lsp = require("feline.providers.lsp")
local vi_mode_utils = require("feline.providers.vi_mode")
local cursor_utils = require('feline.providers.cursor')
local get_hex = require('utils').get_hex

local force_inactive = {
  filetypes = {
    "NvimTree",
    "dbui",
    "packer",
    "startify",
    "fugitive",
    "fugitiveblame",
    "CHADTree"
  },
  buftypes = {},
  bufnames = {}
}

-- colors are adjusted to match 'kanagawa' colorscheme
local colors = {
  bg = get_hex("StatusLine","bg"),      -- dark bg
  bg2 = get_hex("Normal","bg"),         -- bg
  fg = get_hex("StatusLine","fg"),      -- dark fg
  fg2 = get_hex("Normal","fg"),         -- fg
  red = get_hex("diffRemoved","fg"),    -- dark red
  red2 = get_hex("Exception","fg"),     -- red
  green = get_hex("diffAdded","fg"),    -- dark green
  green2 = get_hex("String","fg"),      -- green
  yellow = get_hex("Operator","fg"),    -- dark yellow
  yellow2 = get_hex("Identifier","fg"), -- yellow
  blue = get_hex("Todo","bg"),          -- dark blue
  blue2 = get_hex("Directory","fg"),    -- blue
  purple = get_hex("Conceal","fg"),     -- dark violet
  purple2 = get_hex("Statement","fg"),  -- violet
  cyan = get_hex("DiagnosticHint","fg"),-- dark cyan
  cyan2 = get_hex("Type","fg"),         -- cyan
  orange = get_hex("Constant","fg"),    -- orange
  pink = get_hex("Number","fg"),        -- pink
  gray = get_hex("FoldColumn","fg"),    -- gray
  added = get_hex("DiffAdd","bg"),
  removed = get_hex("DiffDelete","bg"),
  changed = get_hex("DiffChange","bg"),
  error = get_hex("DiagnosticError","fg"),
  warn = get_hex("DiagnosticWarn","fg"),
  info = get_hex("DiagnosticInfo","fg"),
  hint = get_hex("DiagnosticHint","fg"),
}

local vi_mode_colors = {
  NORMAL = "green2",
  OP = "green",
  INSERT = "red2",
  VISUAL = "blue2",
  LINES = "blue",
  BLOCK = "blue2",
  REPLACE = "purple2",
  ["V-REPLACE"] = "purple",
  ENTER = "cyan2",
  MORE = "cyan",
  SELECT = "pink",
  COMMAND = "orange2",
  SHELL = "yellow",
  TERM = "yellow2",
  NONE = "gray"
}

local vi_mode_text = {
  NORMAL = "NORMAL",
  OP = "OP",
  INSERT = "INSERT",
  VISUAL = "VISUAL",
  LINES = "LINES",
  BLOCK = "BLOCK",
  REPLACE = "REPLACE",
  ["V-REPLACE"] = "V-REPLACE",
  ENTER = "ENTER",
  MORE = "MORE",
  SELECT = "SELECT",
  COMMAND = "COMMAND",
  SHELL = "SHELL",
  TERM = "TERMINAL",
  NONE = "NONE"
}

-- LEFT
-- vi-mode
local components = {
  active = {
    { -- ACTIVE LEFT COMPONENTS
      { -- VIM MODE indicator
        provider = function()
          return " " .. vi_mode_text[vi_mode_utils.get_vim_mode()] .. " "
        end,
        hl = function()
          local val = {}
          val.fg = "bg"
          val.bg = vi_mode_utils.get_mode_color()
          val.style = "bold"
          return val
        end,
      },
      { -- Filename
        provider = function()
          -- get file name using inbuilt provider
          -- takes two args. passing empty args to avoid devicons
          return require('feline.providers.file').file_info({icon = " ", }, {}) .. " "
        end,
        hl = {
          fg = "bg",
          bg = "cyan2",
          style = "bold",
        },
      },
      { -- Git branch
        provider = "git_branch",
        hl = {
          fg = "orange2",
          bg = "bg",
          style = "bold"
        },
        left_sep = {
          str = " ",
          hl = {
            bg = "bg"
          }
        }
      },
      { -- Git DiffAdd
        provider = "git_diff_added",
        hl = {
          fg = "added",
          bg = "bg",
          style = "bold"
        }
      },
      { -- Git DiffModified
        provider = "git_diff_changed",
        hl = {
          fg = "changed",
          bg = "bg",
          style = "bold"
        }
      },
      { -- Git DiffRemove
        provider = "git_diff_removed",
        hl = {
          fg = "removed",
          bg = "bg",
          style = "bold"
        }
      },
      {
        provider = "lsp_client_names",
        hl = {
          fg = "cyan2",
          bg = "bg",
          style = "bold",
        },
        left_sep = " "
      },
      {} -- empty end component
    },
    { -- ACTIVE RIGHT COMPONENTS
      { -- Diagnostic Info
        provider = "diagnostic_info",
        enabled = function()
          lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
        end,
        hl = {
          fg = "info",
          bg = "bg",
          style = "bold",
        },
        left_sep = {
          sep = " ",
          hl = {
            bg = "bg",
          }
        },
        right_sep = {
          sep = " ",
          hl = {
            bg = "bg",
          }
        }
      },
      { -- Diagnostic Warn
        provider = "diagnostic_warnings",
        enabled = function()
          return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
        end,
        hl = {
          fg = "warn",
          style = "bold",
        },
      },
      { -- Diagnostic Hint
        provider = "diagnostic_hints",
        enabled = function()
          return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
        end,
        hl = {
          fg = "hint",
          style = "bold",
        },
      },
      { -- Diagnostic Errors
        provider = "diagnostic_errors",
        enabled = function()
          return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
        end,
        hl = {
          fg = "error",
          style = "bold",
        },
      },
      {
        provider = " ",
        hl = { bg = "bg" }
      },
      { -- File type
        provider = "file_type",
        hl = {
          fg = "bg",
          bg = "cyan2",
          style = "bold"
        },
        left_sep = {
          str = " ",
          hl = {
            bg = "cyan2"
          }
        },
        right_sep = {
          str = " ",
          hl = {
            bg = "cyan2"
          }
        }
      },
      { -- Cursor position
        provider = "position",
        hl = {
          fg = "bg",
          bg = "green2",
          style = "bold",
        },
        left_sep = {
          str = " ",
          hl = {
            bg = "green2"
          }
        },
        right_sep = {
          str = " ",
          hl = {
            bg = "green2"
          }
        }
      },
      {} -- empty end component
    },
  },
  inactive = {
    { -- INACTIVE LEFT COMPONENTS
      {
        provider = "file_type",
        hl = {
          fg = "bg",
          bg = "cyan2",
          style = "bold",
        },
        left_sep = {
          str = " ",
          hl = { bg = "cyan2" },
        },
        right_sep = {
          str = " ",
          hl = { bg = "cyan2" },
        }
      },
      {} -- empty end component
    },
  },
}

require("feline").setup({
  theme = colors,
  default_bg = colors.bg,
  default_fg = colors.fg,
  vi_mode_colors = vi_mode_colors,
  components = components,
  force_inactive = force_inactive
})
