
nnoremap <C-w>m<Esc> <Nop>
nnoremap <C-w>m :call window_mode#handle()<cr>

function! window_mode#handle()
  let l:char = ''
  let l:repetitions = ''

  if getchar(1)
    let l:char = getchar()
  endif

  while l:char >= 48 && l:char <= 57
    let l:repetitions = l:repetitions . nr2char(l:char)
    let l:char = getchar()
  endwhile

  let l:command = "\<C-W>" . nr2char(l:char)
  call feedkeys("\<C-W>m")
  silent exec 'normal! ' . l:repetitions . l:command
endfunction
