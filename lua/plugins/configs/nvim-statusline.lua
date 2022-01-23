local lsp = require("feline.providers.lsp")
local vi_mode_utils = require("feline.providers.vi_mode")

local force_inactive = {
  filetypes = {},
  buftypes = {},
  bufnames = {}
}

local components = {
  active = { {}, {}, {}},
  inactive = { {}, {}, {}},
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
  TERM = "TERM",
  NONE = "NONE"
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
    return true
  end
  return false
end

force_inactive.filetypes = {
  "NvimTree",
  "dbui",
  "packer",
  "startify",
  "fugitive",
  "fugitiveblame",
  "CHADTree"
}

force_inactive.buftypes = {
  "terminal",
}

-- LEFT COMPONENTS
-- vi-mode
components.active[1][1] = {
  provider = function()
    return " " .. vi_mode_text[vi_mode_utils.get_vim_mode()] .. " "
  end,
  hl = function()
    local val = {}

    val.bg = vi_mode_utils.get_mode_color()
    val.fg = "black"
    val.style = "bold"

    return val
  end,
  right_sep = " "
}
-- filename
components.active[1][2] = {
  provider = function()
    return vim.fn.expand("%:F")
  end,
  hl = {
    fg = "white",
    bg = "bg",
    style = "bold"
  },
  right_sep = {
    str = " ",
    hl = {
      fg = "white",
      bg = "bg",
      style = "bold"
    }
  }
}

-- gitBranch
components.active[1][3] = {
  provider = "git_branch",
  hl = {
    fg = "yellow",
    bg = "bg",
    style = "bold",
  }
}
-- diffAdd
components.active[1][4] = {
  provider = "git_diff_added",
  hl = {
    fg = "green",
    bg = "bg",
    style = "bold"
  }
}
-- diffModfified
components.active[1][5] = {
  provider = "git_diff_changed",
  hl = {
    fg = "orange",
    bg = "bg",
    style = "bold"
  }
}
-- diffRemove
components.active[1][6] = {
  provider = "git_diff_removed",
  hl = {
    fg = "red",
    bg = "bg",
    style = "bold"
  }
}

-- MIDDLE COMPONENTS
-- diagnosticErrors
components.active[2][5] = {
  provider = "diagnostic_errors",
  enabled = function()
    return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
  end,
  hl = {
    fg = "red",
    style = "bold"
  }
}
-- diagnosticWarn
components.active[2][6] = {
  provider = "diagnostic_warnings",
  enabled = function()
    return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
  end,
  hl = {
    fg = "yellow",
    style = "bold"
  }
}
-- diagnosticHint
components.active[2][7] = {
  provider = "diagnostic_hints",
  enabled = function()
    return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
  end,
  hl = {
    fg = "cyan",
    style = "bold"
  }
}
-- diagnosticInfo
components.active[2][8] = {
  provider = "diagnostic_info",
  enabled = function()
    return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
  end,
  hl = {
    fg = "skyblue",
    style = "bold"
  }
}

-- RIGHT COMPONENT
-- LspName
components.active[3][1] = {
  provider = "lsp_client_names",
  hl = {
    fg = "yellow",
    bg = "bg",
    style = "bold"
  },
  right_sep = " "
}
-- fileType
components.active[3][2] = {
  provider = "file_type",
  hl = function()
    local val = {}
    local filename = vim.fn.expand("%:t")
    local extension = vim.fn.expand("%:e")
    val.fg = "white"
    val.bg = "bg"
    val.style = "bold"
    return val
  end,
  right_sep = " "
}
-- lineInfo
components.active[3][3] = {
  provider = "position",
  hl = {
    fg = "white",
    bg = "bg",
    style = "bold"
  },
  right_sep = " "
}

-- INACTIVE

-- fileType
components.inactive[1][1] = {
  provider = "file_type",
  hl = {
    fg = "black",
    bg = "cyan",
    style = "bold"
  },
  left_sep = {
    str = " ",
    hl = {
      fg = "NONE",
      bg = "cyan"
    }
  },
  right_sep = {
    {
      str = " ",
      hl = {
        fg = "NONE",
        bg = "cyan"
      }
    },
    " "
  }
}


require('feline').setup({
  theme = colors,
  default_bg = colors.bg,
  default_fg = colors.fg,
  vi_mode_colors = vi_mode_colors,
  components = components,
  force_inactive = force_inactive,
})
