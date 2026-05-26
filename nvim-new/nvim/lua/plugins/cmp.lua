return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "micangl/cmp-vimtex",
    "saadparwaiz1/cmp_luasnip",
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({

        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),

        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- =========================================================
        -- Tab: 补全菜单 / snippet 展开 / 普通 Tab
        -- =========================================================
        ["<Tab>"] = cmp.mapping(function(fallback)

          if cmp.visible() then
            cmp.select_next_item()

          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()

          else
            fallback()
          end

        end, { "i", "s" }),

        -- =========================================================
        -- Shift-Tab: 上一个补全 / snippet 回跳
        -- =========================================================
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
        { name = "vimtex" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end
}
