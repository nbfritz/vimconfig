" Remember, [zo] to open a fold. [zc] to close it. [zR] to open them all. [zM] to close them all.

" ===== Functions ===== {{{
function! MapToggle(key, opt)
 let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
 exec 'nnoremap '.a:key.' '.cmd
 exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)
"}}}

" ===== general settings ===== {{{
set nocompatible      " run in VIM rather than VI mode
set cryptmethod=blowfish          " when starting with -x encrypt using blowfish

" load in preset configuration for MS windows
source $VIMRUNTIME/mswin.vim
behave mswin

" enable backspacing over everything in insert mode
set backspace=indent,eol,start

set undodir=~/.vim/tmp/undo//     " locate undo files
set backupdir=~/.vim/tmp/backup// " locate backups
set directory=~/.vim/tmp/swap//   " locate swap files
set noswapfile                    " no swap files 
set backup                        " enable backup versions
set mouse=a                       " enable mouse
syntax on                         " enable syntax highlighting
set guioptions=egmrL              " configure gui
set hlsearch                      " enable highlighted searching
"}}}

" ===== bundle configuration ===== {{{
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" bundle management
Bundle 'gmarik/vundle'

" functions used by other plugins
Bundle "L9"

" align on separator characters
let g:DrChipTopLvlMenu="Plugin."
Bundle 'tsaleh/vim-align'

" automatic insertion of end statements
Bundle 'tpope/vim-endwise'

" extended . repeat command
Bundle 'tpope/vim-repeat'

" increment and decrement dates w/ C-x and C-a
Bundle 'tpope/vim-speeddating'

" mass changing of wrapping tags and characters
Bundle 'tpope/vim-surround'

" a set of very handy pairs of actions like encodings, line shifts, etc.
Bundle 'tpope/vim-unimpaired'

" filesystem browser
Bundle 'scrooloose/nerdtree' 

" support for user-defined text objects
Bundle 'kana/vim-textobj-user'

" more sophisticated copy and paste system with numbered registers
Bundle 'vim-scripts/YankRing.vim'

" extension to the % matcher to work with more than single characters
Bundle 'mirell/vim-matchit'

" awesome search tool mapped to C-p
Bundle 'kien/ctrlp.vim'

" scratch buffers with :Scratch
Bundle 'vim-scripts/scratch.vim'

" nifty commenting commands
Bundle 'scrooloose/nerdcommenter' 

" easy buffer switching
Bundle 'vim-scripts/bufexplorer.zip'

" ruby extensions
Bundle 'vim-ruby/vim-ruby'

" ruby on rails extensions
Bundle 'tpope/vim-rails'

" text matcher for selecting ruby blocks with ar and ir
Bundle 'nelstrom/vim-textobj-rubyblock'

" easy refactoring in ruby
Bundle 'ecomba/vim-ruby-refactoring'

" tag browser for navigating through functions/variables/etc. in a script
Bundle 'majutsushi/tagbar'

" git integration for vim
Bundle 'tpope/vim-fugitive' 

" autocompletion
Bundle 'neocomplcache'

" use tab for completion in visual mode
Bundle 'SuperTab-continued.'

" railscasts color scheme
Bundle 'railscasts'

" plugin to interpret and reference indentation levels (with ai, ii, aI, and iI)
Bundle 'michaeljsmith/vim-indent-object'
let g:indentobject_meaningful_indentation = ["haml", "sass", "python", "yaml", "markdown"]

" beautiful status lines
Bundle 'Lokaltog/vim-powerline'

"}}}

" ===== display settings ===== {{{
colo railscasts           " color scheme
" set font in gui mode
set gfn=Envy_Code_R:h10:cANSI

set lines=50          " gui window height
set co=104            " gui window width
set visualbell        " flash instead of beeping
set ruler             " show cursor position
set showcmd           " display incomplete commands
set history=50        " 50 lines of command line history
set cmdheight=1       " command line is two lines tall
set laststatus=2      " always show a status line
"}}}

" ===== set default tab settings ===== {{{
set tabstop=2			    " basic tab stop
set shiftwidth=2		  " spaces per tab
set smarttab			    " insert tabs as spaces
set expandtab			    " replace tabs with spaces
set smartindent			  " autoindent following lines
"}}}

" ===== autocommand setup ===== {{{
filetype off          " disable filetype detection
filetype indent on    " enable filetype-specific indenting
filetype plugin on    " enable filetype-specific plugins

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"}}}

" ===== set up custom keyboard mappings ===== {{{
let mapleader = ','

MapToggle <F1> number
MapToggle <F3> hlsearch
map <F2> :syntax on<cr>


nmap <silent> <F10> :BufExplorer<CR>
nmap <silent> <F11> :TagbarToggle<CR>
nmap <silent> <F12> :NERDTreeToggle<CR>
nnoremap <leader>a :Ack!<space>
nmap <leader>y :YRShow<cr>
nmap <silent> <F4> :call NERDComment(0, "invert")<cr>
nmap <silent> <F5> :Hammer<cr>

" my alternates to  which is too hard to type :-)
map <leader>j :winc j<CR>
map <leader>k :winc k<CR>
map <leader>h :winc h<CR>
map <leader>l :winc l<CR>
map <leader>s :winc s<CR>

" edit this file
map <leader>- :sp ~\.vim\.vimrc
map <leader>_ :source ~\.vim\.vimrc
map <leader>= :sp ~\.vim
"}}}

" vim:fdm=marker:ft=vim
