
nnoremap <C-w>m<Esc> :call window_mode#end()<CR>
nnoremap <C-w>m :call window_mode#handle()<CR>
command! WindowMode :call window_mode#handle()
command! WindowModeEnd :call window_mode#end()

let s:window_mode_enabled = 0
let s:window_mode_last_update = 0


" Main loop of the Window Mode, waits for input characters and feeds them to
" VIM with the <C-w> prefix
function! window_mode#handle()
  let s:window_mode_enabled = 1
  let s:window_mode_last_update = strftime('%s')

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

  " Store numeric characters as repeat counts
  while l:char >= 48 && l:char <= 57
    let l:repetitions = l:repetitions . nr2char(l:char)
    let l:char = getchar()
  endwhile

  let l:command = "\<C-w>" . nr2char(l:char)
  call feedkeys("\<C-w>m")
  silent exec 'normal ' . l:repetitions . l:command
endfunction


" Callback function called when the escape character is pressed, or when the
" end of Window Mode is detected
function! window_mode#end()
  let s:window_mode_enabled = 0

  if exists('#lightline')
    call lightline#update()
  endif

  echo
endfunction


" Checks if the Window Mode is currently enabled
function! window_mode#isEnabled()
  if !s:window_mode_enabled
    return 0
  endif
  
  " If the handle function has not been called for more than 5 seconds,
  " consider window mode ended (enabled can be left at 1 when exiting the mode
  " with Ctrl-C)
  if strftime('%s') - s:window_mode_last_update > 5
    let s:window_mode_enabled = 0
    return 0
  endif

  return 1
endfunction


" Helper function for integrating with the Lightline plugin, can be used for
" defining components in the g:lightline variable
function! window_mode#lightlineComponent()
  return window_mode#isEnabled() ? 'WINDOW' : ''
endfunction
