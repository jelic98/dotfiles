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

function! s:Clear(group)
	exec 'highlight clear ' . a:group
endfunction

let s:colors = {}
let s:colors.base0  = { 'cterm': 0 }	" dark black
" let s:colors.base0  = { 'cterm': 8 }	" light black
let s:colors.base1  = { 'cterm': 1 }	" dark red
" let s:colors.base1  = { 'cterm': 9 }	" light red
let s:colors.base2  = { 'cterm': 2 }	" dark green
" let s:colors.base2  = { 'cterm': 10 }	" light green
let s:colors.base3  = { 'cterm': 3 }	" dark yellow
" let s:colors.base3  = { 'cterm': 11 }	" light yellow
" let s:colors.base4  = { 'cterm': 4 }	" dark blue
let s:colors.base4  = { 'cterm': 12 }	" light blue
let s:colors.base5  = { 'cterm': 5 }	" dark purple
" let s:colors.base5  = { 'cterm': 13 }	" light purple
let s:colors.base6  = { 'cterm': 6 }	" dark cyan
" let s:colors.base6  = { 'cterm': 14 }	" light cyan
let s:colors.base7  = { 'cterm': 7 }	" dark white
" let s:colors.base7  = { 'cterm': 15 }	" light white

call s:Col('Syntax', 'base4')
call s:Col('Title', 'base4')
call s:Col('Underlined', 'base4')
call s:Col('WildMenu', 'base4')

call s:Col('ColorColumn', '', 'base1')
call s:Col('MatchParen', 'base1')
call s:Col('Delimiter', 'base6')
call s:Col('PreCondit', 'base5')
call s:Col('PreProc', 'base5')
call s:Col('VertSplit', 'base7')
call s:Col('Folded', 'base5')

call s:Col('Conditional', 'base5')
call s:Col('Include', 'base5')
call s:Col('Keyword', 'base5')
call s:Col('Structure', 'base5')
call s:Col('Repeat', 'base5')
call s:Col('Operator', 'base6')
call s:Col('StorageClass', 'base5')

call s:Col('Search', 'base0', 'base2')
call s:Col('IncSearch', 'base0', 'base2')

call s:Col('Normal', 'base7')
call s:Col('NonText', 'base1')
call s:Col('Error', 'base1')
call s:Col('Exception', 'base1')

call s:Col('ErrorMsg', '', 'base1')
call s:Col('WarningMsg', '' ,'base3')
call s:Col('ModeMsg', 'base7')
call s:Col('MoreMsg', 'base7')

call s:Col('Boolean', 'base3')
call s:Col('Character', 'base3')
call s:Col('Float', 'base3')
call s:Col('Number', 'base3')
call s:Col('String', 'base3')
call s:Col('Constant', 'base3')

call s:Col('LineNr', 'base6')
call s:Col('Macro', 'base5')
call s:Col('Type', 'base2')
call s:Col('Typedef', 'base5')
call s:Col('Function', 'base2')
call s:Col('Identifier', 'base2')
call s:Col('Statement', 'base2')

call s:Col('Comment', 'base6')
call s:Col('Todo', 'base6', 'base0')

call s:Col('cBadBlock', 'base1', 'base7')
call s:Col('cBitField', 'base7')
call s:Col('cBlock', 'base7')
call s:Col('cBracket', 'base7')
call s:Col('cComment', 'base6')
call s:Col('cDefine', 'base3')
call s:Col('cError', 'base1')
call s:Col('cMulti', 'base7')
call s:Col('cNumbers', 'base3')
call s:Col('cNumbersCom', 'base3')
call s:Col('cParen', 'base7')
call s:Col('cPreCondit', 'base5')
call s:Col('cSpecial', 'base6')
call s:Col('cStatic', 'base2')
call s:Col('cString', 'base3')
call s:Col('cUserCont', 'base5')

call s:Col('DiffAdd', 'base2')
call s:Col('DiffChange', 'base3')
call s:Col('DiffDelete', 'base1')
call s:Col('DiffText', 'base7')

call s:Col('GitGutterAdd', 'base2')
call s:Col('GitGutterAddDefault', 'base2')
call s:Col('GitGutterAddInvisible', 'base2')
call s:Col('GitGutterChange', 'base3')
call s:Col('GitGutterChangeDefault', 'base3')
call s:Col('GitGutterChangeDelete', 'base3')
call s:Col('GitGutterChangeInvisible', 'base3')
call s:Col('GitGutterDelete', 'base1')
call s:Col('GitGutterDeleteDefault', 'base1')
call s:Col('GitGutterDeleteInvisible', 'base1')

call s:Col('Pmenu', 'base0', 'base7')
call s:Col('PmenuSel', 'base0', 'base6')
call s:Col('PmenuSbar', '', 'base0')
call s:Col('PmenuThumb', '', 'base7')

call s:Col('Special', 'base6')
call s:Col('SpecialChar', 'base6')
call s:Col('SpecialKey', 'base6')

call s:Col('StatusLine', 'base0', 'base7')
call s:Col('StatusLineNC', 'base0', 'base7')
call s:Col('StatusLineTerm', 'base0', 'base7')
call s:Col('StatusLineTermNC', 'base0', 'base7')

call s:Col('SyntasticErrorLine', 'base7', 'base1')
call s:Col('SyntasticWarningLine', 'base7', 'base3')

call s:Col('TabLine', 'base0', 'base7')
call s:Col('TabLineFill', '', 'base7')
call s:Col('TabLineSel', 'base0', 'base6')

call s:Col('Visual', 'base0', 'base7')
call s:Col('VisualNOS', 'base0', 'base7')

unlet s:colors
