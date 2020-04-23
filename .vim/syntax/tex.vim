" Vim syntax file
" Language:	TeX
" Maintainer:	Charles E. Campbell <NcampObell@SdrPchip.AorgM-NOSPAM>
" Last Change:	Jan 24, 2020
" Version:	116
" URL:		http://www.drchip.org/astronaut/vim/index.html#SYNTAX_TEX
"
" Notes: {{{1
"
" 1. If you have a \begin{verbatim} that appears to overrun its boundaries,
"    use %stopzone.
"
" 2. Run-on equations ($..$ and $$..$$, particularly) can also be stopped
"    by suitable use of %stopzone.
"
" 3. If you have a slow computer, you may wish to modify
"
"	syn sync maxlines=200
"	syn sync minlines=50
"
"    to values that are more to your liking.
"
" 4. There is no match-syncing for $...$ and $$...$$; hence large
"    equation blocks constructed that way may exhibit syncing problems.
"    (there's no difference between begin/end patterns)
"
" 5. If you have the variable "g:tex_no_error" defined then none of the
"    lexical error-checking will be done.
"
"    ie. let g:tex_no_error=1
"
" 6. Please see  :help latex-syntax  for information on
"      syntax folding           :help tex-folding
"      spell checking           :help tex-nospell
"      commands and mathzones   :help tex-runon
"      new command highlighting :help tex-morecommands
"      error highlighting       :help tex-error
"      new math groups          :help tex-math
"      new styles               :help tex-style
"      using conceal mode       :help tex-conceal

" Version Clears: {{{1
" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif
let s:keepcpo= &cpo
set cpo&vim
scriptencoding utf-8

" by default, enable all region-based highlighting
let s:tex_fast= "bcmMprsSvV"
if exists("g:tex_fast")
 if type(g:tex_fast) != 1
  " g:tex_fast exists and is not a string, so
  " turn off all optional region-based highighting
  let s:tex_fast= ""
 else
  let s:tex_fast= g:tex_fast
 endif
endif

" let user determine which classes of concealment will be supported
"   a=accents/ligatures d=delimiters m=math symbols  g=Greek  s=superscripts/subscripts
if !exists("g:tex_conceal")
 let s:tex_conceal= 'abdmgsS'
else
 let s:tex_conceal= g:tex_conceal
endif
if !exists("g:tex_superscripts")
 let s:tex_superscripts= '[0-9a-zA-W.,:;+-<>/()=]'
else
 let s:tex_superscripts= g:tex_superscripts
endif
if !exists("g:tex_subscripts")
 let s:tex_subscripts= '[0-9aehijklmnoprstuvx,+-/().]'
else
 let s:tex_subscripts= g:tex_subscripts
endif

" Determine whether or not to use "*.sty" mode {{{1
" The user may override the normal determination by setting
"   g:tex_stylish to 1      (for    "*.sty" mode)
"    or to           0 else (normal "*.tex" mode)
" or on a buffer-by-buffer basis with b:tex_stylish
let s:extfname=expand("%:e")
if exists("g:tex_stylish")
 let b:tex_stylish= g:tex_stylish
elseif !exists("b:tex_stylish")
 if s:extfname == "sty" || s:extfname == "cls" || s:extfname == "clo" || s:extfname == "dtx" || s:extfname == "ltx"
  let b:tex_stylish= 1
 else
  let b:tex_stylish= 0
 endif
endif

" handle folding {{{1
if !exists("g:tex_fold_enabled")
 let s:tex_fold_enabled= 0
elseif g:tex_fold_enabled && !has("folding")
 let s:tex_fold_enabled= 0
 echomsg "Ignoring g:tex_fold_enabled=".g:tex_fold_enabled."; need to re-compile vim for +fold support"
else
 let s:tex_fold_enabled= 1
endif
if s:tex_fold_enabled && &fdm == "manual"
 setl fdm=syntax
endif
if s:tex_fold_enabled && has("folding")
 com! -nargs=* TexFold <args> fold 
else
 com! -nargs=* TexFold <args> 
endif

" (La)TeX keywords: uses the characters 0-9,a-z,A-Z,192-255 only... {{{1
" but _ is the only one that causes problems.
" One may override this iskeyword setting by providing
" g:tex_isk
if exists("g:tex_isk")
 if b:tex_stylish && g:tex_isk !~ '@'
  let b:tex_isk= '@,'.g:tex_isk
 else
  let b:tex_isk= g:tex_isk
 endif
elseif b:tex_stylish
 let b:tex_isk="@,48-57,a-z,A-Z,192-255"
else
 let b:tex_isk="48-57,a-z,A-Z,192-255"
endif
if (v:version == 704 && has("patch-7.4.1142")) || v:version > 704
 exe "syn iskeyword ".b:tex_isk
else
 exe "setl isk=".b:tex_isk
endif
if exists("g:tex_no_error") && g:tex_no_error
 let s:tex_no_error= 1
else
 let s:tex_no_error= 0
endif
if exists("g:tex_comment_nospell") && g:tex_comment_nospell
 let s:tex_comment_nospell= 1
else
 let s:tex_comment_nospell= 0
endif
if exists("g:tex_nospell") && g:tex_nospell
 let s:tex_nospell = 1
else
 let s:tex_nospell = 0
endif
if exists("g:tex_excludematcher")
 let s:tex_excludematcher= g:tex_excludematcher
else
 let s:tex_excludematcher= 0
endif

" Clusters: {{{1
" --------
syn cluster texCmdGroup			contains=texCmdBody,texComment,texDefParm,texDelimiter,texDocType,texInput,texLength,texLigature,texMathDelim,texMathOper,texNewCmd,texNewEnv,texRefZone,texSection,texBeginEnd,texBeginEndName,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,@texMathZones
if !s:tex_no_error
 syn cluster texCmdGroup		add=texMathError
endif
syn cluster texEnvGroup			contains=texMatcher,texMathDelim,texSpecialChar,texStatement
syn cluster texFoldGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texInputFile,texLength,texLigature,texMatcher,texMathZoneV,texMathZoneW,texMathZoneX,texMathZoneY,texMathZoneZ,texNewCmd,texNewEnv,texOnlyMath,texOption,texParen,texRefZone,texSection,texBeginEnd,texSectionZone,texSpaceCode,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,@texMathZones,texTitle,texAbstract,texBoldStyle,texItalStyle,texEmphStyle,texNoSpell
syn cluster texBoldGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texInputFile,texLength,texLigature,texMathZoneV,texMathZoneW,texMathZoneX,texMathZoneY,texMathZoneZ,texNewCmd,texNewEnv,texOnlyMath,texOption,texParen,texRefZone,texSection,texBeginEnd,texSectionZone,texSpaceCode,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,@texMathZones,texTitle,texAbstract,texBoldStyle,texBoldItalStyle,texNoSpell
syn cluster texItalGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texInputFile,texLength,texLigature,texMathZoneV,texMathZoneW,texMathZoneX,texMathZoneY,texMathZoneZ,texNewCmd,texNewEnv,texOnlyMath,texOption,texParen,texRefZone,texSection,texBeginEnd,texSectionZone,texSpaceCode,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,@texMathZones,texTitle,texAbstract,texItalStyle,texEmphStyle,texItalBoldStyle,texNoSpell
if !s:tex_excludematcher
 syn cluster texBoldGroup add=texMatcher
 syn cluster texItalGroup add=texMatcher
endif
if !s:tex_nospell
 syn cluster texMatchGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texMatcher,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texBoldStyle,texBoldItalStyle,texItalStyle,texItalBoldStyle,texZone,texInputFile,texOption,@Spell
 syn cluster texMatchNMGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texMatcherNM,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texBoldStyle,texBoldItalStyle,texItalStyle,texItalBoldStyle,texZone,texInputFile,texOption,@Spell
 syn cluster texStyleGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texBoldStyle,texBoldItalStyle,texItalStyle,texItalBoldStyle,texZone,texInputFile,texOption,texStyleStatement,texStyleMatcher,@Spell
else
 syn cluster texMatchGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texMatcher,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,texInputFile,texOption
 syn cluster texMatchNMGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texMatcherNM,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,texInputFile,texOption
 syn cluster texStyleGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,texInputFile,texOption,texStyleStatement,texStyleMatcher
endif
syn cluster texPreambleMatchGroup	contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texMatcherNM,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTitle,texTypeSize,texTypeStyle,texZone,texInputFile,texOption,texMathZoneZ
syn cluster texRefGroup			contains=texMatcher,texComment,texDelimiter
if !exists("g:tex_no_math")
 syn cluster texPreambleMatchGroup	contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texMatcherNM,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTitle,texTypeSize,texTypeStyle,texZone,texInputFile,texOption,texMathZoneZ
 syn cluster texMathZones		contains=texMathZoneV,texMathZoneW,texMathZoneX,texMathZoneY,texMathZoneZ
 syn cluster texMatchGroup		add=@texMathZones
 syn cluster texMathDelimGroup		contains=texMathDelimBad,texMathDelimKey,texMathDelimSet1,texMathDelimSet2
 syn cluster texMathMatchGroup		contains=@texMathZones,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texMathDelim,texMathMatcher,texMathOper,texNewCmd,texNewEnv,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone
 syn cluster texMathZoneGroup		contains=texComment,texDelimiter,texLength,texMathDelim,texMathMatcher,texMathOper,texMathSymbol,texMathText,texRefZone,texSpecialChar,texStatement,texTypeSize,texTypeStyle
 if !s:tex_no_error
  syn cluster texMathMatchGroup		add=texMathError
  syn cluster texMathZoneGroup		add=texMathError
 endif
 syn cluster texMathZoneGroup		add=@NoSpell
 " following used in the \part \chapter \section \subsection \subsubsection
 " \paragraph \subparagraph \author \title highlighting
 syn cluster texDocGroup		contains=texPartZone,@texPartGroup
 syn cluster texPartGroup		contains=texChapterZone,texSectionZone,texParaZone
 syn cluster texChapterGroup		contains=texSectionZone,texParaZone
 syn cluster texSectionGroup		contains=texSubSectionZone,texParaZone
 syn cluster texSubSectionGroup		contains=texSubSubSectionZone,texParaZone
 syn cluster texSubSubSectionGroup	contains=texParaZone
 syn cluster texParaGroup		contains=texSubParaZone
 if has("conceal") && &enc == 'utf-8'
  syn cluster texMathZoneGroup		add=texGreek,texSuperscript,texSubscript,texMathSymbol
  syn cluster texMathMatchGroup		add=texGreek,texSuperscript,texSubscript,texMathSymbol
 endif
endif

" Try to flag {} and () mismatches: {{{1
if s:tex_fast =~# 'm'
  if !s:tex_no_error
   syn region texMatcher	matchgroup=Delimiter start="{" skip="\\\\\|\\[{}]"	end="}"			transparent contains=@texMatchGroup,texError
   syn region texMatcher	matchgroup=Delimiter start="\["				end="]"			transparent contains=@texMatchGroup,texError,@NoSpell
   syn region texMatcherNM	matchgroup=Delimiter start="{" skip="\\\\\|\\[{}]"	end="}"			transparent contains=@texMatchNMGroup,texError
   syn region texMatcherNM	matchgroup=Delimiter start="\["				end="]"			transparent contains=@texMatchNMGroup,texError,@NoSpell
  else
   syn region texMatcher	matchgroup=Delimiter start="{" skip="\\\\\|\\[{}]"	end="}"			transparent contains=@texMatchGroup
   syn region texMatcher	matchgroup=Delimiter start="\["				end="]"			transparent contains=@texMatchGroup
   syn region texMatcherNM	matchgroup=Delimiter start="{" skip="\\\\\|\\[{}]"	end="}"			transparent contains=@texMatchNMGroup
   syn region texMatcherNM	matchgroup=Delimiter start="\["				end="]"			transparent contains=@texMatchNMGroup
  endif
  if !s:tex_nospell
   syn region texParen		start="("	end=")"								transparent contains=@texMatchGroup,@Spell
  else
   syn region texParen		start="("	end=")"								transparent contains=@texMatchGroup
  endif
endif
if !s:tex_no_error
 syn match  texError		"[}\])]"
endif
if s:tex_fast =~# 'M'
  if !exists("g:tex_no_math")
   if !s:tex_no_error
    syn match  texMathError	"}"	contained
   endif
   syn region texMathMatcher	matchgroup=Delimiter	start="{"          skip="\%(\\\\\)*\\}"     end="}" end="%stopzone\>"	contained contains=@texMathMatchGroup
  endif
endif

" TeX/LaTeX keywords: {{{1
" Instead of trying to be All Knowing, I just match \..alphameric..
" Note that *.tex files may not have "@" in their \commands
if exists("g:tex_tex") || b:tex_stylish
  syn match texStatement	"\\[a-zA-Z@]\+"
else
  syn match texStatement	"\\\a\+"
  if !s:tex_no_error
   syn match texError		"\\\a*@[a-zA-Z@]*"
  endif
endif

" TeX/LaTeX delimiters: {{{1
syn match texDelimiter		"&"
syn match texDelimiter		"\\\\"

" Tex/Latex Options: {{{1
syn match texOption		"[^\\]\zs#\d\+\|^#\d\+"

" texAccent (tnx to Karim Belabas) avoids annoying highlighting for accents: {{{1
if b:tex_stylish
  syn match texAccent		"\\[bcdvuH][^a-zA-Z@]"me=e-1
  syn match texLigature		"\\\([ijolL]\|ae\|oe\|ss\|AA\|AE\|OE\)[^a-zA-Z@]"me=e-1
else
  syn match texAccent		"\\[bcdvuH]\A"me=e-1
  syn match texLigature		"\\\([ijolL]\|ae\|oe\|ss\|AA\|AE\|OE\)\A"me=e-1
endif
syn match texAccent		"\\[bcdvuH]$"
syn match texAccent		+\\[=^.\~"`']+
syn match texAccent		+\\['=t'.c^ud"vb~Hr]{\a}+
syn match texLigature		"\\\([ijolL]\|ae\|oe\|ss\|AA\|AE\|OE\)$"


" \begin{}/\end{} section markers: {{{1
syn match  texBeginEnd		"\\begin\>\|\\end\>" nextgroup=texBeginEndName
if s:tex_fast =~# 'm'
  syn region texBeginEndName		matchgroup=Delimiter	start="{"		end="}"	contained	nextgroup=texBeginEndModifier	contains=texComment
  syn region texBeginEndModifier	matchgroup=Delimiter	start="\["		end="]"	contained	contains=texComment,@texMathZones,@NoSpell
endif

" \documentclass, \documentstyle, \usepackage: {{{1
syn match  texDocType		"\\documentclass\>\|\\documentstyle\>\|\\usepackage\>"	nextgroup=texBeginEndName,texDocTypeArgs
if s:tex_fast =~# 'm'
  syn region texDocTypeArgs	matchgroup=Delimiter start="\[" end="]"			contained	nextgroup=texBeginEndName	contains=texComment,@NoSpell
endif

" Preamble syntax-based folding support: {{{1
if s:tex_fold_enabled && has("folding")
 syn region texPreamble	transparent fold	start='\zs\\documentclass\>' end='\ze\\begin{document}'	contains=texStyle,@texPreambleMatchGroup
endif

" TeX input: {{{1
syn match texInput		"\\input\s\+[a-zA-Z/.0-9_^]\+"hs=s+7				contains=texStatement
syn match texInputFile		"\\include\(graphics\|list\)\=\(\[.\{-}\]\)\=\s*{.\{-}}"	contains=texStatement,texInputCurlies,texInputFileOpt
syn match texInputFile		"\\\(epsfig\|input\|usepackage\)\s*\(\[.*\]\)\={.\{-}}"		contains=texStatement,texInputCurlies,texInputFileOpt
syn match texInputCurlies	"[{}]"								contained
if s:tex_fast =~# 'm'
 syn region texInputFileOpt	matchgroup=Delimiter start="\[" end="\]"			contained	contains=texComment
endif

" Type Styles (LaTeX 2.09): {{{1
syn match texTypeStyle		"\\rm\>"
syn match texTypeStyle		"\\em\>"
syn match texTypeStyle		"\\bf\>"
syn match texTypeStyle		"\\it\>"
syn match texTypeStyle		"\\sl\>"
syn match texTypeStyle		"\\sf\>"
syn match texTypeStyle		"\\sc\>"
syn match texTypeStyle		"\\tt\>"

" Type Styles: attributes, commands, families, etc (LaTeX2E): {{{1
if s:tex_conceal !~# 'b'
 syn match texTypeStyle		"\\textbf\>"
 syn match texTypeStyle		"\\textit\>"
 syn match texTypeStyle		"\\emph\>"
endif
syn match texTypeStyle		"\\textmd\>"
syn match texTypeStyle		"\\textrm\>"

syn match texTypeStyle		"\\mathbb\>"
syn match texTypeStyle		"\\mathbf\>"
syn match texTypeStyle		"\\mathcal\>"
syn match texTypeStyle		"\\mathfrak\>"
syn match texTypeStyle		"\\mathit\>"
syn match texTypeStyle		"\\mathnormal\>"
syn match texTypeStyle		"\\mathrm\>"
syn match texTypeStyle		"\\mathsf\>"
syn match texTypeStyle		"\\mathtt\>"

syn match texTypeStyle		"\\rmfamily\>"
syn match texTypeStyle		"\\sffamily\>"
syn match texTypeStyle		"\\ttfamily\>"

syn match texTypeStyle		"\\itshape\>"
syn match texTypeStyle		"\\scshape\>"
syn match texTypeStyle		"\\slshape\>"
