-- kitty-scrollback-nvim-kitten-config.lua

-- put your general Neovim configurations here
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.keymap.set({ 'n' }, '<C-e>', '5<C-e>', {})
vim.keymap.set({ 'n' }, '<C-y>', '5<C-y>', {})


-- add kitty-scrollback.nvim to the runtimepath to allow us to require the kitty-scrollback module
-- pick a runtimepath that corresponds with your package manager, if you are not sure leave them all it will not cause any issues
vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/lazy/kitty-scrollback.nvim') -- lazy.nvim
require('kitty-scrollback').setup({})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = vim.api.nvim_create_augroup('KittyScrollbackNvimFileType', { clear = true }),
  pattern = { 'kitty-scrollback' },
  callback = function()
    -- scroll to bottom
    vim.print(vim.cmd.normal("G"))
    return true
  end,
})

vim.keymap.set({ 'v' }, '<CR>', '<Plug>(KsbVisualYank)')
vim.keymap.set({ 'v' }, 'y', '<Plug>(KsbVisualYank)')
