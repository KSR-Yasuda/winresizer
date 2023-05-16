"---------------------------------------------------
" WinResizer 
"---------------------------------------------------
" This is simple plugin to resize/move windows
" for someone using vim with split windows  
"
" ========================================
" start 'resize mode' key
" <C-E> or g:winresizer_start_key defined by .vimrc
"
" If you don't need this function,
" define global variable below in .vimrc
"
" let g:winresizer_enable
"
" keymap of [window resize mode]
" h : expand window size to left
" j : expand window size to down
" k : expand window size to up
" l : expand window size to right
" e : switch to move mode
" f : change to focus mode
" m : change to move mode
" q : cancel resize window and escape [window resize mode]
" Enter : fix and escape 
"
" keymap of [window move mode]
" h : move window left
" j : move window down
" k : move window up
" l : move window right
" e : switch to focus mode
" f : change to focus mode
" r : change to resize mode
" q : cancel move window and escape [window move mode]
" Enter : fix and escape 
"
" keymap of [window focus mode]
" h : move focus to left window
" j : move focus to window below
" k : move focus to window above
" l : move focus to right window
" e : switch to resize mode
" r : change to resize mode
" m : change to move mode
" q : cancel move window and escape [window focus mode]
" Enter : fix and change to resize mode 

if exists("g:loaded_winresizer")
  finish
endif

let g:loaded_winresizer = 1

let s:save_cpo = &cpo
set cpo&vim

" default start resize window key mapping
let s:default_start_key = '<C-E>'

" If you define 'g:win_resizer_start_key' in .vimrc, 
" will be started resize window by 'g:win_resizer_start_key' 
let g:winresizer_start_key  = get(g:, 'winresizer_start_key', s:default_start_key)
let g:winresizer_enable     = get(g:, 'winresizer_enable', 1)

" for gui setting
let s:default_gui_start_key = '<C-A>'
let g:winresizer_gui_start_key = get(g:, 'winresizer_gui_start_key', s:default_gui_start_key)
let g:winresizer_gui_enable = get(g:, 'winresizer_gui_enable', 0)

let g:winresizer_vert_resize  = get(g:, 'winresizer_vert_resize', 10)
let g:winresizer_horiz_resize = get(g:, 'winresizer_horiz_resize', 3)

" resize mode key mapping
let s:default_keycode = {
             \           'move'   : '109',
             \           'focus'  : '102',
             \           'resize' : '114',
             \           'left'   : '104',
             \           'down'   : '106',
             \           'up'     : '107',
             \           'right'  : '108',
             \           'hfull'  : '95',
             \           'vfull'  : '124',
             \           'sizeeq' : '61',
             \           'split'  : '115',
             \           'vsplit' : '118',
             \           'close'  : '67',
             \           'tabl'   : '74',
             \           'tabr'   : '75',
             \           'flast'  : '36',
             \           'fnext'  : '119',
             \           'fprev'  : '87',
             \           'finish' : '13',
             \           'cancel' : '113',
             \           'enter'  : '13',
             \           'escape' : '27',
             \           'mode'   : '101',
             \          }

let g:winresizer_keycode_focus  = get(g:, 'winresizer_keycode_focus',  s:default_keycode['focus'])
let g:winresizer_keycode_move   = get(g:, 'winresizer_keycode_move',   s:default_keycode['move'])
let g:winresizer_keycode_resize = get(g:, 'winresizer_keycode_resize', s:default_keycode['resize'])
let g:winresizer_keycode_left   = get(g:, 'winresizer_keycode_left',   s:default_keycode['left'])
let g:winresizer_keycode_down   = get(g:, 'winresizer_keycode_down',   s:default_keycode['down'])
let g:winresizer_keycode_up     = get(g:, 'winresizer_keycode_up',     s:default_keycode['up'])
let g:winresizer_keycode_right  = get(g:, 'winresizer_keycode_right',  s:default_keycode['right'])

let g:winresizer_keycode_hfull  = get(g:, 'winresizer_keycode_hfull',  s:default_keycode['hfull'])
let g:winresizer_keycode_vfull  = get(g:, 'winresizer_keycode_vfull',  s:default_keycode['vfull'])
let g:winresizer_keycode_sizeeq = get(g:, 'winresizer_keycode_sizeeq', s:default_keycode['sizeeq'])

let g:winresizer_keycode_split  = get(g:, 'winresizer_keycode_split',  s:default_keycode['split'])
let g:winresizer_keycode_vsplit = get(g:, 'winresizer_keycode_vsplit', s:default_keycode['vsplit'])
let g:winresizer_keycode_close  = get(g:, 'winresizer_keycode_close',  s:default_keycode['close'])

let g:winresizer_keycode_tabl   = get(g:, 'winresizer_keycode_tabl',   s:default_keycode['tabl'])
let g:winresizer_keycode_tabr   = get(g:, 'winresizer_keycode_tabr',   s:default_keycode['tabr'])

let g:winresizer_keycode_flast  = get(g:, 'winresizer_keycode_flast',  s:default_keycode['flast'])
let g:winresizer_keycode_fnext  = get(g:, 'winresizer_keycode_fnext',  s:default_keycode['fnext'])
let g:winresizer_keycode_fprev  = get(g:, 'winresizer_keycode_fprev',  s:default_keycode['fprev'])

let g:winresizer_keycode_finish = get(g:, 'winresizer_keycode_finish', s:default_keycode['finish'])
let g:winresizer_keycode_cancel = get(g:, 'winresizer_keycode_cancel', s:default_keycode['cancel'])
let g:winresizer_keycode_escape = get(g:, 'winresizer_keycode_escape', s:default_keycode['escape'])
let g:winresizer_keycode_enter  = get(g:, 'winresizer_keycode_enter',  s:default_keycode['enter'])
let g:winresizer_keycode_mode   = get(g:, 'winresizer_keycode_mode',   s:default_keycode['mode'])

" if <ESC> key downed, finish resize mode
let g:winresizer_finish_with_escape = get(g:, 'winresizer_finish_with_escape', 1)

let s:codeList = {
        \  'left'   : g:winresizer_keycode_left,
        \  'down'   : g:winresizer_keycode_down,
        \  'up'     : g:winresizer_keycode_up,
        \  'right'  : g:winresizer_keycode_right,
        \  'hfull'  : g:winresizer_keycode_hfull,
        \  'vfull'  : g:winresizer_keycode_vfull,
        \  'sizeeq' : g:winresizer_keycode_sizeeq,
        \  'split'  : g:winresizer_keycode_split,
        \  'vsplit' : g:winresizer_keycode_vsplit,
        \  'close'  : g:winresizer_keycode_close,
        \  'tabl'   : g:winresizer_keycode_tabl,
        \  'tabr'   : g:winresizer_keycode_tabr,
        \  'flast'  : g:winresizer_keycode_flast,
        \  'fnext'  : g:winresizer_keycode_fnext,
        \  'fprev'  : g:winresizer_keycode_fprev,
        \  'focus'  : g:winresizer_keycode_focus,
        \  'move'   : g:winresizer_keycode_move,
        \  'resize' : g:winresizer_keycode_resize,
        \  'enter'  : g:winresizer_keycode_enter,
        \  'mode'   : g:winresizer_keycode_mode,
        \  'num0'   : '48',
        \  'num1'   : '49',
        \  'num2'   : '50',
        \  'num3'   : '51',
        \  'num4'   : '52',
        \  'num5'   : '53',
        \  'num6'   : '54',
        \  'num7'   : '55',
        \  'num8'   : '56',
        \  'num9'   : '57',
        \}

exe 'nnoremap ' . g:winresizer_start_key .' :WinResizerStartResize<CR>'

com! WinResizerStartResize call s:startResize(s:tuiResizeCommands())
com! WinResizerStartMove call s:startResize(s:moveCommands())
com! WinResizerStartFocus call s:startResize(s:focusCommands())

if has("gui_running") && g:winresizer_gui_enable != 0
  exe 'nnoremap ' . g:winresizer_gui_start_key .' :WinResizerStartResizeGUI<CR>'
  com! WinResizerStartResizeGUI call s:startResize(s:guiResizeCommands())
endif

fun! s:guiResizeCommands()

  let commands = {
      \  'mode'   : "resize",
      \  'left'   : 'let &columns = &columns - ' . g:winresizer_vert_resize,
      \  'right'  : 'let &columns = &columns + ' . g:winresizer_vert_resize,
      \  'up'     : 'let &lines = &lines - ' . g:winresizer_horiz_resize,
      \  'down'   : 'let &lines = &lines + ' . g:winresizer_horiz_resize,
      \  'hfull'  : 'resize',
      \  'vfull'  : 'vert resize',
      \  'sizeeq' : 'wincmd =',
      \  'close'  : 'call winresizer#winClose()',
      \  'tabl'   : 'call winresizer#tabNext(-1)',
      \  'tabr'   : 'call winresizer#tabNext(+1)',
      \  'cancel' : 'let &columns = ' . &columns . '|let &lines = ' . &lines . '|',
      \}

  return commands

endfun

fun! s:tuiResizeCommands()

  let behavior = s:getResizeBehavior()

  let commands = {
        \  'mode'   : "resize",
        \  'left'   : ':vertical resize ' . behavior['left']  . g:winresizer_vert_resize,
        \  'right'  : ':vertical resize ' . behavior['right'] . g:winresizer_vert_resize,
        \  'up'     : ':resize ' . behavior['up']   . g:winresizer_horiz_resize,
        \  'down'   : ':resize ' . behavior['down'] . g:winresizer_horiz_resize,
        \  'hfull'  : ':resize',
        \  'vfull'  : ':vert resize',
        \  'sizeeq' : ':wincmd =',
        \  'close'  : ':call winresizer#winClose()',
        \  'tabl'   : ':call winresizer#tabNext(-1)',
        \  'tabr'   : ':call winresizer#tabNext(+1)',
        \  'cancel' : winrestcmd(),
        \}

  return commands

endfun

fun! s:moveCommands()

  let commands = {
        \  'mode'   : "move",
        \  'left'   : ":call winresizer#swapTo('left')",
        \  'right'  : ":call winresizer#swapTo('right')",
        \  'up'     : ":call winresizer#swapTo('up')",
        \  'down'   : ":call winresizer#swapTo('down')",
        \  'close'  : ':call winresizer#winClose()',
        \  'tabl'   : ':call winresizer#tabMove(-1)',
        \  'tabr'   : ':call winresizer#tabMove(+1)',
        \  'cancel' : winrestcmd(),
        \}

  return commands

endfun

fun! s:focusCommands()

  let commands = {
        \  'mode'   : "focus",
        \  'left'   : "normal! \<c-w>h",
        \  'right'  : "normal! \<c-w>l",
        \  'up'     : "normal! \<c-w>k",
        \  'down'   : "normal! \<c-w>j",
        \  'hfull'  : 'resize',
        \  'vfull'  : 'vert resize',
        \  'sizeeq' : 'wincmd =',
        \  'split'  : 'split',
        \  'vsplit' : 'vsplit',
        \  'close'  : 'call winresizer#winClose()',
        \  'tabl'   : 'call winresizer#tabNext(-1)',
        \  'tabr'   : 'call winresizer#tabNext(+1)',
        \  'cancel' : winrestcmd(),
        \  'num1'   : '1 wincmd w',
        \  'num2'   : '2 wincmd w',
        \  'num3'   : '3 wincmd w',
        \  'num4'   : '4 wincmd w',
        \  'num5'   : '5 wincmd w',
        \  'num6'   : '6 wincmd w',
        \  'num7'   : '7 wincmd w',
        \  'num8'   : '8 wincmd w',
        \  'num9'   : '9 wincmd w',
        \  'flast'  : '$ wincmd w',
        \  'fnext'  : 'wincmd w',
        \  'fprev'  : 'wincmd W',
        \}

  return commands

endfun

fun! s:startResize(commands)

  if g:winresizer_enable == 0
    return
  endif

  let l:commands = a:commands

  while 1

    echo '[window ' . l:commands['mode'] . ' mode]... "'.s:label_finish.'": OK , "'.s:label_mode.'": Change mode , "'.s:label_cancel.'": Cancel '

    let c = getchar()

    if c == s:codeList['left'] "h
      exe l:commands['left']
    elseif c == s:codeList['down'] "j
      exe l:commands['down']
    elseif c == s:codeList['up'] "k
      exe l:commands['up']
    elseif c == s:codeList['right'] "l
      exe l:commands['right']
    elseif c == s:codeList['hfull'] && exists("l:commands['hfull']") "_
      exe l:commands['hfull']
    elseif c == s:codeList['vfull'] && exists("l:commands['vfull']") "|
      exe l:commands['vfull']
    elseif c == s:codeList['sizeeq'] && exists("l:commands['sizeeq']") "=
      exe l:commands['sizeeq']
    elseif c == s:codeList['split'] && exists("l:commands['split']") "s
      exe l:commands['split']
    elseif c == s:codeList['vsplit'] && exists("l:commands['vsplit']") "v
      exe l:commands['vsplit']
    elseif c == s:codeList['close'] && exists("l:commands['close']") "C
      exe l:commands['close']
    elseif c == s:codeList['focus'] && getcmdwintype() ==# '' "f
      let l:commands = s:focusCommands()
    elseif c == s:codeList['tabl'] && exists("l:commands['tabl']") "J
      exe l:commands['tabl']
    elseif c == s:codeList['tabr'] && exists("l:commands['tabr']") "K
      exe l:commands['tabr']
    elseif c == s:codeList['move'] && getcmdwintype() ==# '' "w
      let l:commands = s:moveCommands()
    elseif c == s:codeList['resize'] "r
      let l:commands = s:tuiResizeCommands()
    elseif c == s:codeList['enter'] && l:commands['mode'] == "focus"
      let l:commands = s:tuiResizeCommands()
    elseif c == s:codeList['num0'] && exists("l:commands['num0']") "0
      exe l:commands['num0']
    elseif c == s:codeList['num1'] && exists("l:commands['num1']") "1
      exe l:commands['num1']
    elseif c == s:codeList['num2'] && exists("l:commands['num2']") "2
      exe l:commands['num2']
    elseif c == s:codeList['num3'] && exists("l:commands['num3']") "3
      exe l:commands['num3']
    elseif c == s:codeList['num4'] && exists("l:commands['num4']") "4
      exe l:commands['num4']
    elseif c == s:codeList['num5'] && exists("l:commands['num5']") "5
      exe l:commands['num5']
    elseif c == s:codeList['num6'] && exists("l:commands['num6']") "6
      exe l:commands['num6']
    elseif c == s:codeList['num7'] && exists("l:commands['num7']") "7
      exe l:commands['num7']
    elseif c == s:codeList['num8'] && exists("l:commands['num8']") "8
      exe l:commands['num8']
    elseif c == s:codeList['num9'] && exists("l:commands['num9']") "9
      exe l:commands['num9']
    elseif c == s:codeList['flast'] && exists("l:commands['flast']") "$
      exe l:commands['flast']
    elseif c == s:codeList['fnext'] && exists("l:commands['fnext']") "w
      exe l:commands['fnext']
    elseif c == s:codeList['fprev'] && exists("l:commands['fprev']") "W
      exe l:commands['fprev']
    elseif c == g:winresizer_keycode_cancel "q
      exe l:commands['cancel']
      redraw
      echo "Canceled!"
      break
    elseif c == s:codeList['mode'] && getcmdwintype() ==# ''
      if l:commands['mode'] == 'move'
        let l:commands = s:focusCommands()
      elseif l:commands['mode'] == 'focus'
        let l:commands = s:tuiResizeCommands()
      else
        let l:commands = s:moveCommands()
      endif
    elseif c == g:winresizer_keycode_finish || (g:winresizer_finish_with_escape == 1 && c == g:winresizer_keycode_escape)
      redraw
      echo "Finished!"
      break
    endif
    redraw
  endwhile
endfun

" Decide behavior of up, down, left and right key .
" (to increase or decrease window size) 
fun! s:getResizeBehavior()
  let signs = {'left':'-', 'down':'+', 'up':'-', 'right':'+'}
  let result = {}
  let ei = winresizer#getEdgeInfo()
  if !ei['left'] && ei['right']
    let signs['left'] = '+'
    let signs['right'] = '-'
  endif
  if !ei['up'] && ei['down']
    let signs['up'] = '+'
    let signs['down'] = '-'
  endif
  return signs
endfun

" Get opposite sign about + and -
fun! s:getOppositeSign(sign)
  let sign = '+'
  if a:sign == '+'
    let sign = '-'
  endif
  return sign
endfun

fun! s:getKeyAlias(code)
  if a:code == 13
    let alias = "Enter"
  elseif a:code == 32
    let alias = "Space"
  else
    let alias = nr2char(a:code)
  end
  return alias
endfun

let s:label_finish = s:getKeyAlias(g:winresizer_keycode_finish)
let s:label_cancel = s:getKeyAlias(g:winresizer_keycode_cancel)
let s:label_mode = s:getKeyAlias(g:winresizer_keycode_mode)

let &cpo = s:save_cpo
