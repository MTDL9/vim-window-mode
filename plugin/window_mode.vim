
nnoremap <C-w>m<Esc> <Nop>
nnoremap <C-w>m :call window_mode#handle()<cr>

function! window_mode#handle()
  let l:char=''
  if getchar(1)
    let l:char = getchar()
  endif

  let l:command = "\<C-W>" . nr2char(l:char)
  call feedkeys("\<C-W>m")
  silent exec 'normal! ' . l:command
endfunction
