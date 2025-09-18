" General Configuration {{{
set nocompatible " Get rid of VI-isms.
set nobackup
set tenc=utf-8
set nojs         " Only use one space when wordwrapping
" }}}

" Default tab settings {{{
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nolinebreak
" }}}

" UI Configuration {{{
set showmode     " Because I'm stupid and like to know what mode I'm in.
set title        " Show the filename in the terminal title.
set visualbell t_vb=
set lazyredraw
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc,*.pyo,*.so,.*.sw*,__pycache__,*.bak,*.a,*.la,*.mo,.git,.svn,*.so
set backspace=indent,eol,start
set ttyfast
" http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns/3765575
if exists('+colorcolumn')
  set colorcolumn=79
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)
endif
set foldmethod=marker

" Further enhance filename completion by searching subfolders.
set path+=**

filetype indent plugin on

" Don't use Ex mode, use Q for formatting. Ex is annoying anyway.
vmap Q gq
nmap Q gqap

if has('gui_running')
  set guioptions-=m
  set guioptions-=T
  if has('gui_macvim')
    set guifont=Inconsolata:h9
  else
    set guifont=Inconsolata\ 9
  endif
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has('gui_running')
  set hlsearch
  set background=dark
  let g:solarized_termtrans = 1
  colors solarized
  syntax on
endif
" }}}

" Fancy linenumbers {{{
" For details, see https://jeffkreeftmeijer.com/vim-number/
set number " show line numbers
" }}}

" Fix backspace behaviour under screen. {{{
if &term[:5] == 'screen' || &term == 'tmux'
  set t_kb=
endif
" }}}

" Autocommands {{{
" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
au!

au FileType text setlocal textwidth=120

au FileType yaml setlocal cursorcolumn

" Settings for various modes.
au BufNewFile,BufRead,Syntax *.vim,.vimrc,*.xml
  \ setlocal sw=2 ts=2 sts=2 et
au BufNewFile,BufRead,Syntax *.py,*.rst
  \ setlocal sw=4 ts=4 sts=4 et ai sta
au BufNewFile,BufRead,Syntax Makefile
  \ setlocal sw=8 ts=8 sts=8
au FileType groovy,java
  \ setlocal sw=4 ts=4 sts=4 noet ai sta
au FileType *.java,*.groovy,Jenkinsfile*
  \ setlocal sw=4 ts=4 sts=4 noet ai sta
au FileType python
  \ setlocal sw=4 ts=4 sts=4 et ai sta
au FileType ocaml,dart,css,lua
  \ setlocal sw=2 ts=2 sts=2 et ai sta
au BufWritePre *.py,*.rst,*.php,*.css,*.rb,*.rhtml,*.scm,*.sh,*.h,*.c,*.cc,*.lsa,*.ini,*.rnc,*.lua
  \ call ScrubTrailing()

" Automatically give executable permissions
au BufWritePost *.cgi,*.sh
  \ call EnsureExecutable(expand('<afile>'))

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
au BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line('$') |
  \   exe 'normal g`"' |
  \ endif

augroup END
" }}}

" Deactivate F1 and turn it into Escape {{{
inoremap <F1> <nop>
nnoremap <F1> <nop>
vnoremap <F1> <nop>
" }}}

" Deactivate the arrow and page up/down keys to help rid me of a bad habit. {{{
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
noremap <PageUp> <nop>
noremap <PageDown> <nop>
" }}}

inoremap {<CR> {<CR>}<C-o>O
inoremap [<CR> [<CR>]<C-o>O
inoremap (<CR> (<CR>)<C-o>O

" Functions {{{

function! ScrubTrailing()
  let save_cursor = getpos('.')
  " Scrub trailing spaces
  %s/\s\+$//e
  " Scrub trailing lines
  %s/\($\n\s*\)\+\%$//e
  call setpos('.', save_cursor)
endfunction

function! EnsureExecutable(f)
  if filewritable(a:f) && !executable(a:f)
    " This is horribly inadequate.
    call system('chmod a+x ' . escape(a:f, ' \'))
  endif
endfunction

" }}}

" airline config
let g:airline_theme = 'dark'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 0
" I don't use the custom fonts.
let g:airline_left_sep = ''
let g:airline_right_sep = ''

let python_highlight_all = 1

let g:terraform_align = 1
let g:terraform_fmt_on_save = 1

let g:rustfmt_autosave = 1

let g:ocaml_highlight_operators = 1

" Needed for some work stuff. *shrug*
let g:go_version_warning = 0

let g:gitgutter_enabled = 1

" Completion {{{
set completeopt=preview,menuone,longest
let g:SuperTabDefaultCompletionType = '<C-X><C-O>'
let g:SuperTabDefaultCompletionType = 'context'
" }}}

" Register and load plugins {{{
" See: https://github.com/junegunn/vim-plug
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'dag/vim-fish'
Plug 'davidhalter/jedi-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hashivim/vim-terraform'
Plug 'mrk21/yaml-vim'
Plug 'ocaml/vim-ocaml'
Plug 'rust-lang/rust.vim'
if has('python3')
  Plug 'psf/black', { 'tag': '25.1.0' }
  autocmd BufWritePre *.py execute ':Black'
endif
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'vimscript/toml'
call plug#end()
" }}}
