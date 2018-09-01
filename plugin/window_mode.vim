
nnoremap <C-w>m<Esc> :call window_mode#end()<CR>
nnoremap <C-w>m :call window_mode#handle()<CR>
command! WindowMode :call window_mode#handle()
command! WindowModeEnd :call window_mode#end()

let g:window_mode_enabled = 0

function! window_mode#handle()
  let g:window_mode_enabled = 1
  if &showmode
      echohl ModeMsg
      echo '-- WINDOW --'
      echohl None
  else
      echo ''
  endif

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
  silent exec 'normal ' . l:repetitions . l:command
endfunction

function! window_mode#end()
  let g:window_mode_enabled = 0
  echo
endfunction
