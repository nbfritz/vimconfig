" Remember, [zo] to open a fold. [zc] to close it. [zR] to open them all. [zM] to close them all.

" ===== OS Detection Code ===== {{{
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

" }}}

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

function! s:WritingMode()
  Goyo
  SoftPencil
  Limelight0.6
endfunction
command! Write call s:WritingMode()

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

" automatic insertion of end statements
Plugin 'tpope/vim-endwise'

" extended . repeat command (now works with more plugins)
Plugin 'tpope/vim-repeat'

" filesystem browser
" ==> :help nerdtree
let g:NERDTreeShowBookmarks=1
let g:NERDTreeChDirMode=2
let g:NERDTreeWinSize=45
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeWinPos="right"
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
let g:buffergator_split_size=45
let g:buffergator_viewport_split_policy="R"
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

" git integration for vim
" ==> :help fugitive
Plugin 'tpope/vim-fugitive'

" svn (and others) integration for vim
" ==> :help vcscommand
Plugin 'vcscommand.vim'

" autocompletion
" ==> :help neocomplcache
Plugin 'neocomplcache'

" color schemes
Plugin 'jgdavey/vim-railscasts'
Plugin 'tpope/vim-vividchalk'

" beautiful status lines
" ==> :help airline
let g:airline_left_sep=''
let g:airline_right_sep=''
Plugin 'bling/vim-airline'

" coldfusion support
Plugin 'https://github.com/davejlong/cf-utils.vim'

" css coloring
Plugin 'ap/vim-css-color'

" syntax checking
" ==> :help syntastic
"let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_javascript_checkers=[]
Plugin 'Syntastic'

" bundler support
" ==> :help bundler
Plugin 'tpope/vim-bundler'

" ack support
" ==> :help ack
let g:ackprg = 'ag --nogroup --nocolor --column --follow --smart-case --ignore coverage --ignore log --ignore vcr_cassettes'
Plugin 'mileszs/ack.vim'

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

" marks management
let g:gmarks_names = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
let g:markology_enable = 0
Plugin 'jeetsukumaran/vim-markology'

" dynamic font zooming
Plugin 'fontsize'

" word processing support
Plugin 'reedes/vim-pencil'
Plugin 'junegunn/limelight.vim'
Plugin 'junegunn/goyo.vim'

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

autocmd FileType coldfusion,cfscript,cfml set nosmarttab | set expandtab | set indentexpr=

" automatically fold comments in ruby
autocmd FileType ruby,eruby set foldmethod=expr | set foldexpr=getline(v:lnum)=~'^\\s*#' | exe "normal zM``"

autocmd FileType crontab setlocal nobackup nowritebackup

"}}}

" ===== OS-dependent setup ===== {{{

" Mac only
if g:this_os == "mac gui"
  set popt=left:2pc,right:5pc,top:5pc,bottom:5pc,number:y,portrait:y,paper:tabloid
  set pfn=Source\ Code\ Pro:h7
  set gfn=Source\ Code\ Pro:h12
  set lines=92
  set columns=222
endif

" Windows only
if g:this_os == "windows gui"
  set gfn=Envy_Code_R:h10:cANSI
  set lines=30
  set columns=120
  let g:ruby_path = ":C:\dev\ruby200\bin"
endif

" Linux only
if g:this_os == "linux gui"
  set gfn=Source\ Code\ Pro\ 13
  set lines=30
  set columns=120
endif
"}}}

" ===== set up custom keyboard mappings ===== {{{

MapToggle <F2> number
MapToggle <F3> hlsearch
MapToggle <F4> wrap
nmap <F9> <Plug>MarkologyToggle

nmap <silent> <leader>f :BuffergatorClose<CR>:NERDTreeToggle<CR>
nmap <silent> <leader>b :NERDTreeClose<CR>:BuffergatorToggle<CR>
nmap <leader>r :MRU<CR>
nmap <leader>M <Plug>MarkologyLocationList
nmap <leader>m <Plug>MarkologyQuickFix

" my alternates to CTRL-W (which is too hard to type) :-)
map <leader>j :winc j<CR>
map <leader>k :winc k<CR>
map <leader>h :winc h<CR>
map <leader>l :winc l<CR>
"}}}

" vim:fdm=marker:ft=vim
