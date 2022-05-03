local ls = require("luasnip")

-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").load({ paths = { "/home/skrobul/dotfiles/config/nvim/lua/skrobul/snippets/" } })

local date = function() return {os.date('%Y-%m-%d')} end

-- Visual mode trigger selection
ls.config.set_config({
  store_selection_keys = '<c-s>',
})
