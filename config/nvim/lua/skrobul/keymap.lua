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
local wk = require("which-key")

wk.register({
  name = "telescope",
  f = { '<cmd>Telescope find_files<cr>', "files (telescope)" },
  g = { '<cmd>Telescope live_grep<cr>', "Live grep (telescope)"},
  b = { '<cmd>Telescope buffers<cr>', "Buffers" },
  h = { '<cmd>Telescope help_tags<cr>', "Help tags" },
  m = { '<cmd>Telescope man_pages<cr>', "Manual pages" },
  c = { '<cmd>Telescope colorscheme<cr>', "Colorschemes" },
  k = { '<cmd>Telescope keymaps<cr>', "Keymaps" },
  d = { '<cmd>Telescope lsp_definitions<cr>', "LSP Definitions" },
  p = { '<cmd>Telescope projects<cr>', "Projects" },
}, { prefix = "<Leader>f", desc="Find ... (telescope)" })

-- telescope
wk.register({
  ["<C-p>"] = { '<cmd>Telescope find_files<cr>', "Find file" },
  ["''"] = { '<cmd>Telescope buffers<cr>' }
})


-- disable arrows
map {'', '<Up>', '<Nop>'}
map {'', '<Down>', '<Nop>'}
map {'', '<Left>', '<Nop>'}
map {'', '<Right>', '<Nop>'}

-- global

wk.register({
  ["<leader>"] = {
      V = { '<cmd>source ~/.config/nvim/init.vim<cr><cmd>filetype detect<cr>', "Reload vimrc" },
      b = {
        name = "buffer",
        n = { '<cmd>bnext<cr>', "Next buffer" },
        p = { '<cmd>bprevious<cr>', "Previous buffer" },
        c = { '<cmd>bp <BAR> bd #<cr>', "Close buffer and replace with prev" },
        d = { '<cmd>Bdelete<cr>', "Close buffer" },
        t = { '<cmd>enew<cr>', 'New buffer' }
      },
    n = { '<cmd>bnext<cr>', "Next buffer" },
    p = { '<cmd>bprevious<cr>', "Previous buffer" },
  }
})

-- utils

-- Replace all occurences of word under cursor
-- map {'n', '<Leader>rw', "<cmd>%s/\<<C-r><C-w>\>//g<Left><Left>"}

-- automatically insert a \v before any search string, so search uses normal regexes
map {'n', '/', '/\\v'}
map {'v', '/', '/\\v'}

-- Use Q for formatting the current paragraph (or selection)
map {'v', 'Q', 'gq', desc="Format selection" }
map {'n', 'Q', 'gqap', desc="Fromat current paragraph" }

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

-- git
wk.register({
  a = { "<cmd>Git add %:p<CR><CR>", "git-add current file (patch)" },
  s = { "<cmd>Git<CR>", "show" },
  c = { "<cmd>Gcommit -v -q<CR>", "Commit" },
  t = { "<cmd>Gcommit -v -q %:p<CR>", "Commit (patch)" },
  d = { "<cmd>Gdiffsplit<CR>", "git diff (file or commit)" },
  e = { "<cmd>Gedit<CR>", "edit fugitive object" },
  r = { "<cmd>Gread<CR>", "replace buffer with fugitive object" },
  w = { "<cmd>Gwrite<CR><CR>", "save and stage the file" },
  l = { "<cmd>silent! Glog<CR>:bot copen<CR>", "Open Glog in split below" },
  p = { "<cmd>Ggrep<Space>", "Git Grep" },
  m = { "<cmd>GMove<Space>", "Git move and rename buffer" },
  b = { "<cmd>Git branch<Space>", "Switch branch" },
  o = { "<cmd>Git checkout<Space>", "Checkout" },
  ["ps"] = { "<cmd>Git push<CR>", "Push" },
  ["pl"] = { "<cmd>Git pull<CR>", "Pull" },
}, { prefix = "<Leader>g", desc="Git" })

-- mergetool
wk.register({
  ["<leader>1"] = { "<cmd>diffget BASE<CR><cmd>diffupdate<CR>", "Get BASE" },
  ["<leader>2"] = { "<cmd>diffget LOCAL<CR><cmd>diffupdate<CR>", "Get LOCAL" },
  ["<leader>3"] = { "<cmd>diffget LOCAL<CR><cmd>diffupdate<CR>", "Get REMOTE" }
})
