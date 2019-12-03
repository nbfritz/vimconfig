" for more information see :help nbf

" ---[ Setup ]--- {{{
" Browser detection
" allows for conditional checks against g:os, which will be
" one of 'Windows', 'Linux', 'Darwin' (for mac)
if !exists('g:os')
  if has('win32') || has('win16')
    let g:os = 'Windows'
  else
    let g:os = substitute(system('uname'), '\n', '', '')
  endif
endif

" Vimfiles discovery
if isdirectory(expand('$HOME/vimfiles'))
  let $VIMFILES = expand('$HOME/vimfiles')
elseif isdirectory(expand('$HOME/.vim'))
  let $VIMFILES = expand('$HOME/.vim')
endif

" (http://vim.wikia.com/wiki/Quick_generic_option_toggling)
function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  "exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)
" }}}

" ---[ Plugins ]--- {{{
silent! call plug#begin('$VIMFILES/plugged')

" Color Schemes
Plug 'morhetz/gruvbox'

" status lines (:help airline)
let g:airline_left_sep=''
let g:airline_right_sep=''
Plug 'bling/vim-airline'

" filesystem browser (:help nerdtree)
let g:NERDTreeShowBookmarks=1
let g:NERDTreeChDirMode=2
let g:NERDTreeWinSize=45
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeWinPos="right"
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" git integration for vim (:help fugitive)
Plug 'tpope/vim-fugitive'

" most recently used (MRU) file list (:help MRU)
let MRU_Max_Entries = 50
Plug 'yegappan/mru'

" emmet html/css accellerators (:help emmet)
let g:user_emmet_leader_key = '<c-e>'
Plug 'mattn/emmet-vim'

" dynamic font zooming (:help fontsize)
Plug 'drmikehenry/vim-fontsize'

" vim for writers (:help pencil)
Plug 'reedes/vim-pencil'

" spell-check/thesaurus for writing (:help lexical)
Plug 'reedes/vim-lexical'

" highlight active paragraph (:help limelight)
Plug 'junegunn/limelight.vim'

" focused writing mode (:help goyo)
Plug 'junegunn/goyo.vim'

call plug#end()
" }}}

" ---[ General Options ]--- {{{
set nocompatible                    " run in full vim mode
set encoding=utf8                   " set default encoding
set number                          " enable line numbering

set backspace=indent,eol,start      " backspacing over everything in insert mode
set noswapfile                      " no swap files
set backup                          " enable backup versions
set mouse=a                         " enable mouse
set splitbelow                      " open new splits below
set splitright                      " open new vsplits to the right

syntax on                           " enable syntax highlighting
set nohlsearch                      " disable highlighted searching
set ignorecase                      " searches are case insensitive...
set smartcase                       " ...unless an upper case character is sought

set tabstop=2                       " basic tab stop
set shiftwidth=2                    " spaces per tab
set smarttab                        " insert tabs as spaces
set expandtab                       " replace tabs with spaces
set smartindent                     " autoindent following lines

set backupdir=$VIMFILES/tmp/backup  " backup file path
set undodir=$VIMFILES/tmp/undo      " undo file path
set directory=$VIMFILES/tmp/swap    " swap file path
" }}}

" ---[ Visual Options ]--- {{{
set background=dark                 " set dark backround coloring
colo gruvbox                        " set color scheme

set visualbell                      " flash instead of beeping
set ruler                           " show cursor position
set showcmd                         " display incomplete commands
set history=50                      " 50 lines of command line history
set cmdheight=1                     " command line is two lines tall
set laststatus=2                    " always show a status line
set shortmess+=I                    " disable the welcome screen
set colorcolumn=100                 " show a vertical line at the 100 character mark
set fillchars=vert:┊,fold:┄         " fancy up the separators
set list                            " show hidden characters (next line sets chars)
set listchars=tab:⇒\ ,trail:‗,extends:>,precedes:<
" }}}

" ---[ Keyboard Mapping ]--- {{{
" \f to open file list
" \r to open most recently used
" \l to toggle line numbering
" \h to toggle highlighted search
" \l to toggle line wrap
" \x to toggle writer's mode

nmap <silent> <leader>f :NERDTreeToggle<CR>
nmap <silent> <leader>r :MRU<CR>
nmap <silent> <leader>x :Write<CR>
MapToggle <leader>n number
MapToggle <leader>h hlsearch
MapToggle <leader>w wrap
" }}}

" ---[ Commands ]--- {{{
command! -bar Settings :split $MYVIMRC|vsplit $MYGVIMRC
command! -bar Reload :source $MYVIMRC|source $MYGVIMRC
command! -bar NotesEdit :vi +set\ modifiable $VIMFILES/doc/nfnotes.txt
command! -bar NotesIndex :helptags $VIMFILES/doc|echo "Notes Re-indexed!"

function! ToggleWrite()
  Goyo
  Limelight!!
  TogglePencil
endfunction
command! -bar Write call ToggleWrite()
" }}}

" ---[ OS Specific Setup ]--- {{{
if g:os == 'Windows'
  source $VIMRUNTIME/mswin.vim
  behave mswin
endif
" }}}

" vim:fdm=marker:ft=vim
