local lsp = require("feline.providers.lsp")
local vi_mode_utils = require("feline.providers.vi_mode")
local cursor_utils = require('feline.providers.cursor')

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

local colors = {
  bg = "#282828",
  black = "#282828",
  yellow = "#d8a657",
  cyan = "#89b482",
  oceanblue = "#45707a",
  green = "#a9b665",
  orange = "#e78a4e",
  violet = "#d3869b",
  magenta = "#c14a4a",
  white = "#a89984",
  fg = "#a89984",
  skyblue = "#7daea3",
  red = "#ea6962"
}

local vi_mode_colors = {
  NORMAL = "green",
  OP = "green",
  INSERT = "red",
  VISUAL = "skyblue",
  LINES = "skyblue",
  BLOCK = "skyblue",
  REPLACE = "violet",
  ["V-REPLACE"] = "violet",
  ENTER = "cyan",
  MORE = "cyan",
  SELECT = "orange",
  COMMAND = "green",
  SHELL = "green",
  TERM = "green",
  NONE = "yellow"
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
          val.fg = "black"
          val.bg = vi_mode_utils.get_mode_color()
          val.style = "bold"
          return val
        end,
      },
      { -- Filename
        provider = function()
          return require('feline.providers.file').file_info(vim.fn.expand("%:F"), {}) .. " "
        end,
        hl = {
          fg = "black",
          bg = "skyblue",
          style = "bold",
        },
      },
      { -- Git branch
        provider = "git_branch",
        hl = {
          fg = "orange",
          bg = "black",
          style = "bold"
        },
        left_sep = {
          str = " ",
          hl = {
            bg = "black"
          }
        }
      },
      { -- Git DiffAdd
        provider = "git_diff_added",
        hl = {
          fg = "green",
          bg = "black",
          style = "bold"
        }
      },
      { -- Git DiffModified
        provider = "git_diff_changed",
        hl = {
          fg = "yellow",
          bg = "black",
          style = "bold"
        }
      },
      { -- Git DiffRemove
        provider = "git_diff_removed",
        hl = {
          fg = "red",
          bg = "black",
          style = "bold"
        }
      },
      {
        provider = "lsp_client_names",
        hl = {
          fg = "cyan",
          bg = "black",
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
          fg = "skyblue",
          bg = "black",
          style = "bold",
        },
        left_sep = {
          sep = " ",
          hl = {
            bg = "black",
          }
        },
        right_sep = {
          sep = " ",
          hl = {
            bg = "black",
          }
        }
      },
      { -- Diagnostic Warn
        provider = "diagnostic_warnings",
        enabled = function()
          return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
        end,
        hl = {
          fg = "yellow",
          style = "bold",
        },
      },
      { -- Diagnostic Hint
        provider = "diagnostic_hints",
        enabled = function()
          return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
        end,
        hl = {
          fg = "cyan",
          style = "bold",
        },
      },
      { -- Diagnostic Errors
        provider = "diagnostic_errors",
        enabled = function()
          return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
        end,
        hl = {
          fg = "red",
          style = "bold",
        },
      },
      {
        provider = " ",
        hl = { bg = "black" }
      },
      { -- File type
        provider = "file_type",
        hl = {
          fg = "black",
          bg = "skyblue",
          style = "bold"
        },
        left_sep = {
          str = " ",
          hl = {
            bg = "skyblue"
          }
        },
        right_sep = {
          str = " ",
          hl = {
            bg = "skyblue"
          }
        }
      },
      { -- Cursor position
        provider = "position",
        hl = {
          fg = "black",
          bg = "cyan",
          style = "bold",
        },
        left_sep = {
          str = " ",
          hl = {
            bg = "cyan"
          }
        },
        right_sep = {
          str = " ",
          hl = {
            bg = "cyan"
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
          fg = "black",
          bg = "cyan",
          style = "bold",
        },
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
