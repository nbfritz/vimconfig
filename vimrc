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
function! Toggle(opt)
  execute ':set '.a:opt.'! | set '.a:opt.'?'
endfunction
command! -nargs=+ Toggle call Toggle(<f-args>)
" }}}

" ---[ Plugins ]--- {{{
silent! call plug#begin('$VIMFILES/plugged')

" Color Schemes
"Plug 'morhetz/gruvbox'
"Plug 'ajh17/spacegray.vim'
"Plug 'tomasr/molokai'
"Plug 'alessandroyorba/despacio'
Plug 'jonathanfilip/vim-lucius'

" status lines (:help airline)
"let g:airline_left_sep='>'
"let g:airline_right_sep='<'
let g:airline_powerline_fonts=1
Plug 'bling/vim-airline'

" filesystem browser (:help nerdtree)
let g:NERDTreeShowBookmarks=1
let g:NERDTreeChDirMode=2
let g:NERDTreeWinSize=30
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
let g:pencil#wrapModeDefault = 'soft'
Plug 'reedes/vim-pencil'

" spell-check/thesaurus for writing (:help lexical)
Plug 'reedes/vim-lexical'

" highlight active paragraph (:help limelight)
Plug 'junegunn/limelight.vim'

" focused writing mode (:help goyo)
Plug 'junegunn/goyo.vim'

" ctrl-p project search (:help ctrlp)
Plug 'ctrlpvim/ctrlp.vim'

" indent guide
let g:indent_guides_guide_size=1
Plug 'nathanaelkane/vim-indent-guides'

" indentation and alignment helpers (:help tabular)
Plug 'godlygeek/tabular'

" nice markdown support (:help vim-markdown)
Plug 'tpope/vim-markdown', { 'do': { -> mkdp#util#install() } }
Plug 'iamcco/markdown-preview.nvim'
let g:mkdp_auto_close=0

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
set nowrap                          " start with wrapping disabled

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
colo lucius                         " set color scheme

set visualbell                      " flash instead of beeping
set ruler                           " show cursor position
set showcmd                         " display incomplete commands
set wildmenu                        " enable tab-completion menu in command mode
set history=50                      " 50 lines of command line history
set cmdheight=1                     " command line is two lines tall
set laststatus=2                    " always show a status line
set shortmess+=I                    " disable the welcome screen
set linespace=0                     " use default 0 linespaces even on windows
set colorcolumn=100                 " show a vertical line at the 100 character mark
set fillchars=vert:┃,fold:━         " fancy up the separators
set list                            " show hidden characters (next line sets chars)
set listchars=tab:⇒\ ,trail:‗,extends:⮞,precedes:⮜
" }}}

" ---[ Keyboard Mapping ]--- {{{
" <F1> to open my custom notes
" \f to open file list
" \r to open most recently used
" \n to toggle line numbering
" \h to toggle highlighted search
" \w to toggle line wrap
" \i to toggle indentation highlights
" \x to toggle writer's mode
" \+ to increase font size
" \- to decrease font size
" \0 to reset font size
" \= to enter font size edit mode

nmap <F1> :help nfnotes<CR>
nmap <silent> <leader>f :NERDTreeToggle<CR>
nmap <silent> <leader>r :MRU<CR>
nmap <silent> <leader>x :Write<CR>
nmap <silent> <leader>n :Toggle number<CR>
nmap <silent> <leader>h :Toggle hlsearch<CR>
nmap <silent> <leader>w :Toggle wrap<CR>
nmap <silent> <leader>i :IndentGuidesToggle<CR>
nmap <silent> <Leader>= <Plug>FontsizeBegin
nmap <silent> <Leader>+ <Plug>FontsizeInc
nmap <silent> <Leader>- <Plug>FontsizeDec
nmap <silent> <Leader>0 <Plug>FontsizeDefault
" }}}

" ---[ Commands ]--- {{{
command! -bar NotesEdit :vi +set\ modifiable $VIMFILES/doc/nfnotes.txt
command! -bar NotesIndex :helptags $VIMFILES/doc|echo "Notes Re-indexed!"

function! ToggleWrite()
  Goyo
  Limelight!!
  TogglePencil
endfunction
command! -bar Write call ToggleWrite()

function! FormatWithJQ()
  %!jq "."
endfunction
command! -bar JsonCleanup call FormatWithJQ()

function! Settings()
  if &modified
    split $MYVIMRC
  else
    e $MYVIMRC
  endif
  vsplit $MYGVIMRC
endfunction
command! -bar Settings call Settings()

function! SettingsConsole()
  lcd $VIMFILES
  Settings
  Gstatus
endfunction
command! -bar SettingsConsole call SettingsConsole()

command! -bar SettingsReload :source $MYVIMRC|source $MYGVIMRC

command! -bar Preview call mkdp#util#open_preview_page()
" }}}

" ---[ Filetype configuration ]--- {{{
autocmd BufEnter *.md set cursorline
autocmd BufLeave *.md set nocursorline
" }}}

" ---[ OS Specific Setup ]--- {{{
if g:os == 'Windows'
  source $VIMRUNTIME/mswin.vim
  behave mswin
endif
" }}}

" vim:fdm=marker:ft=vim
