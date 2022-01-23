local set = vim.opt

set.bs = { indent, eol, start } -- Allow backspacing over everything in insert mode
set.ai = true                  -- Always set auto-indenting on
set.history=50          -- keep 50 lines of command history
set.ts=4                -- 4 space wide tabs
set.sw=4
set.softtabstop=4     -- makes backspacing over spaced out tabs work real nice
set.expandtab = true           -- expand tabs to spaces
set.ignorecase = true
set.background='dark'     --awesome for terminals with crappy colors (putty!)
set.tagstack = true            --lets you push and pop your jumps with ctrl+]
set.pastetoggle="<F11>"   --when you're pasting stuff this keeps it from getting
                        --all whacked out with indentation
set.showmode = true
set.smarttab = true
set.nrformats:remove('octal')
set.ttimeout = true
set.ttimeoutlen = 100
set.incsearch = true
set.spellfile = "~/dotfiles/vim/spell/en.utf-8.add"
set.modelines=5         -- check for vim settings in X lines of read file
set.complete:remove("k") -- autocompletion - disable dictionary based
set.hlsearch = true
set.ignorecase = true
set.smartcase = true
set.hidden = true -- do not save history when leaving buffer
set.foldlevelstart=1
set.formatoptions="tcrqnj"
set.diffopt="filler"
set.number = true
set.relativenumber = false

-- In many terminal emulators the mouse works just fine, thus enable it.
-- if has('mouse')
--   set.mouse=a
-- endif
-- set.cursorline
--
-- Better display for messages
set.cmdheight=2
-- You will have bad experience for diagnostic messages when it's default 4000.
set.updatetime=300
-- don't give |ins-completion-menu| messages.
set.shortmess:append("c")

-- " Always show the signcolumn, otherwise it would shift the text each time
-- " diagnostics appear/become resolved.
if (vim.fn.has("nvim-0.5.0") or vim.fn.has("patch-8.1.1564")) then
  -- Recently vim can merge signcolumn and number column into one
  set.signcolumn="number"
else
  set.signcolumn="yes"
end
--

-- Always hide the statusline
set.laststatus=1
set.ruler = true                -- Show the cursor position all the time
-- TODOset.rulerformat = '%30(%<%m%y%h%r%=%l,%c\ %P%)'
set.showcmd = true
set.wildmode = "longest,list,full"
set.wildmenu = true
set.autoread = true -- reads the file when it has been changed outside vim

-- files related
set.backup = false
set.listchars = { tab = ">~", eol = '↲', nbsp = '␣', trail = '•', extends = '⟩', precedes = '⟨' }
set.list = false
set.showbreak="↪"
set.writebackup = false
set.directory="$HOME/.cache/vim/"
set.fileformats="unix,dos,mac"
set.completeopt="menuone,longest,preview"

if vim.fn.has("nvim") then
  set.clipboard:append("unnamedplus")
else
  set.clipboard="unnamed"
end

-- move focus to correct place after the split
set.splitright = true  -- ... to the right of current pane

set.showmatch = true -- show matching parens

-- per-project vimrc
set.exrc = true
set.secure = true

set.wildignore:append("**/node_modules")
