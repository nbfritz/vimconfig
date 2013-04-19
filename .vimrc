" Remember, [zo] to open a fold. [zc] to close it. [zR] to open them all. [zM] to close them all.

" ===== Functions ===== {{{
function! s:MapToggle(key, opt)
 let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
 exec 'nnoremap '.a:key.' '.cmd
 exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call s:MapToggle(<f-args>)

function! s:EnableTextWrapMode()
  set wrap
  set linebreak
  set textwidth=102
  set nolist
endfunction
command! WrapText call s:EnableTextWrapMode()

command! SettingsEdit :vi $MYVIMRC
command! SettingsReload :source $MYVIMRC
command! NotesEdit :vi +set\ modifiable ~/.vim/doc/nfnotes.txt
command! NotesReload :helptags ~/.vim/doc

command! StripCarriageReturns :%s/\r//g
command! StripTrailingSpaces :%s/\s\+$//g

"}}}

" ===== general settings ===== {{{
set nocompatible      " run in VIM rather than VI mode
set encoding=utf8
set number

" load in preset configuration for MS windows
source $VIMRUNTIME/mswin.vim
behave mswin

" enable backspacing over everything in insert mode
set backspace=indent,eol,start

set backupdir=~/.vim/tmp/backup// " locate backups
set directory=~/.vim/tmp/swap//   " locate swap files
set noswapfile                    " no swap files 
set backup                        " enable backup versions
set mouse=a                       " enable mouse
syntax on                         " enable syntax highlighting
set hlsearch                      " enable highlighted searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " unless an upper case character is sought

let mapleader = ','               " a bunch of keyboard commands use the leader character...
"}}}

" ===== bundle configuration ===== {{{

" bundle management
" ==> :help Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" project management for vim
" ==> :help project
let g:proj_flags="imst"
let g:proj_window_width=36
Bundle 'project.tar.gz'

" functions used by other plugins
Bundle "L9"

" align on separator characters
" ==> :help align
let g:DrChipTopLvlMenu="Plugin."
Bundle 'tsaleh/vim-align'

" automatic insertion of end statements
Bundle 'tpope/vim-endwise'

" extended . repeat command (now works with more plugins)
Bundle 'tpope/vim-repeat'

" mass changing of wrapping tags and characters
" ==> :help surround
Bundle 'tpope/vim-surround'

" a set of very handy pairs of actions like encodings, line shifts, etc.
" ==> :help unimpaired
Bundle 'tpope/vim-unimpaired'

" filesystem browser
" ==> :help nerdtree
let g:NERDTreeShowBookmarks=1
let g:NERDTreeChDirMode=2
let g:NERDTreeWinSize=40
let g:NERDTreeQuitOnOpen=1
Bundle 'scrooloose/nerdtree' 

" support for user-defined text objects (required by vim-textobj-rubyblock)
" ==> :help textobj
Bundle 'kana/vim-textobj-user'

" more sophisticated copy and paste system with numbered registers
" ==> :help yankring
"Bundle 'vim-scripts/YankRing.vim'

" extension to the % matcher to work with more than single characters
" ==> :help matchit
Bundle 'edsono/vim-matchit'

" awesome search tool mapped to C-p
" ==> :help ctrlp
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\.class$'
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_cmd = 'CtrlP getcwd()'
Bundle 'kien/ctrlp.vim'

" scratch buffers with :Scratch
Bundle 'vim-scripts/scratch.vim'

" nifty commenting commands
" ==> :help nerdcommenter
Bundle 'scrooloose/nerdcommenter' 

" buffer switching
" ==> :help buffergator
let g:buffergator_autoexpand_on_split=0
let g:buffergator_suppress_keymaps=1
Bundle 'Buffergator'

" ruby extensions
" ==> :help vim-ruby
Bundle 'vim-ruby/vim-ruby'

" ruby on rails extensions
" ==> :help rails
Bundle 'tpope/vim-rails'

" text matcher for selecting ruby blocks with ar and ir
" ==> :help rubyblock
Bundle 'nelstrom/vim-textobj-rubyblock'

" easy refactoring in ruby
" ==> :help rubyrefactoring
Bundle 'ecomba/vim-ruby-refactoring'

" tag browser for navigating through functions/variables/etc. in a script
" ==> :help tagbar
Bundle 'majutsushi/tagbar'

" git integration for vim
" ==> :help fugitive
Bundle 'tpope/vim-fugitive' 

" svn (and others) integration for vim
" ==> :help vcscommand
Bundle 'vcscommand.vim'

" autocompletion
" ==> :help neocomplcache
Bundle 'neocomplcache'

" use tab for completion in visual mode
" ==> :help supertab 
Bundle 'SuperTab-continued.'

" railscasts color scheme
Bundle 'railscasts'

" markdown support
Bundle 'Markdown'

" plugin to interpret and reference indentation levels (with ai, ii, aI, and iI)
" ==> :help indent-object
Bundle 'michaeljsmith/vim-indent-object'
let g:indentobject_meaningful_indentation = ["haml", "sass", "python", "yaml", "markdown"]

" beautiful status lines
" ==> :help powerline
Bundle 'Lokaltog/vim-powerline'
let g:Powerline_symbols = 'compatible'

" coldfusion support
Bundle 'https://github.com/davejlong/cf-utils.vim'

" mark indicators
let g:showmarks_enable=0
Bundle 'ShowMarks'

" addons required by snippets'
Bundle 'MarcWeber/vim-addon-mw-utils'

" css coloring
Bundle 'ap/vim-css-color'

" syntax checking
" ==> :help syntastic
Bundle 'Syntastic'

" multiple cursors
" ==> :help multiple-cursors
Bundle 'terryma/vim-multiple-cursors'

"}}}

" ===== display settings ===== {{{
colo railscasts       " color scheme
hi NonText term=NONE gui=NONE guifg=#555555
hi ColorColumn guibg=#333333
hi! link LineNr NonText
set visualbell        " flash instead of beeping
set ruler             " show cursor position
set showcmd           " display incomplete commands
set history=50        " 50 lines of command line history
set cmdheight=1       " command line is two lines tall
set laststatus=2      " always show a status line
set shortmess+=I      " disable the welcome screen
set colorcolumn=110   " show a vertical line at the 110 character mark
set listchars=tab:.\ ,trail:.,extends:>,precedes:<
"}}}

" ===== set default tab settings ===== {{{
set tabstop=2         " basic tab stop
set shiftwidth=2      " spaces per tab
set smarttab          " insert tabs as spaces
set expandtab         " replace tabs with spaces
set smartindent       " autoindent following lines
"}}}

" ===== autocommand setup ===== {{{
filetype off          " disable filetype detection
filetype indent on    " enable filetype-specific indenting
filetype plugin on    " enable filetype-specific plugins

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

autocmd FileType markdown set makeprg=pandoc\ %\ -o\ %:r.html\ -s
autocmd FileType markdown call EnableTextWrapMode()

autocmd FileType coldfusion,cfscript set nosmarttab
autocmd FileType coldfusion,cfscript set noexpandtab

" automatically fold comments in ruby
autocmd FileType ruby,eruby set foldmethod=expr | set foldexpr=getline(v:lnum)=~'^\\s*#' | exe "normal zM``"

"}}}

" ===== OS-dependent setup ===== {{{
" GUI only
if has("gui_running")
" To autodisplay NERDTree, enable the following two lines
  "autocmd VimEnter * NERDTree default
  "autocmd VimEnter * wincmd p
" To autodisplay Project, enable the following two lines
  "autocmd VimEnter * Project
  "autocmd VimEnter * wincmd p
  set guioptions=egm                " configure gui
endif

" Mac only
if has("gui_macvim")
  set gfn=M+\ 1m\ light:h13
  set lines=92          " gui window height
  set co=178            " gui window width
  set fuoptions=maxvert " configure fullscreen handling
  
  function! s:ToggleFullScreenMode()
   if &fullscreen
    let &gfn=g:old_font
    let &columns=g:old_columns
    let &lines=g:old_lines
    let &colorcolumn=g:old_colorcolumn
    let &linebreak=g:old_linebreak
    let &number=g:old_number
    set nofullscreen
   else
    let g:old_font=&gfn
    let g:old_columns=&columns
    let g:old_lines=&lines
    let g:old_colorcolumn=&colorcolumn
    let g:old_linebreak=&linebreak
    let g:old_number=&number
    if has("gui_macvim")
      set gfn=M+\ 1m\ light:h18
    endif
    if has("gui_win32")
      set gfn=Envy_Code_R:h14
    endif
    set co=110
    set colorcolumn=
    set linebreak
    set fullscreen
    set nonumber
   endif
  endfunction
  command! FullScreenToggle call s:ToggleFullScreenMode()
  nmap <silent> <F11> :FullScreenToggle<CR>
endif

" Windows only
if has("gui_win32")
  set gfn=Envy_Code_R:h10
  set lines=36          " gui window height
  set co=140            " gui window width
endif

" Linux only
if has("X11")
  set gfn=M+\ 1m\ Medium\ 12
  set lines=92          " gui window height
  set co=178            " gui window width
endif
"}}}

" ===== set up custom keyboard mappings ===== {{{

"nunmap <leader>fef
"unmap <leader>fc
"unmap <leader>hs

MapToggle <F2> number
MapToggle <F4> wrap
MapToggle <F3> hlsearch
nmap <silent> <F5> :ShowMarksToggle<CR>

nmap <silent> <leader>f :BuffergatorClose<CR>:NERDTreeToggle<CR>
nmap <silent> <leader>b :NERDTreeClose<CR>:BuffergatorToggle<CR>

" my alternates to CTRL-W (which is too hard to type) :-)
map <leader>j :winc j<CR>
map <leader>k :winc k<CR>
map <leader>h :winc h<CR>
map <leader>l :winc l<CR>

"}}}

" vim:fdm=marker:ft=vim
