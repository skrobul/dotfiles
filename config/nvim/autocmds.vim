filetype plugin indent on
augroup indentations
  "don't expand tabs if we're in a makefile
  autocmd BufRead,BufNewFile Makefile set ts=4 sw=4 noexpandtab
  "wrap lines in TeX
  autocmd BufRead,BufNewFile *.tex set tw=80
  "wrap lines in .txt files
  autocmd BufNewFile,BufRead *.txt set tw=78
  autocmd FileType ruby,eruby set sw=2 ts=2 tw=80 foldlevel=7
  autocmd FileType coffee set sw=2 ts=2 tw=80
  autocmd FileType python set ts=4 sw=4 tw=78 et
  autocmd FileType yaml,yml set sw=2 ts=2 tw=80
  autocmd FileType vue set sw=2 ts=2 tw=80
augroup END

augroup autocorrections
  autocmd!
  " remove trailing whitespaces
  autocmd BufWritePre ruby,eruby,markdown,yaml,yml,javascript,python :%s/\s\+$//e
augroup END

augroup markdown
  autocmd!
  autocmd BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,README.md  setf markdown
  autocmd FileType markdown set tw=160 conceallevel=3 wrap nonumber foldelvel=4
  autocmd FileType markdown,vimwiki lua require('cmp').setup.buffer({ matching = { disallow_fuzzy_matching = true, disallow_partial_matching=true}})
augroup end

augroup git
  autocmd!
  " enable spelling on GIT commit messages
  autocmd FileType gitcommit setlocal spell
  " enable auto word wrap in commit messages
  autocmd FileType gitcommit set sw=2 ts=2 tw=72 aw complete+=k
  " enable spelling and autowrap on pull requests
  autocmd VimEnter .git/PULLREQ_EDITMSG nested setlocal filetype=markdown tw=150
  autocmd FileType gitrebase noremap <CR> :Cycle<CR>
augroup end

"
" jump to the last cursor position
augroup resCur
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") && bufname() !~ ".git/COMMIT" |
        \   exe "normal g`\"" |
        \ endif
augroup END

augroup ansible
  autocmd BufRead,BufNewFile */host_vars/* set ft=yaml
  autocmd BufRead,BufNewFile */group_vars/* set ft=yaml
  autocmd BufRead,BufNewFile *.j2 set ft=jinja
augroup END

" Create non-existent directories when writing new file.
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

" New diary note is prepopulated with the template.
augroup vimwikitemplate
  autocmd!
  autocmd BufNewFile ~/Sync/notes/wiki/diary/*.md :silent 0r !~/dotfiles/vim/generate-vimwiki-template '%'
augroup END

" Disable line numbering in Taskwarrior
augroup taskwarrior
  autocmd!
  autocmd FileType taskreport set nonumber
augroup END

