set nocompatible              " be iMproved, required filetype off                  " required


" VUNDLE  - plugins
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()"


Plugin 'gmarik/Vundle.vim'  "vundle itself
Plugin 'tpope/vim-fugitive' "git wrapper

"full path fuzzy finder
Plugin 'kien/ctrlp.vim'
Plugin 'JazzCore/ctrlp-cmatcher'
" remember to compile cmatcher binary
" https://github.com/JazzCore/ctrlp-cmatcher#installation

Plugin 'SirVer/ultisnips'
Plugin 'tomtom/tcomment_vim'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'

Plugin 'flazz/vim-colorschemes'
Plugin 'jwhitley/vim-matchit'
Plugin 'endwise.vim'
Plugin 'kchmck/vim-coffee-script'

Plugin 'godlygeek/tabular' "dependency for vim-markdown
Plugin 'plasticboy/vim-markdown' "markdown syntax

Plugin 'tpope/vim-rails' "set of rails helpers

" instant markdown preview requires few python modules
" pip install bottle markdown pygments
Plugin 'tpope/vim-repeat'
Plugin 'isnowfy/python-vim-instant-markdown'
Plugin 'honza/vim-snippets'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-surround'

Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'skrobul/vim-project'
" Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rstacruz/sparkup'
" Plugin 'mattly/iterm-colors-pencil'
" Plugin 'reedes/vim-colors-pencil'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-dispatch'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-bundler'
Plugin 'rizzatti/dash.vim'
Plugin 'slim-template/vim-slim.git'
Plugin 'MaxSt/FlatColor'
Plugin 'cseelus/vim-colors-clearance'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" VUNDLE end

if has('autocmd')
    filetype plugin indent on
    "don't expand tabs if we're in a makefile
    autocmd BufRead,BufNewFile Makefile set ts=4 sw=4 noexpandtab
    "wrap lines in TeX
    autocmd BufRead,BufNewFile *.tex set tw=80
    "wrap lines in .txt files
    autocmd BufNewFile,BufRead *.txt set tw=78
    autocmd BufNewFile,BufRead *.md set tw=78
    " salt states are just yaml files
    autocmd BufNewFile,BufRead *.sls set ft=yaml sw=2 ts=2

    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    "autocmd VimEnter * wincmd p
    " ruby completion
    autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
    " autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
    " autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
    " autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
    autocmd FileType ruby,eruby set sw=2 ts=2 tw=80
    autocmd FileType coffee set sw=2 ts=2 tw=80
    " remove trailing whitespaces
    autocmd FileType cucumber,c,cpp,java,php,ruby,md autocmd BufWritePre <buffer> :%s/\s\+$//e
    " automatically open quickfix window for cofee script
    autocmd QuickFixCmdPost * nested cwindow | redraw!
    " recompile file on write
    " autocmd BufWritePost *.coffee silent make!
endif

" syntax highlighting
syntax enable

colorscheme grb256
set bg=dark
let g:rehash256 = 1
set t_Co=256

set nocompatible        " Use Vim defaults (much better!)
set bs=2                " Allow backspacing over everything in insert mode
set ai                  " Always set auto-indenting on
"set backup             " Keep a backup file
"set viminfo='20,\"50    " read/write a .viminfo file -- limit to only 50
set history=50          " keep 50 lines of command history
set ts=4                " 4 space wide tabs
set sw=4
set softtabstop=4     "makes backspacing over spaced out tabs work real nice
set expandtab           "expand tabs to spaces
set ignorecase
"set background=dark     "awesome for terminals with crappy colors (putty!)
set tagstack            "lets you push and pop your jumps with ctrl+]
set pastetoggle=<F11>   "when you're pasting stuff this keeps it from getting
                        "all whacked out with indentation
set showmatch
set showmode
set smarttab
set nrformats-=octal
set ttimeout
set ttimeoutlen=50
set incsearch

" Use <C-L> to clear the highlighting of :set hlsearch.
nnoremap <silent> <Leader>q :nohlsearch<CR><C-L>


" Added to default to high security within Gentoo. Fixes bug #14088
set modelines=0
" autocompletion - disable dictionary based
set complete-=k


set number
set relativenumber
set hlsearch
set ignorecase
set smartcase

set hidden " do not save history when leaving buffer

" Don't use Ex mode, use Q for formatting
map Q gq


" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif


"collapsing window splits
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_


" explorer
let g:explVertical=1	" Split vertically
let g:explSplitRight=1    " Put new window to the right of the explorer

"space bar folding
nnoremap  <silent>  <space> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<cr>


"switching between tabs

:nmap Z :tabprev<CR>
:nmap X :tabnext<CR>


" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2
set ruler               " Show the cursor position all the time
set rulerformat=%30(%<%m%y%h%r%=%l,%c\ %P%)
set showcmd
set wildmode=longest,list,full
set wildmenu

set autoread " reads the file when it has been changed outside vim
set encoding=utf-8

" files related
set nobackup
set nowritebackup
set noswapfile
set fileformats=unix,dos,mac

" Format the statusline
"set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
    let curdir = substitute(getcwd(), '/home/skrobul/', "~/", "g")
    return curdir
endfunction



" tab navigation like firefox
:nmap <C-S-tab> :tabprevious<CR>
:nmap <C-tab> :tabnext<CR>
:map <C-S-tab> :tabprevious<CR>
:map <C-tab> :tabnext<CR>
:imap <C-S-tab> <Esc>:tabprevious<CR>i
:imap <C-tab> <Esc>:tabnext<CR>i
:nmap <C-t> :tabnew<CR>
:imap <C-t> <Esc>:tabnew<CR>


" Buffers - explore/next/previous: Alt-F12, F12, Shift-F12.
nnoremap <M-F12> :BufExplorer<CR>
nnoremap <F12> :bn<CR>
nnoremap <S-F12> :bp<CR>

"wyszukiwanie w menu
set completeopt=menuone,longest,preview

" map control-backspace to delete the previous word
:imap <C-BS> <C-W>


"
" Plugins config
"
" CtrlP
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
set wildignore+=**/node_modules
let g:ctrlp_open_new_file = "r"
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' } "fuzzy matching with ctrlp+cmatcher"

" Ultisnip - disabled shortcuts so they don't conflict with YouCompleteMe
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'


" YCM: pre-populate completion with language syntax
let g:ycm_seed_identifiers_with_syntax = 1

" YCM: seed identifier databse with your files
" disable this if your tags are on network drive
let g:ycm_collect_identifiers_from_tags_files = 0

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"
" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#fnamemod = ':t' "display just filenames

" python-vim-instant-markdown
python import sys; sys.path.append('/Library/Python/2.7/site-packages')

" vim-markdown - no folding
let g:vim_markdown_folding_disabled=1

" Projects config
let g:project_use_nerdtree = 1

"NERDTree - autoclose when last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <F4> :NERDTreeToggle<CR>

" pencil theme
let g:pencil_higher_contrast = 1
let g:pencil_neutral_headings = 1
let g:pencil_terminal_italics = 1

" dispatch.vim + rspec
let g:rspec_command = ':Dispatch rspec {spec}'
" key mappings for rspec
map <Leader>c :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>z :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

"let g:rspec_runner = "os_x_iterm"

" EasyMotion
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion"

" mapping for dash
nmap <silent> <leader>d <Plug>DashSearch

" keymaps to help with transition back to vim
" indend / deindent after selecting the text with (⇧ v), (.) to repeat.
vnoremap <Tab> >
vnoremap <S-Tab> <
" comment / decomment & normal comment behavior
vmap <C-m> gc
" Disable tComment to escape some entities
let g:tcomment#replacements_xml={}
" Text wrap simpler, then type the open tag or ',"
vmap <C-w> S
" Cut, Paste, Copy
vmap <C-x> d
vmap <C-v> p
vmap <C-c> y
" Tabs
" let g:airline_theme='flatcolor'
let g:airline#extensions#tabline#enabled = 1
" temporarily disable until I figure out better shortcuts
" nnoremap <C-b>  :tabprevious<CR>
" inoremap <C-b>  <Esc>:tabprevious<CR>i
" nnoremap <C-n>  :tabnext<CR>
" inoremap <C-n>  <Esc>:tabnext<CR>i
" nnoremap <C-t>  :tabnew<CR>
" inoremap <C-t>  <Esc>:tabnew<CR>i
" nnoremap <C-k>  :tabclose<CR>
" inoremap <C-k>  <Esc>:tabclose<CR>i


set cursorline  "highlights current line

" make vundle compatible... (requires bash)"
set shell=/bin/bash



" disable arrows
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" buffer navigation
" new buffer (empty)
nmap <silent> <leader>t :enew<CR>
" next buffer
nmap <silent> <leader>n :bnext<CR>
" previous buffer
nmap <silent> <leader>p :bprevious<CR>
"close the buffer
nmap <silent> <leader>w :bp <BAR> bd #<CR>
" show all open buffers in buffer explorer
nmap <silent> <leader>b :ls<CR>

" ruby - convert hashes to 1.9+ syntax
command! NewRubyHashes :%s/:\([^ ]*\)\(\s*\)=>/\1:/g
" retab to n spaces
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

" gui related stuff
if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=Inconsolata\ for\ Powerline:h15
   endif
endif


" Projects init
set rtp+=~/.vim/bundle/vim-project
call project#rc("~/devel")


"Projects shared across all computers. Define non-shared in local vimrc
Project '~/skrovim'

set clipboard=unnamed

" Make 81st column stand out
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)


" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>
highlight WhiteOnRed ctermbg=red ctermfg=white
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

" this machine config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif"

