-- disable netrw at the very start of your init.lua (strongly advised)
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  disable_netrw = false,
  hijack_netrw = true,
  renderer = {
    group_empty = true,
    icons = {
      git_placement = "after"
    }
  },
  filters = {
    dotfiles = true,
  },
})
