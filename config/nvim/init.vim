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
" tsuquyomi {{{
" disable neomake makers for typescript to avoid duplication
let g:neomake_typescript_enabled_makers = []
let g:tsuquyomi_disable_default_mappings = 1
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
lua require('skrobul/plugins/telescope')

" }}}
" {{{ octo.nvim
let g:octo_github_hostname = "github.rackspace.com"
" }}}
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

