" {{{ vim-plug auto installation
"
lua require("start")
set shell=/bin/bash
"}}}
" Autocmd {{{
if has('autocmd')
    source "~/.config/nvim/autocmds.vim"
endif " }}}
" VIM Settings {{{
syntax on


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""

" Make 81st column stand out
highlight ColorColumn ctermbg=Brown ctermfg=Black
call matchadd('ColorColumn', '\%81v', 100)

" let &colorcolumn=join(range(81,999),",")


" }}}
" normal mode mappings (general) {{{
nnoremap <silent> <Leader>q :nohlsearch<CR><C-L>
nnoremap <CR> :noh<CR><CR>

" Replace all occurences of word under cursor
nnoremap <Leader>z :%s/\<<C-r><C-w>\>//g<Left><Left>
" space bar folding
nnoremap  <silent>  <space> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<cr>

" disable arrows
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Don't use Ex mode, use Q for formatting
map Q gq

" lookup in Dash
nmap <silent> <leader>d <Plug>DashSearch

" buffer navigation
" new buffer (empty)
nnoremap <silent> <leader>bt :enew<CR>
" next buffer
nnoremap <silent> <leader>n :bnext<CR>
" previous buffer
nnoremap <silent> <leader>p :bprevious<CR>
"close the buffer and replace with previous
nnoremap <silent> <leader>bc :bp <BAR> bd #<CR>
"close the buffer
nnoremap <silent> <leader>bd :bd<CR>
" show all open buffers in buffer explorer
" nmap <silent> <leader>b :ls<CR>
" nmap <silent> <leader>b :CtrlPBuffer<cr>
nnoremap <silent> <Leader>bl :CocList -N buffers<CR>
vmap <silent> <Leader>bl :CocList -N buffers<CR>

nnoremap <silent> '' :CocList -N buffers<CR>
vmap <silent>' :CocList -N buffers<CR>
" ruby context endings - insert marks
nmap <Leader>z /end%y$%A # p:nohlsearch

" Map `kj` to ESC
imap kj <ESC>

" automatically insert a \v before any search string, so search uses normal regexes
nnoremap / /\v
vnoremap / /\v

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" Easy reloading of vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Switch to alternative file quickly
" nnoremap <Tab><Tab> <C-^>

if has("nvim")
    " neovim's terminal
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
endif


" autocmd BufEnter term://* startinsert

" }}}
" visual mode mappings {{{

" indent / deindent after selecting the text with (⇧ v), (.) to repeat.
vnoremap <Tab> >
vnoremap <S-Tab> <
" comment / decomment & normal comment behavior
vmap <C-m> gc
" Text wrap simpler, then type the open tag or ',"
vmap <C-w> S
" Cut, Paste, Copy
vmap <C-x> d
vmap <C-v> p
vmap <C-c> y

" "}}}
" gui related stuff {{{
if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=Sauce\ Code\ Powerline:h14
      set guioptions-=r
   endif
endif
" }}}
" Plugins config {{{
" {{{ vim-markdown
" let g:vim_markdown_folding_disabled=0
let g:vim_markdown_folding_disabled = 0
let g:vim_markdown_new_list_item_indent = 2
" workaround https://github.com/plasticboy/vim-markdown/issues/414
let g:vim_markdown_folding_style_pythonic = 1
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'ruby', 'javascript']
" }}}
" NERDTree - autoclose when last buffer {{{
map <F4> :NERDTreeToggle<CR>
" }}}
" instant markdown {{{
let g:instant_markdown_slow = 1
" "}}}
" fugitive {{{
nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gc :Gcommit -v -q<CR>
nnoremap <Leader>gt :Gcommit -v -q %:p<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR><CR>
nnoremap <Leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <Leader>gp :Ggrep<Space>
nnoremap <Leader>gm :Gmove<Space>
nnoremap <Leader>gb :Git branch<Space>
nnoremap <Leader>go :Git checkout<Space>
nnoremap <Leader>gps :Git push<CR>
nnoremap <Leader>gpl :Git pull<CR>
" git merges
" map <silent> <leader>2 :diffget //2<CR> :diffupdate<CR>
" map <silent> <leader>3 :diffget //3<CR> :diffupdate<CR>

map <silent> <leader>1 :diffget BA<CR> :diffupdate<CR>
map <silent> <leader>2 :diffget LO<CR> :diffupdate<CR>
map <silent> <leader>3 :diffget RE<CR> :diffupdate<CR>
" gitv
nnoremap <Leader>gv :Gitv --all<CR>
nnoremap <Leader>gV :Gitv! --all<CR>
vmap <leader>gV :Gitv! --all<cr>

" }}}
" gina {{{
" nnoremap <Leader>gs :Gina status -s<CR>
" nnoremap <Leader>gc :Gina commit -v<CR>
" nnoremap <Leader>gp :Gina push<CR>
" nnoremap <Leader>gl :Gina log<CR>
" " use C to switch between the status/commit section
" autocmd FileType gina-status
"       \ nnoremap <silent><buffer> gc
"       \ :<C-u>Gina commit<CR>
" autocmd FileType gina-commit
"       \ nnoremap <silent><buffer> gs
"       \ :<C-u>Gina status<CR>
" call gina#custom#mapping#nmap('status', '<C-n>', 'j<Plug>(gina-show-preview)')
" call gina#custom#mapping#nmap('status', '<C-p>', 'k<Plug>(gina-show-preview)')
" " open three way diffs in vertical
" set diffopt+=vertical
"}}}
" {{{2 prosession configuration
let g:prosession_dir = '~/.vim/session/'
let g:prosession_tmux_title = 1
"}}}
" easy align{{{2
"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
""}}}
" vim-gist {{{2
let g:gist_api_url = 'https://github.rackspace.com/api/v3'
let g:gist_post_private = 1
let g:gist_show_privates = 1
""}}}
" vim-ruby {{{
let g:ruby_indent_block_style = 'do'
" }}}
" ag - The Silver Searcher {{{
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" let g:ag_prg="/usr/local/bin/ag --vimgrep"

" }}}
" vim-outliner {{{
" autocmd! FileType votl inoremap <C-n> <ESC>:call UltiSnips#ExpandSnippet()<CR>i
autocmd! FileType votl inoremap <C-n> <Esc>:call UltiSnips#ExpandSnippetOrJump()<CR>
autocmd! FileType votl set nolist foldlevel=1

" }}}
" tsuquyomi {{{
" disable neomake makers for typescript to avoid duplication
let g:neomake_typescript_enabled_makers = []
let g:tsuquyomi_disable_default_mappings = 1
" }}}
" tmux-navigate {{{
" temp fix for https://github.com/neovim/neovim/issues/2048
if has('nvim')
    nmap <silent> <BS> :TmuxNavigateLeft<CR>
endif
" }}}
" {{{ tableize / table mode
let g:table_mode_map_prefix = "<leader>y"
let g:table_mode_corner='|' "markdown tables"

" }}}
" {{{ seeing is believing
" Enable seeing-is-believing mappings only for Ruby
augroup seeingIsBelievingSettings
  autocmd!

  autocmd FileType ruby nmap <buffer> <M-Enter> <Plug>(seeing-is-believing-mark-and-run)
  autocmd FileType ruby xmap <buffer> <M-Enter> <Plug>(seeing-is-believing-mark-and-run)

  autocmd FileType ruby nmap <buffer> <F5> <Plug>(seeing-is-believing-mark)
  autocmd FileType ruby xmap <buffer> <F5> <Plug>(seeing-is-believing-mark)
  autocmd FileType ruby imap <buffer> <F5> <Plug>(seeing-is-believing-mark)

  autocmd FileType ruby nmap <buffer> <F6> <Plug>(seeing-is-believing-run)
  autocmd FileType ruby imap <buffer> <F6> <Plug>(seeing-is-believing-run)
augroup END
" }}}
" {{{ vim-test
nnoremap <silent> ,rt :TestSuite<cr>
nnoremap <silent> ,rf :TestFile<cr>
nnoremap <silent> ,rn :TestNearest<cr>
nnoremap <silent> ,rr :TestLast<cr>
nnoremap <silent> ,rv :TestVisit<cr>
let test#strategy = "neovim"
let test#neovim#term_position = "vert"
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

let g:dispatch_compilers = {}
let g:dispatch_compilers['bundle exec'] = ''
let g:dispatch_compilers['rspec'] = 'rspec'

" }}}
" {{{ neoterm
" Useful maps
" hide/close terminal
nnoremap <silent> ,th :call neoterm#close()<cr>
" clear terminal
nnoremap <silent> ,tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tc :call neoterm#kill()<cr>
" send line to REPL
" Use gz{text-object} in normal mode
nnoremap gz <Plug>(neoterm-repl-send)
" Send selected contents in visual mode.
xnoremap gz <Plug>(neoterm-repl-send)
" use `gzz` or `2gzz` to send current or 2 lines to REPL.
nnoremap gzz <Plug>(neoterm-repl-send-line)
" }}}
" vim-livedown {{{
" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 0

" should the browser window pop-up upon previewing
let g:livedown_open = 1

" the port on which Livedown server will run
let g:livedown_port = 1337

nmap gm :LivedownToggle<CR>
" }}}
" {{{ vim-rspec
map <Leader>tf :call RunCurrentSpecFile()<CR>
map <Leader>tn :call RunNearestSpec()<CR>
map <Leader>tl :call RunLastSpec()<CR>
map <Leader>ta :call RunAllSpecs()<CR>
"let g:rspec_command = "Dispatch -compiler=rspec bundle exec rspec {spec} --format=progress"
" Yoinked from rails.vim to support rspec keyword highlighting outside Rails
" project folders
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it its specify shared_context shared_examples shared_examples_for shared_context include_examples include_context it_should_behave_like it_behaves_like before after around subject scenario feature background given described_class violated pending expect expect_any_instance_of allow allow_any_instance_of double instance_double mock xit fit
highlight def link rubyRspec Function

if has("nvim")
  let g:rspec_command = ':call RunMySpecs("{spec}")'

  function! RunMySpecs(specs)
    execute 'split | terminal bundle exec rspec ' . a:specs
    execute feedkeys("\<c-\>\<c-n>")
  endfunction
endif
" }}}
" {{{ ale
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_delay = 500
let g:ale_lint_on_save = 0
let g:ale_sign_warning = ''
let g:ale_sign_error = '✖'
let g:ale_cache_executable_check_failures=1
let g:ale_linters = {
\     'vimwiki': [],
\}
let g:ale_fixers = {
            \  'ruby': ['rubocop']
            \}
" }}}
" {{{ coc.nvim
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" let g:coc_snippet_next = '<tab>'
" " Use <leader>x for convert visual selected code to snippet
" xmap <leader>x  <Plug>(coc-convert-snippet)
" " Use <C-l> for trigger snippet expand.
" imap <C-l> <Plug>(coc-snippets-expand)

" " Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)
" imap <C-j> <Plug>(coc-snippets-expand-jump)

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-s-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" conflicts with endwise.vim
" https://github.com/neoclide/coc.nvim/issues/297
" additionally, we need to disable endwise default mappings
"inoremap <expr> <cr> pumvisible() ? "\<C-y>\<Plug>DiscretionaryEnd" : "\<C-g>u\<CR>"
let g:endwise_no_mappings = 1
" imap <expr> <CR> (pumvisible() ? "\<C-y>\<CR>\<Plug>DiscretionaryEnd" : "\<CR>\<Plug>DiscretionaryEnd")

" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)

"" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

"" Use K to show documentation in preview window
"nnoremap <silent> K :call <SID>show_documentation()<CR>

"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  else
"    call CocAction('doHover')
"  endif
"endfunction

"" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')

"" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)
"nmap <leader>rf <Plug>(coc-refactor)

"" Remap for format selected region
"xmap <leader>cf  <Plug>(coc-format-selected)
"nmap <leader>cf  <Plug>(coc-format-selected)

"augroup mygroup
"  autocmd!
"  " Setup formatexpr specified filetype(s).
"  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"  " Update signature help on jump placeholder
"  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end

"" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)<cr>
"nmap <leader>a  <Plug>(coc-codeaction-selected)<cr>

"" Remap for do codeAction of current line
"nmap <leader>ac  <Plug>(coc-codeaction)<cr>
"" Fix autofix problem of current line
"nmap <leader>qf  <Plug>(coc-fix-current)

"" Create mappings for function text object, requires document symbols feature of languageserver.
"xmap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap if <Plug>(coc-funcobj-i)
"omap af <Plug>(coc-funcobj-a)

"" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
""nmap <silent> <C-d> <Plug>(coc-range-select)
""xmap <silent> <C-d> <Plug>(coc-range-select)

"" Use `:Format` to format current buffer
"command! -nargs=0 Format :call CocAction('format')

"" Use `:Fold` to fold current buffer
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"" use `:OR` for organize import of current buffer
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"" Using CocList
"" Show all diagnostics
"nnoremap <silent> <leader>ca  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
"" Search workleader symbols
"nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <leader>cj  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <leader>ck  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent> <leader>cp  :<C-u>CocListResume<CR>

"" List of installed coc extensions
"let g:coc_global_extensions = [
"            \ 'coc-css',
"            \ 'coc-diagnostic',
"            \ 'coc-emmet',
"            \ 'coc-emoji',
"            \ 'coc-eslint',
"            \ 'coc-html',
"            \ 'coc-json',
"            \ 'coc-lists',
"            \ 'coc-prettier',
"            \ 'coc-pyright',
"            \ 'coc-snippets',
"            \ 'coc-solargraph',
"            \ 'coc-tsserver',
"            \ 'coc-vetur',
"            \ 'coc-yaml',
"            \ ]

"let g:coc_filetype_map = {
"  \ 'eruby': 'html',
"  \ }
"" }}}
" {{{ nvim-lspconfig
" language servers:
"  https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

-- Enable completion triggered by <c-x><c-o>
buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

require "lsp_signature".on_attach()

-- Mappings.
local opts = { noremap=true, silent=true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local lsp_installer = require("nvim-lsp-installer")

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    local opts = { on_attach = on_attach, capabilities = capabilities }

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
EOF
" }}}
" {{{ nvim-cmp 
lua << EOF
local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
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
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'path' },
      -- { name = 'cmp_git' }, 
      { name = 'buffer', max_item_count = 10, keyword_length = 5 },
      { name = 'tmux', option = { all_panes = false }, keyword_length = 5 },
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
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline', max_item_count = 20 }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  --   capabilities = capabilities
  -- }


  -- cmp-git
--  require("cmp_git").setup({
--    filetypes = { "gitcommit" },
--    trigger_actions = {
--        {
--                debug_name = "git_commits",
--                trigger_character = ":",
--                action = function(sources, trigger_char, callback, params, git_info)
--                return sources.git:get_commits(callback, params, trigger_char)
--            end,
--        },
--        {
--                debug_name = "github_issues_and_pr",
--                trigger_character = "#",
--                action = function(sources, trigger_char, callback, params, git_info)
--                return sources.github:get_issues_and_prs(callback, git_info, trigger_char)
--            end,
--        },
--        {
--                debug_name = "github_mentions",
--                trigger_character = "@",
--                action = function(sources, trigger_char, callback, params, git_info)
--                return sources.github:get_mentions(callback, git_info, trigger_char)
--            end,
--        },
--    }
--  })
EOF

" }}}
" vim-airline {{{
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tagbar#enabled = 0
let g:airline_section_y = '' " fileencoding
" let g:airline_section_z = '' " percentage
let g:airline_section_z = airline#section#create(['%l', ':', '%v'])
let g:airline#extensions#hunks#enabled = 0
" }}}
" {{{ vimwiki
" while g:vimwiki_global_ext is supposed to control creation of 'temporary
" wikis' outside the defined directories, in reality this breaks markdown
" files everywhere, so we set it to 0
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path': '~/Sync/notes/wiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]

let g:vimwiki_folding = 'expr'
" these mappings are needed to enable lazy plugin loading and reduce vim
" startup time
nnoremap <silent><script> <leader>ww :VimwikiIndex<CR>
nnoremap <silent><script> <leader>wi :VimwikiDiaryIndex<CR>
nnoremap <silent><script> <leader>w\w :VimwikiMakeDiaryNote<CR>
" switch vimgrep to use ag if available
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --hidden\ --ignore\ .git
endif
" }}}
" {{{ vim-org
let maplocalleader = "-"
let g:org_aggressive_conceal = 0
let g:org_agenda_files = ['/mnt/gtd/gtd.org', '/mnt/gtd/inbox.org']
let g:org_todo_keywords = [['TODO(t)', 'STARTED(s)', 'WAITING(w)', '|', 'DONE(d)', 'CANCELLED(c)']]
" }}}
" {{{ vim-bullets
" Bullets.vim
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'vimwiki'
    \]
" }}}
" {{{ suda
let g:suda_smart_edit = 1
" }}}
" {{{ fzf.vim
"nnoremap <silent><C-p> :Files<CR>
"vnoremap <silent><C-p> :Files<CR>
" }}}
"nrrw {{{ no mappings
let g:nrrw_rgn_nomap_nr = 1
let g:nrrw_rgn_nomap_Nr = 1
"}}}
" {{{ telescope.nvim
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fm <cmd>Telescope man_pages<cr>
nnoremap <leader>fc <cmd>Telescope colorscheme<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
nnoremap <leader>fd <cmd>Telescope lsp_definitions<cr>
nnoremap <silent><C-p> <cmd>Telescope find_files<cr>

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' },

    defaults =  {
        mappings = {
            i = {
                -- etc
                ["<esc>"] = actions.close
            }
        }
    }
}
EOF

" }}}
" {{{ octo.nvim
let g:octo_github_hostname = "github.rackspace.com"
" }}}
" {{{ nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  ensure_installed = "maintained"
}
EOF
set background=dark
" or set background=light
"}}}

" end of plugin config }}}
"{{{ colorscheme
if has('termguicolors')
    set termguicolors
endif
let ayucolor="dark"                " set to light, mirage or dark
let g:two_firewatch_italics=1

let g:edge_style = 'default'   "default, aura or neon

set background=dark
let g:airline_theme='base16'
let g:nord_bold_vertical_split_line = 1
let g:nord_cursor_line_number_background = 1
let g:nord_italic_comments = 1

colorscheme gitgud

" local modifications
" search results blue instead of orange
" hi Search ctermfg=234 ctermbg=221 guifg=#101112 guibg=#B7C0C9
" more distinct line nr
"hi LineNr ctermfg=237 guibg=#2F3339 guifg=#707885

" fix gitgutter background
"hi GitGutterAdd ctermfg=2 guifg=#009900 guibg=#2F3339
"hi GitGutterDelete ctermfg=1 guifg=#ff2222 guibg=#2F3339
"hi GitGutterChange ctermfg=3 guifg=#bbbb00 guibg=#2F3339

" color constants with blue instead of orange
"hi Type ctermfg=173 guifg=#23A1D3
"}}}
" custom commands {{{
" bind \a (backward slash) to grep shortcut
"command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
" map ag to leader a
nnoremap <Leader>sa :Ag<SPACE>
function! ArrayConvertToW()
    execute "normal /=\s+<cr>evf]"
    s/\%V,/ /ge
    s/\v\[(.*)\]/%w(\1)/
 endfunction
 command! ArrayConvertToW :call ArrayConvertToW()<cr>
" json prettyfiy
command! JSONPretty %!python -m json.tool
" ruby - convert hashes to 1.9+ syntax
command! NewRubyHashes :%s/:\([^ ]*\)\(\s*\)=>/\1:/g
" retab to n spaces
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g
" load all feature branch commits into buffer
command! Glfeature Glog master..HEAD --reverse --

" Useful trick when I've forgotten to `sudo' before editing a file:
cmap w!! w !sudo tee % >/dev/null

" trim trailing whitespace
command! TrimWhiteSpace :%s/\ \+$//

function! s:OpenPullRequest(...)
  vsplit ~/.git_PR_message
  normal! ggdG
  setlocal filetype=gitcommit
  setlocal bufhidden=delete
  let template = [
              \ '',
              \ '# ------------------------ >8 ------------------------',
              \ '# Do not modify or remove the line above.',
              \ '# Everything below it will be ignored.',
              \ '',
              \ '# Write a message for this pull request. The first block',
              \ '# of text is the title and the rest is the description.']
  call append(line('^'), template)
  execute ':r !git log --oneline master..HEAD'
  normal! gg
  autocmd BufDelete <buffer> ++once call s:SubmitPR()
  autocmd BufWritePre <buffer> call s:CleanupPullRequestMessage()
endfunction
function! s:CleanupPullRequestMessage(...)
   call cursor(0,0)
   call search('>8')
   echom bufname()
   call deletebufline(bufname(), line("."), '$')
endfunction
function! s:SubmitPR(...)
    silent !clear
    execute '!hub pull-request -p -F ~/.git_PR_message'
    call delete(expand('~/.git_PR_message'))
endfunction
command! PR :call s:OpenPullRequest()

" }}}
" local machine config {{{
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
"}}}
" vim: foldmethod=marker foldlevel=0

