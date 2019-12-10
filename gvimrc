" for more information see :help nbf

" ---[ Setup ]--- {{{
function! ToggleMenu()
  if &go=~#'m'
    set go-=m
  else
    set go+=m
  endif
endfunction
command! ToggleMenu call ToggleMenu()
"}}}

" ---[ Visual Options ]--- {{{
set guioptions=eg

if g:os == 'Windows'
  set gfn=Hack:h11:cANSI:qDRAFT

  if &columns < 120
    set columns=120
  endif

  if &lines < 40
    set lines=40
  endif
endif

if g:os == 'Darwin'
  set gfn=Hack-Regular:h13

  if &columns < 120
    set columns=120
  endif

  if &lines < 40
    set lines=40
  endif
endif
" }}}

" ---[ Keyboard Mapping ]--- {{{
" \m to toggle the GUI's menu bar

nmap <silent> <leader>m :ToggleMenu<CR>
" }}}

" ---[ Menu Tweaks ]--- {{{
anoremenu 9999.5 &Help.&NF\ Notes<Tab><F1> :help nfnotes<CR>
aunmenu &Help.&Overview<Tab><F1>
anoremenu 9999.10 &Help.&Overview :help<CR>

" }}}

" vim:fdm=marker:ft=vim
