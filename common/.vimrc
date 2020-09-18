" General Configuration {{{
set nocompatible " Get rid of VI-isms.
set nobackup
set tenc=utf-8
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
" Both for minime, which as oddly slow scrolling.
set scrolljump=4
set ttyscroll=100
" http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns/3765575
if exists('+colorcolumn')
  set colorcolumn=79
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)
endif

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

au FileType text setlocal textwidth=78

au BufRead *.vala,*.vapi
  \ set efm=%f:%l.%c-%[%^:]%#:\ %t%[^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi
  \ setfiletype vala |
  \ setlocal cin et

" Dexy/JSON
au BufNewFile,BufRead *.dexy,*.json
  \ setfiletype javascript

au BufNewFile,BufRead *.fth
  \ setfiletype forth

au BufNewFile,BufRead *.genshi
  \ setfiletype genshi

au FileType yaml setlocal cursorcolumn

" Settings for various modes.
au BufNewFile,BufRead,Syntax *.rb,*.rhtml,*.scm,*.vim,.vimrc,*.ml,*.xml,*.mll,*.mly,*.lsa,*.xsd,*.css,*.scss
  \ setlocal sw=2 ts=2 sts=2 et
au BufNewFile,BufRead,Syntax *.erl,*.hs
  \ setlocal et ai si sta
au BufNewFile,BufRead,Syntax *.py,*.rst
  \ setlocal sw=4 ts=4 sts=4 et ai sta
au BufNewFile,BufRead,Syntax *.java,*.groovy,Jenkinsfile,Jenkinsfile.*
  \ setlocal sw=4 ts=4 sts=4 et ai sta
au BufNewFile,BufRead,Syntax *.rnc
  \ setlocal et ts=2 sts=2 sw=2 ai
au BufNewFile,BufRead,Syntax Makefile
  \ setlocal sw=8 ts=8 sts=8
au FileType python
  \ setlocal sw=4 ts=4 sts=4 et ai sta
au FileType groovy,java
  \ setlocal sw=4 ts=4 sts=4 et ai sta
au FileType lua
  \ setlocal sw=2 ts=2 sts=2 et ai sta

au BufWritePre *.py,*.rst,*.php,*.css,*.rb,*.rhtml,*.scm,*.sh,*.h,*.c,*.cc,*.lsa,*.ini,*.rnc
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

" Helpful window navigation {{{
" moves up and down between windows and maximises the focused window.
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
" }}}

" Functions {{{

" Collapse blank lines
function! Collapse()
  let save_cursor = getpos('.')
  %s/\s\+$//e
  %s/\n\{3,}/\r\r/e
  call setpos('.', save_cursor)
endfunction

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

set pastetoggle=<F11>

" Insert timestamp
nmap <F3> A<C-R>=strftime('%Y-%m-%d %H:%M:%S')<CR><Esc>
imap <F3> <C-R>=strftime('%Y-%m-%d %H:%M:%S')<CR>

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

" Needed for some work stuff. *shrug*
let g:go_version_warning = 0

let g:vim_markdown_folding_disabled = 1

" Completion {{{
set completeopt=preview,menuone,longest
let g:SuperTabDefaultCompletionType = '<C-X><C-O>'
let g:SuperTabDefaultCompletionType = 'context'
" }}}

" Register and load plugins {{{
" See: https://github.com/junegunn/vim-plug
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'dag/vim-fish'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'tag': 'v1.23' }
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'godlygeek/tabular' " Must come before vim-markdown
Plug 'hashivim/vim-terraform'
Plug 'mrk21/yaml-vim'
Plug 'nvie/vim-flake8'
Plug 'plasticboy/vim-markdown'
if has('python3')
  autocmd BufWritePre *.py
    \ execute ':Black'
  " Workaround: https://github.com/psf/black/issues/1293
  Plug 'psf/black', { 'tag': '19.10b0' }
endif
Plug 'Raimondi/delimitMate'
Plug 'rgrinberg/vim-ocaml'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'vimscript/toml'
call plug#end()
" }}}
