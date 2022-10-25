local cmp = require'cmp'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
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
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp', max_item_count = 15 },
    { name = 'luasnip', keyword_length = 2 },
  }, {
      { name = 'path' },
      { name = 'buffer',
        keyword_length = 3,
        option = {
          -- -- complete from all visible buffers
          -- get_bufnrs = function()
          --   local bufs = {}
          --   for _, win in ipairs(vim.api.nvim_list_wins()) do
          --     bufs[vim.api.nvim_win_get_buf(win)] = true
          --   end
          --   return vim.tbl_keys(bufs)
          -- end
          -- complete from all buffers
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end
        }
      },
      { name = 'tmux', option = { all_panes = false }, keyword_length = 8, max_item_count = 5 },
    }),
  experimental = {
    ghost_text = true,
    native_menu = false
  }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--         sources = cmp.config.sources({
--                 { name = 'path' }
--             }, {
--                 { name = 'cmdline', max_item_count = 20 }
--             })
--     })
