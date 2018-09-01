
nnoremap <C-w>m<Esc> :call window_mode#end()<CR>
nnoremap <C-w>m :call window_mode#handle()<CR>
command! WindowMode :call window_mode#handle()
command! WindowModeEnd :call window_mode#end()

let g:window_mode_enabled = 0
let g:window_mode_last_update = 0


function! window_mode#handle()
  let g:window_mode_enabled = 1
  let g:window_mode_last_update = strftime('%s')

  if &showmode
      echohl ModeMsg
      echo '-- WINDOW --'
      echohl None
  else
      echo ''
  endif

  if exists('#lightline')
    call lightline#update()
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

  if exists('#lightline')
    call lightline#update()
  endif

  echo
endfunction


" Helper function for defining components in the g:lightline variable, for
" integrating with the Lightline plugin
function! window_mode#lightlineComponent()
  if !g:window_mode_enabled
    return ''
  endif
  
  " If the handle function has not been called for more than 5 seconds,
  " consider window mode ended (enabled can be left at 1 when exiting the mode
  " with Ctrl-C)
  if strftime('%s') - g:window_mode_last_update > 5
    let g:window_mode_enabled = 0
    return ''
  endif

  return 'WINDOW'
endfunction
