" Default tab settings {{{
set tabstop=4
set softtabstop=4
set shiftwidth=4
" }}}

" General Configuration {{{
set nocompatible " Get rid of VI-isms.
set nobackup
set enc=utf-8
set tenc=utf-8
" }}}

" UI Configuration {{{
set ruler        " Show where we are in the file.
set showmode     " Because I'm stupid and like to know what mode I'm in.
set history=50
set visualbell
set showcmd
set incsearch
set backspace=indent,eol,start
set laststatus=2
set foldmethod=marker
set background=dark
set statusline=%<%f%h%m%r%=%l,%c%V\ %P\ %{&ff}\ 
syntax on
colors koehler

let php_folding=1
" let php_noShortTags=1

" Don't use Ex mode, use Q for formatting. Ex is annoying anyway.
map Q gq

if has("gui_running")
  set toolbariconsize=tiny
  set guifont=Monaco\ 8
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
" }}}

" Fix backspace behaviour under screen. {{{
if &term == 'screen'
  set t_kb=
endif
" }}}

if has("autocmd") " {{{

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Settings for various modes.
  autocmd BufNewFile,BufRead,Syntax *.rb,*.rhtml,*.scm,*.vim,.vimrc
    \ setlocal sw=2 ts=2 sts=2 et
  autocmd BufNewFile,BufRead,Syntax *.erl
    \ setlocal ai et
  autocmd BufNewFile,BufRead,Syntax *.py,*.hs
    \ setlocal et si
  autocmd FileType python
    \ setlocal et si


  " Python autocompletion.
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  inoremap <Nul> <C-x><C-o>

  "autocmd BufWritePre *.php,*.css,*.py,*.rb,*.rhtml,*.scm,*.sh,*.h,*.c,*.cc
  "  \ call ScrubTrailing()

  " automatically give executable permissions
  au BufWritePost *.pl,*.cgi,*.sh,*.py,*.rb
    \ call EnsureExecutable(expand("<afile>"))

  augroup END

else

  set autoindent " always set autoindenting on

endif " }}}

" Sane tab navigation {{{
nmap <A-PageUp>   :tabprevious<cr>
nmap <A-PageDown> :tabnext<cr>
map  <A-PageUp>   :tabprevious<cr>
map  <A-PageDown> :tabnext<cr>
imap <A-PageUp>   <ESC>:tabprevious<cr>i
imap <A-PageDown> <ESC>:tabnext<cr>i
nmap <C-n>        :tabnew<cr>
imap <C-n>        <ESC>:tabnew<cr>
" }}}

" Helpful window navigation {{{
" moves up and down between windows and maximises the focused window.
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
" }}}

" Functions {{{

function ScrubTrailing()
  let save_cursor = getpos('.')
  %s/\s\+$//e
  call setpos('.', save_cursor)
endfunction

function EnsureExecutable(f)
  if filewritable(a:f) && !executable(a:f)
    " This is horribly inadequate.
    call system("chmod a+x " . escape(a:f, ' \'))
  endif
endfunction

" }}}

"python <<EOF
"import os, sys, vim
"for p in sys.path:
"  if os.path.isdir(p):
"    vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
"EOF

"set tags+=$HOME/.vim/tags/python.ctags
