" Default tab settings {{{
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=80
set nolinebreak
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
set history=500
set visualbell
set showcmd
set incsearch
set backspace=indent,eol,start
set laststatus=2
set foldmethod=marker
set statusline=%<%f%h%m%r%=%l,%c%V\ %P\ %{&ff}\ 
set number
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc,*.pyo
set ttyfast
set mouse=a
" Both for minime, which as oddly slow scrolling.
set scrolljump=4
set ttyscroll=100
" http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns/3765575
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Don't use Ex mode, use Q for formatting. Ex is annoying anyway.
map Q gq

if has("gui_running")
  set guioptions-=tT
  set toolbariconsize=tiny
  set guifont=Inconsolata\ 9
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set hlsearch
  set background=dark
  syntax enable
  if $TERM != "linux"
    " Enable 256-colour mode (rather than the default 8-colour mode).
    set t_Co=256
  endif
  colors solarized
endif

" For displaying nasty whitespace.
set listchars=tab:>.,trail:.,nbsp:.
" }}}

" Fix backspace behaviour under screen. {{{
if &term == 'screen'
  set t_kb=
endif
" }}}

" Autocommands {{{
if has("autocmd")

  " Pathogen {{{
  " Read this: http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen
  call pathogen#helptags()  
  call pathogen#runtime_append_all_bundles()  
  " }}}

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  au BufRead *.vala,*.vapi
        \ set efm=%f:%l.%c-%[%^:]%#:\ %t%[^:]%#:\ %m
  au BufRead,BufNewFile *.vala,*.vapi 
        \ setfiletype vala |
        \ setlocal cin et

  " Dexy
  au BufNewFile,BufRead .dexy
        \ setfiletype javascript

  " Settings for various modes.
  au BufNewFile,BufRead,Syntax *.rb,*.rhtml,*.scm,*.vim,.vimrc
        \ setlocal sw=2 ts=2 sts=2 et
  au BufNewFile,BufRead,Syntax *.erl,*.hs
        \ setlocal et ai si sta

  " Automatically give executable permissions
  au BufWritePost *.cgi,*.sh
        \ call EnsureExecutable(expand("<afile>"))

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  augroup END

else

  set autoindent " Always set autoindenting on

endif " has("autocmd")
" }}}

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

" Deactivate F1 and turn it into Escape {{{
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
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
