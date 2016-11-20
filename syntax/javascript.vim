" Vim syntax file
" Language: javascript
" Author: MicroSoft Open Technologies Inc.
" Version: 0.1
" Credits: Zhao Yi, Claudio Fleiner, Scott Shattuck, Jose Elera Campana

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = "javascriptFlow"
endif

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("javascriptFlow_fold")
  unlet javascriptFlow_fold
endif

"" dollar sign is permitted anywhere in an identifier
setlocal iskeyword+=$

syntax sync fromstart

"" syntax coloring for Node.js shebang line
syn match shebang "^#!.*/bin/env\s\+node\>"
hi link shebang Comment

"" javascriptFlow comments"{{{
syn keyword javascriptFlowCommentTodo TODO FIXME XXX TBD contained
syn match javascriptFlowLineComment "\/\/.*" contains=@Spell,javascriptFlowCommentTodo,javascriptFlowRef
syn match javascriptFlowRefComment /\/\/\/<\(reference\|amd-\(dependency\|module\)\)\s\+.*\/>$/ contains=javascriptFlowRefD,javascriptFlowRefS
syn region javascriptFlowRefD start=+"+ skip=+\\\\\|\\"+ end=+"\|$+
syn region javascriptFlowRefS start=+'+ skip=+\\\\\|\\'+ end=+'\|$+

syn match javascriptFlowCommentSkip "^[ \t]*\*\($\|[ \t]\+\)"
syn region javascriptFlowComment start="/\*" end="\*/" contains=@Spell,javascriptFlowCommentTodo extend
"}}}
"" JSDoc support start"{{{
if !exists("javascriptFlow_ignore_javascriptFlowdoc")
  syntax case ignore

" syntax coloring for JSDoc comments (HTML)
"unlet b:current_syntax

  syntax region javascriptFlowDocComment start="/\*\*\s*$" end="\*/" contains=javascriptFlowDocTags,javascriptFlowCommentTodo,javascriptFlowCvsTag,@javascriptFlowHtml,@Spell fold extend
  syntax match javascriptFlowDocTags contained "@\(param\|argument\|requires\|exception\|throws\|type\|class\|extends\|see\|link\|member\|module\|method\|title\|namespace\|optional\|default\|base\|file\)\>" nextgroup=javascriptFlowDocParam,javascriptFlowDocSeeTag skipwhite
  syntax match javascriptFlowDocTags contained "@\(beta\|deprecated\|description\|fileoverview\|author\|license\|version\|returns\=\|constructor\|private\|protected\|final\|ignore\|addon\|exec\)\>"
  syntax match javascriptFlowDocParam contained "\%(#\|\w\|\.\|:\|\/\)\+"
  syntax region javascriptFlowDocSeeTag contained matchgroup=javascriptFlowDocSeeTag start="{" end="}" contains=javascriptFlowDocTags

  syntax case match
endif "" JSDoc end
"}}}
syntax case match

"" Syntax in the javascriptFlow code"{{{
syn match javascriptFlowSpecial "\\\d\d\d\|\\."
syn region javascriptFlowStringD start=+"+ skip=+\\\\\|\\"+ end=+"\|$+  contains=javascriptFlowSpecial,@htmlPreproc extend
syn region javascriptFlowStringS start=+'+ skip=+\\\\\|\\'+ end=+'\|$+  contains=javascriptFlowSpecial,@htmlPreproc extend
syn region javascriptFlowStringB start=+`+ skip=+\\\\\|\\`+ end=+`+  contains=javascriptFlowInterpolation,javascriptFlowSpecial,@htmlPreproc extend

syn region javascriptFlowInterpolation matchgroup=javascriptFlowInterpolationDelimiter
      \ start=/${/ end=/}/ contained
      \ contains=@javascriptFlowExpression

syn match javascriptFlowNumber "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region javascriptFlowRegexpString start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gi]\{0,2\}\s*$+ end=+/[gi]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline
" syntax match javascriptFlowSpecial "\\\d\d\d\|\\x\x\{2\}\|\\u\x\{4\}\|\\."
" syntax region javascriptFlowStringD start=+"+ skip=+\\\\\|\\$"+ end=+"+ contains=javascriptFlowSpecial,@htmlPreproc
" syntax region javascriptFlowStringS start=+'+ skip=+\\\\\|\\$'+ end=+'+ contains=javascriptFlowSpecial,@htmlPreproc
" syntax region javascriptFlowRegexpString start=+/\(\*\|/\)\@!+ skip=+\\\\\|\\/+ end=+/[gim]\{,3}+ contains=javascriptFlowSpecial,@htmlPreproc oneline
" syntax match javascriptFlowNumber /\<-\=\d\+L\=\>\|\<0[xX]\x\+\>/
syntax match javascriptFlowFloat /\<-\=\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%([eE][+-]\=\d\+\)\=\>/
" syntax match javascriptFlowLabel /\(?\s*\)\@<!\<\w\+\(\s*:\)\@=/

syn match javascriptFlowDecorators /@\([_$a-zA-Z][_$a-zA-Z0-9]*\.\)*[_$a-zA-Z][_$a-zA-Z0-9]*\>/
"}}}
"" javascriptFlow Prototype"{{{
syntax keyword javascriptFlowPrototype contained prototype
"}}}
" DOM, Browser and Ajax Support {{{
""""""""""""""""""""""""
syntax keyword javascriptFlowBrowserObjects window navigator screen history location

syntax keyword javascriptFlowDOMObjects document event HTMLElement Anchor Area Base Body Button Form Frame Frameset Image Link Meta Option Select Style Table TableCell TableRow Textarea
syntax keyword javascriptFlowDOMMethods contained createTextNode createElement insertBefore replaceChild removeChild appendChild hasChildNodes cloneNode normalize isSupported hasAttributes getAttribute setAttribute removeAttribute getAttributeNode setAttributeNode removeAttributeNode getElementsByTagName hasAttribute getElementById adoptNode close compareDocumentPosition createAttribute createCDATASection createComment createDocumentFragment createElementNS createEvent createExpression createNSResolver createProcessingInstruction createRange createTreeWalker elementFromPoint evaluate getBoxObjectFor getElementsByClassName getSelection getUserData hasFocus importNode
syntax keyword javascriptFlowDOMProperties contained nodeName nodeValue nodeType parentNode childNodes firstChild lastChild previousSibling nextSibling attributes ownerDocument namespaceURI prefix localName tagName

syntax keyword javascriptFlowAjaxObjects XMLHttpRequest
syntax keyword javascriptFlowAjaxProperties contained readyState responseText responseXML statusText
syntax keyword javascriptFlowAjaxMethods contained onreadystatechange abort getAllResponseHeaders getResponseHeader open send setRequestHeader

syntax keyword javascriptFlowPropietaryObjects ActiveXObject
syntax keyword javascriptFlowPropietaryMethods contained attachEvent detachEvent cancelBubble returnValue

syntax keyword javascriptFlowHtmlElemProperties contained className clientHeight clientLeft clientTop clientWidth dir href id innerHTML lang length offsetHeight offsetLeft offsetParent offsetTop offsetWidth scrollHeight scrollLeft scrollTop scrollWidth style tabIndex target title

syntax keyword javascriptFlowEventListenerKeywords contained blur click focus mouseover mouseout load item

syntax keyword javascriptFlowEventListenerMethods contained scrollIntoView addEventListener dispatchEvent removeEventListener preventDefault stopPropagation
" }}}
"" Programm Keywords"{{{
syntax keyword javascriptFlowSource import export from as
syntax keyword javascriptFlowIdentifier arguments this let var void const
syntax keyword javascriptFlowOperator delete new instanceof typeof
syntax keyword javascriptFlowBoolean true false
syntax keyword javascriptFlowNull null undefined
syntax keyword javascriptFlowMessage alert confirm prompt status
syntax keyword javascriptFlowGlobal self top parent
syntax keyword javascriptFlowDeprecated escape unescape all applets alinkColor bgColor fgColor linkColor vlinkColor xmlEncoding
"}}}
"" Statement Keywords"{{{
syntax keyword javascriptFlowConditional if else switch
syntax keyword javascriptFlowRepeat do while for in of
syntax keyword javascriptFlowBranch break continue yield await
syntax keyword javascriptFlowLabel case default async readonly
syntax keyword javascriptFlowStatement return with

syntax keyword javascriptFlowGlobalObjects Array Boolean Date Function Infinity Math Number NaN Object Packages RegExp String Symbol netscape

syntax keyword javascriptFlowExceptions try catch throw finally Error EvalError RangeError ReferenceError SyntaxError TypeError URIError

syntax keyword javascriptFlowReserved constructor declare as interface module abstract enum int short export interface static byte extends long super char final native synchronized class float package throws goto private transient debugger implements protected volatile double import public type namespace from get set
"}}}
"" javascriptFlow/DOM/HTML/CSS specified things"{{{

" javascriptFlow Objects"{{{
  syn match javascriptFlowFunction "(super\s*|constructor\s*)" contained nextgroup=javascriptFlowVars
  syn region javascriptFlowVars start="(" end=")" contained contains=javascriptFlowParameters transparent keepend
  syn match javascriptFlowParameters "([a-zA-Z0-9_?.$][\w?.$]*)\s*:\s*([a-zA-Z0-9_?.$][\w?.$]*)" contained skipwhite
"}}}
" DOM2 Objects"{{{
  syntax keyword javascriptFlowType DOMImplementation DocumentFragment Node NodeList NamedNodeMap CharacterData Attr Element Text Comment CDATASection DocumentType Notation Entity EntityReference ProcessingInstruction void any string boolean number symbol never
  syntax keyword javascriptFlowExceptions DOMException
"}}}
" DOM2 CONSTANT"{{{
  syntax keyword javascriptFlowDomErrNo INDEX_SIZE_ERR DOMSTRING_SIZE_ERR HIERARCHY_REQUEST_ERR WRONG_DOCUMENT_ERR INVALID_CHARACTER_ERR NO_DATA_ALLOWED_ERR NO_MODIFICATION_ALLOWED_ERR NOT_FOUND_ERR NOT_SUPPORTED_ERR INUSE_ATTRIBUTE_ERR INVALID_STATE_ERR SYNTAX_ERR INVALID_MODIFICATION_ERR NAMESPACE_ERR INVALID_ACCESS_ERR
  syntax keyword javascriptFlowDomNodeConsts ELEMENT_NODE ATTRIBUTE_NODE TEXT_NODE CDATA_SECTION_NODE ENTITY_REFERENCE_NODE ENTITY_NODE PROCESSING_INSTRUCTION_NODE COMMENT_NODE DOCUMENT_NODE DOCUMENT_TYPE_NODE DOCUMENT_FRAGMENT_NODE NOTATION_NODE
"}}}
" HTML events and internal variables"{{{
  syntax case ignore
  syntax keyword javascriptFlowHtmlEvents onblur onclick oncontextmenu ondblclick onfocus onkeydown onkeypress onkeyup onmousedown onmousemove onmouseout onmouseover onmouseup onresize onload onsubmit
  syntax case match
"}}}

" Follow stuff should be highligh within a special context
" While it can't be handled with context depended with Regex based highlight
" So, turn it off by default
if exists("javascriptFlow_enable_domhtmlcss")

" DOM2 things"{{{
    syntax match javascriptFlowDomElemAttrs contained /\%(nodeName\|nodeValue\|nodeType\|parentNode\|childNodes\|firstChild\|lastChild\|previousSibling\|nextSibling\|attributes\|ownerDocument\|namespaceURI\|prefix\|localName\|tagName\)\>/
    syntax match javascriptFlowDomElemFuncs contained /\%(insertBefore\|replaceChild\|removeChild\|appendChild\|hasChildNodes\|cloneNode\|normalize\|isSupported\|hasAttributes\|getAttribute\|setAttribute\|removeAttribute\|getAttributeNode\|setAttributeNode\|removeAttributeNode\|getElementsByTagName\|getAttributeNS\|setAttributeNS\|removeAttributeNS\|getAttributeNodeNS\|setAttributeNodeNS\|getElementsByTagNameNS\|hasAttribute\|hasAttributeNS\)\>/ nextgroup=javascriptFlowParen skipwhite
"}}}
" HTML things"{{{
    syntax match javascriptFlowHtmlElemAttrs contained /\%(className\|clientHeight\|clientLeft\|clientTop\|clientWidth\|dir\|id\|innerHTML\|lang\|length\|offsetHeight\|offsetLeft\|offsetParent\|offsetTop\|offsetWidth\|scrollHeight\|scrollLeft\|scrollTop\|scrollWidth\|style\|tabIndex\|title\)\>/
    syntax match javascriptFlowHtmlElemFuncs contained /\%(blur\|click\|focus\|scrollIntoView\|addEventListener\|dispatchEvent\|removeEventListener\|item\)\>/ nextgroup=javascriptFlowParen skipwhite
"}}}
" CSS Styles in javascriptFlow"{{{
    syntax keyword javascriptFlowCssStyles contained color font fontFamily fontSize fontSizeAdjust fontStretch fontStyle fontVariant fontWeight letterSpacing lineBreak lineHeight quotes rubyAlign rubyOverhang rubyPosition
    syntax keyword javascriptFlowCssStyles contained textAlign textAlignLast textAutospace textDecoration textIndent textJustify textJustifyTrim textKashidaSpace textOverflowW6 textShadow textTransform textUnderlinePosition
    syntax keyword javascriptFlowCssStyles contained unicodeBidi whiteSpace wordBreak wordSpacing wordWrap writingMode
    syntax keyword javascriptFlowCssStyles contained bottom height left position right top width zIndex
    syntax keyword javascriptFlowCssStyles contained border borderBottom borderLeft borderRight borderTop borderBottomColor borderLeftColor borderTopColor borderBottomStyle borderLeftStyle borderRightStyle borderTopStyle borderBottomWidth borderLeftWidth borderRightWidth borderTopWidth borderColor borderStyle borderWidth borderCollapse borderSpacing captionSide emptyCells tableLayout
    syntax keyword javascriptFlowCssStyles contained margin marginBottom marginLeft marginRight marginTop outline outlineColor outlineStyle outlineWidth padding paddingBottom paddingLeft paddingRight paddingTop
    syntax keyword javascriptFlowCssStyles contained listStyle listStyleImage listStylePosition listStyleType
    syntax keyword javascriptFlowCssStyles contained background backgroundAttachment backgroundColor backgroundImage gackgroundPosition backgroundPositionX backgroundPositionY backgroundRepeat
    syntax keyword javascriptFlowCssStyles contained clear clip clipBottom clipLeft clipRight clipTop content counterIncrement counterReset cssFloat cursor direction display filter layoutGrid layoutGridChar layoutGridLine layoutGridMode layoutGridType
    syntax keyword javascriptFlowCssStyles contained marks maxHeight maxWidth minHeight minWidth opacity MozOpacity overflow overflowX overflowY verticalAlign visibility zoom cssText
    syntax keyword javascriptFlowCssStyles contained scrollbar3dLightColor scrollbarArrowColor scrollbarBaseColor scrollbarDarkShadowColor scrollbarFaceColor scrollbarHighlightColor scrollbarShadowColor scrollbarTrackColor
"}}}
endif "DOM/HTML/CSS

" Highlight ways"{{{
syntax match javascriptFlowDotNotation "\."        nextgroup=javascriptFlowPrototype,javascriptFlowDomElemAttrs,javascriptFlowDomElemFuncs,javascriptFlowDOMMethods,javascriptFlowDOMProperties,javascriptFlowHtmlElemAttrs,javascriptFlowHtmlElemFuncs,javascriptFlowHtmlElemProperties,javascriptFlowAjaxProperties,javascriptFlowAjaxMethods,javascriptFlowPropietaryMethods,javascriptFlowEventListenerMethods skipwhite skipnl
syntax match javascriptFlowDotNotation "\.style\." nextgroup=javascriptFlowCssStyles
"}}}

"" end DOM/HTML/CSS specified things""}}}


"" Code blocks
syntax cluster javascriptFlowAll contains=javascriptFlowComment,javascriptFlowLineComment,javascriptFlowDocComment,javascriptFlowStringD,javascriptFlowStringS,javascriptFlowStringB,javascriptFlowRegexpString,javascriptFlowNumber,javascriptFlowFloat,javascriptFlowDecorators,javascriptFlowLabel,javascriptFlowSource,javascriptFlowType,javascriptFlowOperator,javascriptFlowBoolean,javascriptFlowNull,javascriptFlowFuncKeyword,javascriptFlowConditional,javascriptFlowGlobal,javascriptFlowRepeat,javascriptFlowBranch,javascriptFlowStatement,javascriptFlowGlobalObjects,javascriptFlowMessage,javascriptFlowIdentifier,javascriptFlowExceptions,javascriptFlowReserved,javascriptFlowDeprecated,javascriptFlowDomErrNo,javascriptFlowDomNodeConsts,javascriptFlowHtmlEvents,javascriptFlowDotNotation,javascriptFlowBrowserObjects,javascriptFlowDOMObjects,javascriptFlowAjaxObjects,javascriptFlowPropietaryObjects,javascriptFlowDOMMethods,javascriptFlowHtmlElemProperties,javascriptFlowDOMProperties,javascriptFlowEventListenerKeywords,javascriptFlowEventListenerMethods,javascriptFlowAjaxProperties,javascriptFlowAjaxMethods,javascriptFlowFuncArg

if main_syntax == "javascriptFlow"
  syntax sync clear
  syntax sync ccomment javascriptFlowComment minlines=200
" syntax sync match javascriptFlowHighlight grouphere javascriptFlowBlock /{/
endif

syntax keyword javascriptFlowFuncKeyword function
"syntax region javascriptFlowFuncDef start="function" end="\(.*\)" contains=javascriptFlowFuncKeyword,javascriptFlowFuncArg keepend
"syntax match javascriptFlowFuncArg "\(([^()]*)\)" contains=javascriptFlowParens,javascriptFlowFuncComma contained
"syntax match javascriptFlowFuncComma /,/ contained
" syntax region javascriptFlowFuncBlock contained matchgroup=javascriptFlowFuncBlock start="{" end="}" contains=@javascriptFlowAll,javascriptFlowParensErrA,javascriptFlowParensErrB,javascriptFlowParen,javascriptFlowBracket,javascriptFlowBlock fold

syn match javascriptFlowBraces "[{}\[\]]"
syn match javascriptFlowParens "[()]"
syn match javascriptFlowOpSymbols "=\{1,3}\|!==\|!=\|<\|>\|>=\|<=\|++\|+=\|--\|-="
syn match javascriptFlowEndColons "[;,]"
syn match javascriptFlowLogicSymbols "\(&&\)\|\(||\)"

" javascriptFlowFold Function {{{

" function! javascriptFlowFold()

" skip curly braces inside RegEx's and comments
syn region foldBraces start=/{/ skip=/\(\/\/.*\)\|\(\/.*\/\)/ end=/}/ transparent fold keepend extend

" setl foldtext=FoldText()
" endfunction

" au FileType javascriptFlow call javascriptFlowFold()

" }}}

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_javascriptFlow_syn_inits")
  if version < 508
    let did_javascriptFlow_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  "javascriptFlow highlighting
  HiLink javascriptFlowParameters Operator
  HiLink javascriptFlowSuperBlock Operator

  HiLink javascriptFlowEndColons Exception
  HiLink javascriptFlowOpSymbols Operator
  HiLink javascriptFlowLogicSymbols Boolean
  HiLink javascriptFlowBraces Function
  HiLink javascriptFlowParens Operator
  HiLink javascriptFlowComment Comment
  HiLink javascriptFlowLineComment Comment
  HiLink javascriptFlowRefComment Include
  HiLink javascriptFlowRefS String
  HiLink javascriptFlowRefD String
  HiLink javascriptFlowDocComment Comment
  HiLink javascriptFlowCommentTodo Todo
  HiLink javascriptFlowCvsTag Function
  HiLink javascriptFlowDocTags Special
  HiLink javascriptFlowDocSeeTag Function
  HiLink javascriptFlowDocParam Function
  HiLink javascriptFlowStringS String
  HiLink javascriptFlowStringD String
  HiLink javascriptFlowStringB String
  HiLink javascriptFlowInterpolationDelimiter Delimiter
  HiLink javascriptFlowRegexpString String
  HiLink javascriptFlowGlobal Constant
  HiLink javascriptFlowCharacter Character
  HiLink javascriptFlowPrototype Type
  HiLink javascriptFlowConditional Conditional
  HiLink javascriptFlowBranch Conditional
  HiLink javascriptFlowIdentifier Identifier
  HiLink javascriptFlowRepeat Repeat
  HiLink javascriptFlowStatement Statement
  HiLink javascriptFlowFuncKeyword Function
  HiLink javascriptFlowMessage Keyword
  HiLink javascriptFlowDeprecated Exception
  HiLink javascriptFlowError Error
  HiLink javascriptFlowParensError Error
  HiLink javascriptFlowParensErrA Error
  HiLink javascriptFlowParensErrB Error
  HiLink javascriptFlowParensErrC Error
  HiLink javascriptFlowReserved Keyword
  HiLink javascriptFlowOperator Operator
  HiLink javascriptFlowType Type
  HiLink javascriptFlowNull Type
  HiLink javascriptFlowNumber Number
  HiLink javascriptFlowFloat Number
  HiLink javascriptFlowDecorators Special
  HiLink javascriptFlowBoolean Boolean
  HiLink javascriptFlowLabel Label
  HiLink javascriptFlowSpecial Special
  HiLink javascriptFlowSource Special
  HiLink javascriptFlowGlobalObjects Special
  HiLink javascriptFlowExceptions Special

  HiLink javascriptFlowDomErrNo Constant
  HiLink javascriptFlowDomNodeConsts Constant
  HiLink javascriptFlowDomElemAttrs Label
  HiLink javascriptFlowDomElemFuncs PreProc

  HiLink javascriptFlowHtmlElemAttrs Label
  HiLink javascriptFlowHtmlElemFuncs PreProc

  HiLink javascriptFlowCssStyles Label

  " Ajax Highlighting
  HiLink javascriptFlowBrowserObjects Constant

  HiLink javascriptFlowDOMObjects Constant
  HiLink javascriptFlowDOMMethods Function
  HiLink javascriptFlowDOMProperties Special

  HiLink javascriptFlowAjaxObjects Constant
  HiLink javascriptFlowAjaxMethods Function
  HiLink javascriptFlowAjaxProperties Special

  HiLink javascriptFlowFuncDef Title
  HiLink javascriptFlowFuncArg Special
  HiLink javascriptFlowFuncComma Operator

  HiLink javascriptFlowHtmlEvents Special
  HiLink javascriptFlowHtmlElemProperties Special

  HiLink javascriptFlowEventListenerKeywords Keyword

  HiLink javascriptFlowNumber Number
  HiLink javascriptFlowPropietaryObjects Constant

  delcommand HiLink
endif

" Define the htmljavascriptFlow for HTML syntax html.vim
"syntax clear htmljavascriptFlow
"syntax clear javascriptFlowExpression
syntax cluster htmljavascriptFlow contains=@javascriptFlowAll,javascriptFlowBracket,javascriptFlowParen,javascriptFlowBlock,javascriptFlowParenError
syntax cluster javascriptFlowExpression contains=@javascriptFlowAll,javascriptFlowBracket,javascriptFlowParen,javascriptFlowBlock,javascriptFlowParenError,@htmlPreproc

let b:current_syntax = "javascriptFlow"
if main_syntax == 'javascriptFlow'
  unlet main_syntax
endif

" vim: ts=4
