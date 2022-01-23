local cmp = require('cmp')
local lsp_symbols = {
  Text = "   (Text) ",
  Method = "   (Method)",
  Function = "   (Function)",
  Constructor = "   (Constructor)",
  Field = " ﴲ  (Field)",
  Variable = "[] (Variable)",
  Class = "   (Class)",
  Interface = " ﰮ  (Interface)",
  Module = "   (Module)",
  Property = " 襁 (Property)",
  Unit = "   (Unit)",
  Value = "   (Value)",
  Enum = " 練 (Enum)",
  Keyword = "   (Keyword)",
  Snippet = "   (Snippet)",
  Color = "   (Color)",
  File = "   (File)",
  Reference = "   (Reference)",
  Folder = "   (Folder)",
  EnumMember = "   (EnumMember)",
  Constant = " ﲀ  (Constant)",
  Struct = " ﳤ  (Struct)",
  Event = "   (Event)",
  Operator = "   (Operator)",
  TypeParameter = "   (TypeParameter)"
}
local lspkind =
  require("lspkind").init(
  {
    with_text = true,
    preset = "codicons",
    symbol_map = lsp_symbols
  }
)

cmp.setup({
  completion = {
    completeopt = "menuone,noinsert",
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  },
  snippet = {
    expand = function(args)
      -- Vsnip
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i','c'}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i','c'}),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i','c'}),
    ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
    ['<C-e>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
    ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace,select = true}),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  formatting = {
    format = function(entry, item)
      item.kind = lsp_symbols[item.kind] .. " " .. item.kind
      item.menu = ({
        spell = "[Spell]",
        buffer = "[Buffer]",
        calc = "[Calc]",
        emoji = "[Emoji]",
        nvim_lsp = "[LSP]",
        path = "[Path]",
        look = "[Look]",
        treesitter = "[treesitter]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
        cmp_tabnine = "[Tab9]",
        orgmode = "[orgmode]",
        ultisnips = "[UltiSnips]",
        npm = ""
      })[entry.source.name]
      return item
    end
  },
  sources = {
    {name = "nvim_lsp"},
    {name = "vsnip"},
    {name = "path"},
    {name = "buffer"},
    {name = "nvim_lua"},
    {name = "treesitter"},
    {name = "spell"},
    {name = "calc"},
    {name = "emoji"},
  },
  documentation = {
    border = "rounded",
  },
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' },
    }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
