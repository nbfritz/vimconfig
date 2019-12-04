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
  set gfn=Source_Code_Variable:h12:cANSI
  
  if &columns < 120
    set columns=120
  endif

  if &lines < 40
    set lines=40
  endif
endif
" }}}

" ---[ Keyboard Mapping ]--- {{{
" \\m to toggle the GUI's menu bar

nmap <silent> <leader><leader>m :ToggleMenu<CR>
" }}}

" vim:fdm=marker:ft=vim
