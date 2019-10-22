" Remember, [zo] to open a fold. [zc] to close it. [zR] to open them all. [zM] to close them all.

" ===== OS Detection Code ===== {{{

if !exists("g:os")
  if has("win64") || has("win32") || has("win16")
    let g:os = "Windows"
  else
    let g:os = substitute(system('uname'), '\n', '', '')
  endif
endif

" Windows only
if g:os == "Windows"
  set backupdir=$HOME/.vim/tmp/backup/ " locate backups
  set undodir=$HOME/.vim/tmp/undo/     " locate undo files
  set directory=$HOME/.vim/tmp/swap/   " locate swap files
endif

" Linux only
if g:os == "Linux"
endif

" Mac only
if g:os == "Darwin"
endif

" }}}

" ===== Functions ===== {{{

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

command! -bar TidyJQ :%!jq . %

command! -bar Write call pencil#init()
                \ | call lexical#init()
                \ | Goyo 80x80%
                \ | Limelight

command! -nargs=* Ag :Ack <args>

"}}}

" ===== plugin configuration ===== {{{

silent! call plug#begin()

" color schemes
"Plug 'jgdavey/vim-railscasts'
Plug 'morhetz/gruvbox'

" beautiful status lines
" ==> :help airline
let g:airline_left_sep=''
let g:airline_right_sep=''
Plug 'bling/vim-airline'

" automatic insertion of end statements
Plug 'tpope/vim-endwise'

" filesystem browser
" ==> :help nerdtree
let g:NERDTreeShowBookmarks=1
let g:NERDTreeChDirMode=2
let g:NERDTreeWinSize=45
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeWinPos="right"
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" awesome search tool mapped to C-p
" ==> :help ctrlp
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\.class$'
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_cmd = 'CtrlP getcwd()'
let g:ctrlp_map = '<c-p>'
Plug 'ctrlpvim/ctrlp.vim'

" nifty commenting commands
" ==> :help nerdcommenter
Plug 'scrooloose/nerdcommenter'

" ruby extensions
" ==> :help vim-ruby
Plug 'vim-ruby/vim-ruby'

" rake support
" ==> :help rake
Plug 'tpope/vim-rake'

" ruby on rails extensions
" ==> :help rails
Plug 'tpope/vim-rails'

" git integration for vim
" ==> :help fugitive
Plug 'tpope/vim-fugitive'

" coldfusion support
Plug 'https://github.com/davejlong/cf-utils.vim'

" css coloring
Plug 'ap/vim-css-color'

" bundler support
" ==> :help bundler
Plug 'tpope/vim-bundler'

" ack support
" ==> :help ack
let g:ackprg = 'ag --nogroup --nocolor --column --follow --smart-case --ignore coverage --ignore log --ignore vcr_cassettes'
Plug 'mileszs/ack.vim', { 'on': 'Ack' }

" most recently used (MRU) file list
" => :help MRU
let MRU_Max_Entries = 50
Plug 'yegappan/mru'

" emmet html/css accellerators
" ==> :help emmet
let g:user_emmet_leader_key = '<c-e>'
Plug 'mattn/emmet-vim'

" dynamic font zooming
" ==> :help fontsize
Plug 'drmikehenry/vim-fontsize'

" mustache templating
Plug 'mustache/vim-mustache-handlebars'

" elixir handling
Plug 'elixir-editors/vim-elixir'

" json schema handling
" => help Vison
Plug 'quramy/vison'

" vim for writers
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-lexical'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'

call plug#end()
""}}}

" ===== general settings ===== {{{
set nocompatible      " run in VIM rather than VI mode
set encoding=utf8
set number

" load in preset configuration for MS windows
source $VIMRUNTIME/mswin.vim
behave mswin

" enable backspacing over everything in insert mode
set backspace=indent,eol,start

set noswapfile                    " no swap files
set backup                        " enable backup versions
set mouse=a                       " enable mouse

set splitbelow                    " open new splits below
set splitright                    " open new vsplits to the right

syntax on                         " enable syntax highlighting
set hlsearch                      " enable highlighted searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " unless an upper case character is sought

if has('cryptv')
  set cryptmethod=blowfish
endif
"}}}

" ===== display settings ===== {{{
set background=dark
colo gruvbox

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

" ===== set up custom keyboard mappings ===== {{{
" (http://vim.wikia.com/wiki/Quick_generic_option_toggling)
function MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)

MapToggle <F2> number
MapToggle <F3> hlsearch
MapToggle <F4> wrap

nmap <silent> <leader>f :NERDTreeToggle<CR>
nmap <leader>r :MRU<CR>
"}}}
"
" ===== autocommand setup ===== {{{
filetype off          " disable filetype detection
filetype indent on    " enable filetype-specific indenting
filetype plugin on    " enable filetype-specific plugins

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

autocmd FileType coldfusion,cfscript,cfml set nosmarttab | set expandtab | set indentexpr=

autocmd FileType markdown set textwidth=80 | set nowrap

" automatically fold comments in ruby
autocmd FileType ruby,eruby set foldmethod=expr | set foldexpr=getline(v:lnum)=~'^\\s*#' | exe "normal zM``"
"}}}

" vim:fdm=marker:ft=vim
