hi clear
if exists('syntax_on') | syntax reset | endif
let g:colors_name = 'tluafed'

function! s:Highlight(args)
  exec 'highlight ' . join(a:args, ' ')
endfunction

function! s:AddGroundValues(accumulator, ground, color)
  let new_list = a:accumulator
  for [where, value] in items(a:color)
    call add(new_list, where . a:ground . '=' . value)
  endfor
  return new_list
endfunction

function! s:Col(group, fg_name, ...)
  let pieces = [a:group]
  if a:fg_name !=# ''
    let pieces = s:AddGroundValues(pieces, 'fg', s:colors[a:fg_name])
  endif
  if a:0 > 0 && a:1 !=# ''
    let pieces = s:AddGroundValues(pieces, 'bg', s:colors[a:1])
  endif
  call s:Clear(a:group)
  call s:Highlight(pieces)
endfunction

function! s:Attr(group, attr)
  let l:attrs = [a:group, 'cterm=' . a:attr]
  call s:Highlight(l:attrs)
endfunction

function! s:Clear(group)
  exec 'highlight clear ' . a:group
endfunction

let s:colors = {}

let s:colors.base0  = { 'cterm': 0 }	" black
let s:colors.base1  = { 'cterm': 1 }	" red
let s:colors.base2  = { 'cterm': 2 }	" green
let s:colors.base3  = { 'cterm': 3 }	" yellow
let s:colors.base4  = { 'cterm': 4 }	" blue
let s:colors.base5  = { 'cterm': 5 }	" purple
let s:colors.base6  = { 'cterm': 6 }	" cyan
let s:colors.base7  = { 'cterm': 7 }	" white

" let s:colors.base0  = { 'cterm': 8 }	" light black
" let s:colors.base1  = { 'cterm': 9 }	" light red
" let s:colors.base2  = { 'cterm': 10 }	" light green
" let s:colors.base3  = { 'cterm': 11 }	" light yellow
" let s:colors.base4  = { 'cterm': 12 }	" light blue
" let s:colors.base5  = { 'cterm': 13 }	" light purple
" let s:colors.base6  = { 'cterm': 14 }	" light cyan
" let s:colors.base7  = { 'cterm': 15 }	" light white

call s:Col('Normal', 'base7', 'base0')
call s:Col('NonText', 'base2')

call s:Col('Cursor', 'base0', 'base7')
call s:Col('CursorLine', '', 'base0')
call s:Col('CursorColumn', '', 'base0')

call s:Col('LineNr', 'base7', 'base0')
call s:Col('CursorLineNr', 'base7', 'base0')
call s:Col('SignColumn', '', 'base0')
call s:Col('ColorColumn', '', 'base1')
call s:Col('VertSplit', 'base7', 'base0')
call s:Attr('VertSplit', 'bold')

call s:Col('Visual', 'base7', 'base7')
call s:Col('VusualNOS', 'base7', 'base7')

call s:Col('Comment', 'base7')
call s:Col('String', 'base4')
call s:Col('Character', 'base4')
call s:Col('Number', 'base3')
call s:Col('Float', 'base4')
call s:Col('Boolean', 'base4')
call s:Attr('Boolean', 'bold')
call s:Col('Operator', 'base2')
call s:Attr('Operator', 'bold')
call s:Col('Statement', 'base2')
call s:Col('Special', 'base4')
call s:Col('Identifier', 'base4')
call s:Col('Repeat', 'base2')
call s:Attr('Repeat', 'bold')
call s:Col('Structure', 'base1')
call s:Attr('Structure', 'bold')

call s:Col('Function', 'base5')
call s:Attr('Function', 'bold')
call s:Col('Exception', 'base2')
call s:Attr('Exception', 'bold')
call s:Col('Keyword', 'base1')
call s:Attr('Keyword', 'bold')
call s:Col('Error', 'base7', 'base1')

call s:Col('Constant', 'base4')
call s:Col('Typedef', 'base2')
call s:Attr('Typedef', 'bold')
call s:Col('StorageClass', 'base4')
call s:Col('Title', 'base2', 'base0')
call s:Attr('Title', 'bold')

call s:Col('Underlined', 'base7')
call s:Attr('Underlined', 'underline')

call s:Col('Type', 'base2')
call s:Attr('Type', 'bold')

call s:Col('PreProc', 'base1')
call s:Attr('PreProc', 'bold')

call s:Col('Todo', 'base7', 'base2')

call s:Col('StatusLine', 'base7', 'base2')
call s:Attr('StatusLine', 'bold')
call s:Col('StatusLineNC', 'base7', 'base2')
call s:Attr('StatusLineNC', 'bold')

call s:Col('MatchParen', 'base1')
call s:Attr('MatchParen', 'bold')

call s:Col('SpecialKey', 'base2')

call s:Col('Search', 'base7', 'base2')
call s:Col('IncSearch', 'base7', 'base5')

call s:Col('PMenu', 'base2', 'base0')
call s:Col('PMenuSel', 'base7', 'base5')
call s:Col('PmenuSbar', '', 'base0')
call s:Col('PMenuThumb', '', 'base7')

call s:Col('WildMenu', 'base7', 'base5')
call s:Attr('WildMenu', 'bold')

call s:Col('ErrorMsg', 'base7', 'base1')
call s:Col('Error', 'base7', 'base1')
call s:Col('ModeMsg', 'base7', 'base5')
call s:Col('WarningMsg', 'base7', 'base3')

call s:Col('TabLine', 'base7', 'base5')
call s:Attr('TabLine', 'bold')
call s:Col('TabLineSel', 'base7', 'base5')
call s:Attr('TabLine', 'bold')
call s:Col('TabLineFill', 'base0', 'base0')

call s:Col('SpellBad', 'base7', 'base1')
call s:Attr('SpellBad', 'bold')
call s:Col('SpellCap', 'base7', 'base4')
call s:Attr('SpellCap', 'bold')
call s:Col('SpellRare', 'base7', 'base3')
call s:Attr('SpellRare', 'underline')

call s:Col('DiffText', '', 'base5')
call s:Col('DiffDelete', '', 'base2')
call s:Col('DiffChange', '', 'base5')
call s:Col('DiffAdd', '', 'base2')

call s:Col('Include', 'base2')
call s:Attr('Include', 'bold')
call s:Col('Conditional', 'base2')
call s:Attr('Conditional', 'bold')
call s:Col('PreCondit', 'base5')
call s:Attr('PreCondit', 'bold')
call s:Col('Delimiter', 'base3')

call s:Col('Directory', 'base4')

call s:Col('GitGutterAdd', 'base2', 'base0')
call s:Col('GitGutterChange', 'base3', 'base0')
call s:Col('GitGutterDelete', 'base1', 'base0')
call s:Col('GitGutterChangeDelete', 'base4', 'base0')

unlet s:colors
