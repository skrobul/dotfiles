local map = function(key)
  -- get the extra options
  local opts = {noremap = true}
  for i, v in pairs(key) do
    if type(i) == 'string' then opts[i] = v end
  end

  -- basic support for buffer-scoped keybindings
  local buffer = opts.buffer
  opts.buffer = nil

  if buffer then
    vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
  else
    vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
  end
end

-- telescope
map {'n', '<Leader>ff',  '<cmd>Telescope find_files<cr>'}
map {'n', '<Leader>fg',  '<cmd>Telescope live_grep<cr>'}
map {'n', '<Leader>fb',  '<cmd>Telescope buffers<cr>'}
map {'n', '<Leader>fh',  '<cmd>Telescope help_tags<cr>'}
map {'n', '<Leader>fm',  '<cmd>Telescope man_pages<cr>'}
map {'n', '<Leader>fc',  '<cmd>Telescope colorscheme<cr>'}
map {'n', '<Leader>fk',  '<cmd>Telescope keymaps<cr>'}
map {'n', '<Leader>fd',  '<cmd>Telescope lsp_definitions<cr>'}
map {'n', '<C-p>', '<cmd>Telescope find_files<cr>'}
map {'n', "''",    '<cmd>Telescope buffers<cr>'}

-- global
map {'n',
     '<leader>V',
     '<cmd>source ~/.config/nvim/init.vim<cr><cmd>filetype detect<cr>'}

-- disable arrows
map {'', '<Up>', '<Nop>'}
map {'', '<Down>', '<Nop>'}
map {'', '<Left>', '<Nop>'}
map {'', '<Right>', '<Nop>'}

-- clear search highlight
map {'', '<cr>', '<cmd>noh<cr><cr>'}

-- buffer navigation
map {'n', '<leader>bt', '<cmd>enew<cr>'}
map {'n', '<leader>n',  '<cmd>bnext<cr>'}
map {'n', '<leader>p',  '<cmd>bprevious<cr>'}
-- close the buffer and replace with previous
map {'n', '<leader>bc', '<cmd>bp <BAR> bd #<cr>'}
-- close the buffer
map {'n', '<leader>bd', '<cmd>bd<cr>'}



-- utils

-- Replace all occurences of word under cursor
-- map {'n', '<Leader>rw', "<cmd>%s/\<<C-r><C-w>\>//g<Left><Left>"}

-- automatically insert a \v before any search string, so search uses normal very veryv eyve very
-- regexes
map {'n', '/', '/\\v'}
map {'v', '/', '/\\v'}

-- Use Q for formatting the current paragraph (or selection)
map {'v', 'Q', 'gq' }
map {'n', 'Q', 'gqap' }

-- space bar folding
-- map {'n', '<space>', ":exe 'silent! normal! za'.(foldlevel('.')?'':'l')<cr>" }

-- neovim terminal
map {'t', '<C-h>', '<C-\\><C-n><C-w>h'}
map {'t', '<C-j>', '<C-\\><C-n><C-w>j'}
map {'t', '<C-k>', '<C-\\><C-n><C-w>k'}
map {'t', '<C-l>', '<C-\\><C-n><C-w>l'}
map {'n', '<A-h>', '<C-w>h'}
map {'n', '<A-j>', '<C-w>j'}
map {'n', '<A-k>', '<C-w>k'}
map {'n', '<A-l>', '<C-w>l'}


-- indent / deindent after selecting the text with (⇧ v), (.) to repeat.
map {'v', '<Tab>', '>'}
map {'v', '<S-Tab>', '<'}
