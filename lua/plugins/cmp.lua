-- Autocompletion with nvim-cmp
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",         -- Buffer completions
    "hrsh7th/cmp-path",           -- Path completions
    "hrsh7th/cmp-nvim-lsp",       -- LSP completions
    "L3MON4D3/LuaSnip",           -- Snippet engine
    "saadparwaiz1/cmp_luasnip",   -- Snippet completions
    "rafamadriz/friendly-snippets", -- Snippet collection
    "onsails/lspkind.nvim",       -- VS Code-like icons
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Load friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- Previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- Next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),    -- Scroll docs up
        ["<C-f>"] = cmp.mapping.scroll_docs(4),     -- Scroll docs down
        ["<C-Space>"] = cmp.mapping.complete(),     -- Show completions
        ["<C-e>"] = cmp.mapping.abort(),            -- Close completions
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Confirm selection
        -- Tab to jump through snippet placeholders
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- LSP
        { name = "luasnip" },  -- Snippets
        { name = "buffer" },   -- Buffer words
        { name = "path" },     -- File paths
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })
  end,
}
