" Vim file type plug-in
" Author: Peter Odding <peter@peterodding.com>
" Last Change: July 9, 2011
" URL: http://peterodding.com/code/vim/notes/

if exists('b:did_ftplugin')
  finish
else
  let b:did_ftplugin = 1
endif

" Disable highlighting of matching pairs. {{{1
setlocal matchpairs=
let b:undo_ftplugin = 'set matchpairs<'

" Copy indent from previous line. {{{1
setlocal autoindent
let b:undo_ftplugin .= ' autoindent<'

" Set &tabstop and &shiftwidth options for bulleted lists. {{{1
setlocal tabstop=3 shiftwidth=3 expandtab
let b:undo_ftplugin .= ' tabstop< shiftwidth< expandtab<'

" Automatic formatting for bulleted lists. {{{1
if xolox#notes#unicode_enabled()
  let &l:comments = ': • ,: * ,:> '
else
  let &l:comments = ': * ,:> '
endif
let &l:commentstring = '> %s'
setlocal formatoptions=tcron
let b:undo_ftplugin .= ' commentstring< comments< formatoptions<'

" Automatic text folding based on headings. {{{1
setlocal foldmethod=expr
setlocal foldexpr=xolox#notes#foldexpr()
setlocal foldtext=xolox#notes#foldtext()
let b:undo_ftplugin .= ' foldmethod< foldexpr< foldtext<'

" Enable concealing of notes syntax markers? {{{1
if has('conceal')
  setlocal conceallevel=3
  let b:undo_ftplugin .= ' conceallevel<'
endif

" Change <cfile> to jump to notes by name. {{{1
setlocal includeexpr=xolox#notes#include_expr(v:fname)
let b:undo_ftplugin .= ' includeexpr<'

" Enable completion of note titles using C-x C-u. {{{1
setlocal completefunc=xolox#notes#user_complete
let b:undo_ftplugin .= ' completefunc<'

" Enable completion of tag names using C-x C-o. {{{1
setlocal omnifunc=xolox#notes#omni_complete
let b:undo_ftplugin .= ' omnifunc<'

" Automatic completion of tag names after typing "@". {{{1
inoremap <buffer> <silent> @ <C-x><C-o>
let b:undo_ftplugin .= ' | execute "iunmap <buffer> @"'

" Change double-dash to em-dash as it is typed. {{{1
if xolox#notes#unicode_enabled()
  imap <buffer> -- —
  let b:undo_ftplugin .= ' | execute "iunmap <buffer> --"'
endif

" Change plain quotes to curly quotes as they're typed. {{{1
imap <buffer> <expr> ' xolox#notes#insert_quote(1)
imap <buffer> <expr> " xolox#notes#insert_quote(2)
let b:undo_ftplugin .= ' | execute "iunmap <buffer> ''"'
let b:undo_ftplugin .= ' | execute ''iunmap <buffer> "'''

" Change ASCII style arrows to Unicode arrows. {{{1
if xolox#notes#unicode_enabled()
  imap <buffer> -> →
  imap <buffer> <- ←
  let b:undo_ftplugin .= ' | execute "iunmap <buffer> ->"'
  let b:undo_ftplugin .= ' | execute "iunmap <buffer> <-"'
endif

" Convert ASCII list bullets to Unicode bullets. {{{1
imap <buffer> <expr> - xolox#notes#insert_bullet('-')
imap <buffer> <expr> + xolox#notes#insert_bullet('+')
imap <buffer> <expr> * xolox#notes#insert_bullet('*')
let b:undo_ftplugin .= ' | execute "iunmap <buffer> -"'
let b:undo_ftplugin .= ' | execute "iunmap <buffer> +"'
let b:undo_ftplugin .= ' | execute "iunmap <buffer> *"'

" Indent list items using <Tab>. {{{1
imap <buffer> <silent> <Tab> <C-o>:call xolox#notes#indent_list('>>', line('.'), line('.'))<CR>
smap <buffer> <silent> <Tab> <C-o>:<C-u>call xolox#notes#indent_list('>>', line("'<"), line("'>"))<CR><C-o>gv
let b:undo_ftplugin .= ' | execute "iunmap <buffer> <Tab>"'
let b:undo_ftplugin .= ' | execute "sunmap <buffer> <Tab>"'
imap <buffer> <silent> <S-Tab> <C-o>:call xolox#notes#indent_list('<<', line('.'), line('.'))<CR>
smap <buffer> <silent> <S-Tab> <C-o>:<C-u>call xolox#notes#indent_list('<<', line("'<"), line("'>"))<CR><C-o>gv
let b:undo_ftplugin .= ' | execute "iunmap <buffer> <S-Tab>"'
let b:undo_ftplugin .= ' | execute "sunmap <buffer> <S-Tab>"'

" vim: ts=2 sw=2 et
