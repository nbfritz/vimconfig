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

" vim:fdm=marker:ft=vim
