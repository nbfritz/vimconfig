" for more information see :help nbf

" ---[ Visual Options ]--- {{{
set guioptions=eg

if g:os == 'Windows'
  set gfn=Source_Code_Variable:h12:cANSI
  
  if &columns < 120
    set columns=120
  endif

  if &lines < 40
    set lines=40
  endif
endif
" }}}

" vim:fdm=marker:ft=vim
