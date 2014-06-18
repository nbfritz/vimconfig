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

command! -bar SettingsEdit :split|vi $MYVIMRC
command! -bar SettingsReload :source $MYVIMRC
command! -bar NotesEdit :vi +set\ modifiable ~/.vim/doc/nfnotes.txt
command! -bar NotesReload :helptags ~/.vim/doc
command! -bar Notes :help nfnotes

command! -bar StripCarriageReturns :%s/\r//ge
command! -bar StripTrailingSpaces :%s/\s\+$//ge
command! -bar StripTabTo2Spaces :%s/\t/  /ge
command! -bar StripTabTo4Spaces :%s/\t/    /ge
command! -bar StripAll :StripCarriageReturns|StripTrailingSpaces|StripTabTo2Spaces

command! -nargs=* Ag :Ack <args>

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

set splitbelow                    " open new splits below
set splitright                    " open new vsplits to the right

syntax on                         " enable syntax highlighting
set hlsearch                      " enable highlighted searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " unless an upper case character is sought

let mapleader = ','               " a bunch of keyboard commands use the leader character...

if has('cryptv') 
  set cryptmethod=blowfish
endif
"}}}

" ===== bundle configuration ===== {{{

" bundle management
" ==> :help Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'gmarik/vundle'

" functions used by other plugins
Plugin 'L9'

" align on separator characters
" ==> :help align
let g:DrChipTopLvlMenu="Plugin."
Plugin 'tsaleh/vim-align'

" automatic insertion of end statements
Plugin 'tpope/vim-endwise'

" extended . repeat command (now works with more plugins)
Plugin 'tpope/vim-repeat'

" mass changing of wrapping tags and characters
" ==> :help surround
Plugin 'tpope/vim-surround'

" a set of very handy pairs of actions like encodings, line shifts, etc.
" ==> :help unimpaired
Plugin 'tpope/vim-unimpaired'

" filesystem browser
" ==> :help nerdtree
let g:NERDTreeShowBookmarks=1
let g:NERDTreeChDirMode=2
let g:NERDTreeWinSize=40
let g:NERDTreeQuitOnOpen=1
Plugin 'scrooloose/nerdtree' 

" extension to the % matcher to work with more than single characters
" ==> :help matchit
Plugin 'edsono/vim-matchit'

" awesome search tool mapped to C-p
" ==> :help ctrlp
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\.class$'
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_cmd = 'CtrlP getcwd()'
Plugin 'kien/ctrlp.vim'

" nifty commenting commands
" ==> :help nerdcommenter
Plugin 'scrooloose/nerdcommenter' 

" buffer switching
" ==> :help buffergator
let g:buffergator_autoexpand_on_split=0
let g:buffergator_suppress_keymaps=1
let g:buffergator_sort_regime="mru"
Plugin 'Buffergator'

" ruby extensions
" ==> :help vim-ruby
Plugin 'vim-ruby/vim-ruby'

" rake support
" ==> :help rake
Plugin 'tpope/vim-rake'

" ruby on rails extensions
" ==> :help rails
Plugin 'tpope/vim-rails'

" tag browser for navigating through functions/variables/etc. in a script
" ==> :help tagbar
Plugin 'majutsushi/tagbar'

" git integration for vim
" ==> :help fugitive
Plugin 'tpope/vim-fugitive' 

" svn (and others) integration for vim
" ==> :help vcscommand
Plugin 'vcscommand.vim'

" autocompletion
" ==> :help neocomplcache
Plugin 'neocomplcache'

" use tab for completion in visual mode
" ==> :help supertab 
let g:tagbar_left = 1
let g:tagbar_width = 40
Plugin 'ervandew/supertab'

" color schemes
"Plugin 'railscasts'
Plugin 'jgdavey/vim-railscasts'
Plugin 'tpope/vim-vividchalk'

" markdown support
Plugin 'plasticboy/vim-markdown'
Plugin 'mkitt/markdown-preview.vim'

" plugin to interpret and reference indentation levels (with ai, ii, aI, and iI)
" ==> :help indent-object
let g:indentobject_meaningful_indentation = ["haml", "sass", "python", "yaml", "markdown"]
Plugin 'michaeljsmith/vim-indent-object'

" beautiful status lines
" ==> :help powerline
let g:Powerline_symbols = 'compatible'
Plugin 'Lokaltog/vim-powerline'

" coldfusion support
Plugin 'https://github.com/davejlong/cf-utils.vim'

" css coloring
Plugin 'ap/vim-css-color'

" syntax checking
" ==> :help syntastic
let g:syntastic_javascript_checkers=['jshint']
Plugin 'Syntastic'

" bundler support
" ==> :help bundler
Plugin 'tpope/vim-bundler'

" ack support
" ==> :help ack
let g:ackprg = 'ag --nogroup --nocolor --column --follow --smart-case'
Plugin 'mileszs/ack.vim'

" dispatch to terminal
" ==> :help dispatch
Plugin 'tpope/vim-dispatch'

" open files as sudo
Plugin 'sudo.vim'

" most recently used (MRU) file list
let MRU_Max_Entries = 30
Plugin 'yegappan/mru'

" emmet html/css accellerators
" ==> :help emmet
let g:user_emmet_leader_key = '<c-e>'
Plugin 'mattn/emmet-vim'

" coffeescript support
Plugin 'kchmck/vim-coffee-script'


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
set colorcolumn=100   " show a vertical line at the 120 character mark
set list              " show hidden characters
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

autocmd FileType markdown map <F5> :MDP<CR>

autocmd FileType coldfusion,cfscript,cfml set nosmarttab | set expandtab 

" automatically fold comments in ruby
autocmd FileType ruby,eruby set foldmethod=expr | set foldexpr=getline(v:lnum)=~'^\\s*#' | exe "normal zM``"

"}}}

" ===== OS-dependent setup ===== {{{

let g:this_os = ""

if has("gui_macvim")
  let g:this_os .= "mac "
elseif has("win32")
  let g:this_os .= "windows "
elseif has("X11")
  let g:this_os .= "linux "
end

if has("gui_running")
  let g:this_os .= "gui"
  set guioptions=egm
else
  let g:this_os .= "term"
endif

" Mac only
if g:this_os == "mac gui"
  set gfn=M+\ 1m\ light:h13
  set lines=73
  set co=222
endif

" Windows only
if g:this_os == "windows gui"
  set gfn=Envy_Code_R:h10
  set lines=30
  set co=120
endif

" Linux only
if g:this_os == "linux gui"
  set gfn=M+\ 1m\ Medium\ 12
  set lines=30
  set co=120
endif
"}}}

" ===== set up custom keyboard mappings ===== {{{

"nunmap <leader>fef
"unmap <leader>fc
"unmap <leader>hs

MapToggle <F2> number
MapToggle <F4> wrap
MapToggle <F3> hlsearch
nmap <silent> <F9> :ShowMarksToggle<CR>

nmap <silent> <leader>f :BuffergatorClose<CR>:TagbarClose<CR>:NERDTreeToggle<CR>
nmap <silent> <leader>b :NERDTreeClose<CR>:TagbarClose<CR>:BuffergatorToggle<CR>
nmap <silent> <leader>e :NERDTreeClose<CR>:BuffergatorClose<CR>:TagbarToggle<CR>
nmap <silent> <leader>r :MRU<CR>
nmap <silent> <leader>m :marks<CR>

" my alternates to CTRL-W (which is too hard to type) :-)
map <leader>j :winc j<CR>
map <leader>k :winc k<CR>
map <leader>h :winc h<CR>
map <leader>l :winc l<CR>

" map jk as an alternative to <ESC> for leaving typing mode
imap jk <ESC>
"}}}

" vim:fdm=marker:ft=vim
