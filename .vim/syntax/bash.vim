bplist00�_WebMainResource�	
_WebResourceMIMEType_WebResourceTextEncodingName_WebResourceFrameName^WebResourceURL_WebResourceDataZtext/plainUUTF-8P_1http://www.panix.com/~elflord/vim/syntax/bash.vimO)�<html><head></head><body><pre style="word-wrap: break-word; white-space: pre-wrap;">" Filename:	bash.vim
" Purpose:	Vim syntax file
" Language:	Bash - Unix Shell
" Maintainer:	Donovan Rebbechi elflord@pegasus.rutgers.edu
" URL:		http://pegasus.rutgers.edu/~elflord/vim/syntax/bash.vim
" Last update:	Tue Aug  4 09:02:08 EDT 1998
"
" Updated 1998 July 27
" 	Fixed bugs with embedded echos and command subs in bash
" Updated 1998 August 1
"	Changed Colouring. Added bash environment variables. Added keywords
"	and command options. 
" Updated 1998 August 2
"	Use awk syntax file
"	

" Remove any old syntax stuff hanging around

syn clear
if !exists("bash_minlines")
	let bash_minlines = 100
endif
if !exists("bash_maxlines")
	let bash_minlines = 2 * bash_minlines
endif



syn include @bashAwk &lt;sfile&gt;:p:h/awk.vim

syn region bashAwkBlockSingle matchgroup=bashStatement start=+g\=awk[ \t]*-[^ \t]*[ \t]*'{+ end=+}'+ contains=@bashAwk
syn region bashAwkBlockSingle matchgroup=bashStatement start=+g\=awk[ \t]*-[^ \t]*[ \t]*"{+ end=+}"+ contains=@bashAwk,bashDeref


" Comment out this to get less colour
" let hi_color=1

" bash syntax is case sensitive
syn case match

syn keyword	bashTodo		contained TODO
syn match	bashComment		"#.*$" contains=bashTodo

" String and Character constants
"===============================
syn match   bashNumber       "-\=\&lt;\d\+\&gt;"
syn match   bashSpecial      contained "\\\d\d\d\|\\[abcfnrtv]"
syn region  bashSinglequote matchgroup=bashOperator start=+'+ end=+'+ 
syn region  bashDoubleQuote      matchgroup=bashOperator start=+"+ skip=+\\"+ end=+"+ contains=bashDeref,bashCommandSub,bashSpecialShellVar,bashSpecial
syn match  bashSpecial  "\\[\\\"\'`$]"
	" This must be after the strings, so that bla \" be correct
syn region bashEmbeddedEcho contained matchgroup=bashStatement start="\&lt;echo\&gt;" skip="\\$" matchgroup=bashOperator end="$" matchgroup=NONE end="[&lt;&gt;;&amp;|`)]"me=e-1 end="\d[&lt;&gt;]"me=e-2 end="#"me=e-1 contains=bashNumber,bashSinglequote,bashDeref,bashSpecialVar,bashSpecial,bashOperator,bashDoubleQuote
 	" This one is needed INSIDE a CommandSub, so that
 	" `echo bla` be correct
syn region bashEcho matchgroup=bashStatement start="\&lt;echo\&gt;" skip="\\$" matchgroup=bashOperator end="$" matchgroup=NONE end="[&lt;&gt;;&amp;|]"me=e-1 end="\d[&lt;&gt;]"me=e-2 end="#"me=e-1 contains=bashNumber,bashCommandSub,bashSinglequote,bashDeref,bashSpecialVar,bashSpecial,bashOperator,bashDoubleQuote,bashDotStrings,bashFileNames

"Error Codes
syn match   bashDoError "\&lt;done\&gt;"
syn match   bashIfError "\&lt;fi\&gt;"
syn match   bashInError "\&lt;in\&gt;"
syn match   bashCaseError ";;"
syn match   bashEsacError "\&lt;esac\&gt;"
syn match   bashCurlyError "}"
syn match   bashParenError ")"
if exists("is_kornshell")
syn match     bashDTestError "]]"
endif
syn match     bashTestError "]"
  
" Tests
"======
syn region  bashNone transparent matchgroup=bashOperator start="\[" skip=+\\\\\|\\$+ end="\]" contains=ALLBUT,bashFunction,bashTestError,bashIdentifier,bashCase,bashDTestError,bashDerefOperator,@bashSedStuff
syn region  bashNone transparent matchgroup=bashStatement start="\&lt;test\&gt;" skip=+\\\\\|\\$+ matchgroup=NONE end="[;&amp;|]"me=e-1 end="$" contains=ALLBUT,bashFunction,bashIdentifier,bashCase,bashDerefOperator,@bashSedStuff
syn match   bashTestOpr contained "[!=]\|-.\&gt;\|-\(nt\|ot\|ef\|eq\|ne\|lt\|le\|gt\|ge\)\&gt;"

" DO/IF/FOR/CASE : Repitition operaters
" ======================================
syn region  bashDo transparent matchgroup=bashBlock start="\&lt;do\&gt;" end="\&lt;done\&gt;" contains=ALLBUT,bashFunction,bashDoError,bashCase,bashDerefOperator,@bashSedStuff
syn region  bashIf transparent matchgroup=bashBlock start="\&lt;if\&gt;" end="\&lt;fi\&gt;" contains=ALLBUT,bashFunction,bashIfError,bashCase,bashDerefOperator,@bashSedStuff
syn region  bashFor  matchgroup=bashStatement start="\&lt;for\&gt;" end="\&lt;in\&gt;" contains=ALLBUT,bashFunction,bashInError,bashCase,bashDerefOperator,@bashSedStuff
syn region bashCaseEsac transparent matchgroup=bashBlock start="\&lt;case\&gt;" matchgroup=NONE end="\&lt;in\&gt;"me=s-1 contains=ALLBUT,bashFunction,bashCaseError nextgroup=bashCaseEsac,bashDerefOperator,@bashSedStuff
syn region bashCaseEsac matchgroup=bashBlock start="\&lt;in\&gt;" end="\&lt;esac\&gt;" contains=ALLBUT,bashFunction,bashCaseError,bashDerefOperator,@bashSedStuff
syn region bashCase matchgroup=bashBlock contained start=")"  end=";;" contains=ALLBUT,bashFunction,bashCaseError,bashCase,bashDerefOperator,@bashSedStuff
syn region  bashNone transparent matchgroup=bashOperator start="{" end="}" contains=ALLBUT,bashCurlyError,bashCase,bashDerefOperator,@bashSedStuff
syn region  bashSubSh transparent matchgroup=bashOperator start="(" end=")" contains=ALLBUT,bashParenError,bashCase,bashDerefOperator,@bashSedStuff

" Misc
"=====
syn match   bashOperator		"[!&amp;;|=]"
syn match   bashWrapLineOperator	"\\$"
syn region  bashCommandSub   matchGroup=bashSpecial start="`" skip="\\`" end="`" contains=ALLBUT,bashFunction,bashCommandSub,bashTestOpr,bashCase,bashEcho,bashDerefOperator,@bashSedStuff
syn region  bashCommandSub matchgroup=bashOperator start="$(" end=")" contains=ALLBUT,bashFunction,bashCommandSub,bashTestOpr,bashCase,bashEcho,bashDerefOperator,@bashSedStuff
syn match   bashSource	"^\.\s"
syn match   bashSource	"\s\.\s"
syn region  bashColon	start="^\s*:" end="$\|" end="#"me=e-1 contains=ALLBUT,bashFunction,bashTestOpr,bashCase,bashDerefOperator,@bashSedStuff

" File redirection highlighted as operators
"==========================================
syn match	bashRedir	"\d\=&gt;\(&amp;[-0-9]\)\="
syn match	bashRedir	"\d\=&gt;&gt;-\="
syn match	bashRedir	"\d\=&lt;\(&amp;[-0-9]\)\="
syn match	bashRedir	"\d&lt;&lt;-\="

" Shell Input Redirection (Here Documents)
syn region bashHereDoc matchgroup=bashRedir start="&lt;&lt;-\=\s*\**END[a-zA-Z_0-9]*\**" matchgroup=bashRedir end="^END[a-zA-Z_0-9]*$"
syn region bashHereDoc matchgroup=bashRedir start="&lt;&lt;-\=\s*\**EOF\**" matchgroup=bashRedir end="^EOF$"

" Identifiers
"============
syn match  bashIdentifier "\&lt;[a-zA-Z_][a-zA-Z0-9_]*\&gt;="me=e-1
syn region bashIdentifier matchgroup=bashStatement start="\&lt;\(declare\|typeset\|local\|export\|set\|unset\)\&gt;[^/]"me=e-1 matchgroup=bashOperator skip="\\$" end="$\|[;&amp;]" matchgroup=NONE end="#\|="me=e-1 contains=bashTestError,bashCurlyError,bashWrapLineOperator,bashDeref

		" The [^/] in the start pattern is a kludge to avoid bad
		" highlighting with cd /usr/local/lib...

syn region  bashFunction transparent matchgroup=bashFunctionName 	start="^\s*\&lt;[a-zA-Z_][a-zA-Z0-9_]*\&gt;\s*()\s*{" end="}" contains=ALLBUT,bashFunction,bashCurlyError,bashCase,bashDerefOperator,@bashSedStuff

" CHanged this
syn region bashDeref	     start="\${" end="}" contains=bashDerefOperator,bashSpecialVariables
syn match  bashDeref	     "\$\&lt;[a-zA-Z_][a-zA-Z0-9_]*\&gt;" contains=bashSpecialVariables

" A bunch of useful bash keywords
syn keyword bashStatement    break cd chdir continue eval exec exit kill newgrp pwd read readonly return shift test trap ulimit umask wait bg fg jobs stop suspend alias fc getopts hash history let print time times type whence unalias source bind builtin dirs disown enable help history logout popd pushd shopt login newgrp gnugrep grep egrep fgrep du find gnufind expr tail sort clear less sleep ls rm install chmod mkdir rmdir strip rpm mv touch sed
syn keyword bashAdminStatement killproc daemon start stop restart reload status killall nice
syn keyword bashConditional  else then elif while
syn keyword bashRepeat       select until
syn keyword bashFunction     function

" Syncs
" =====
if !exists("bash_minlines")
  let bash_minlines = 100
endif
exec "syn sync minlines=" . bash_minlines
syn sync match bashDoSync       grouphere  bashDo       "\&lt;do\&gt;"
syn sync match bashDoSync       groupthere bashDo       "\&lt;done\&gt;"
syn sync match bashIfSync       grouphere  bashIf       "\&lt;if\&gt;"
syn sync match bashIfSync       groupthere bashIf       "\&lt;fi\&gt;"
syn sync match bashForSync      grouphere  bashFor      "\&lt;for\&gt;"
syn sync match bashForSync      groupthere bashFor      "\&lt;in\&gt;"
syn sync match bashCaseEsacSync grouphere  bashCaseEsac "\&lt;case\&gt;"
syn sync match bashCaseEsacSync groupthere bashCaseEsac "\&lt;esac\&gt;"

syn match bashDerefOperator contained  +##\=\|%%\=+



" command line options

syn match bashCommandOpts "\(--\=\|+\)\([a-zA-Z]\)\=\([a-zA-Z0-9]\)*"

" special variables
if exists("is_bash")
syn keyword bashSpecialVariables contained PPID PWD OLDPWD REPLY UID EUID GROUPS BASH BASH_VERSION BASH_VERSINFO SHLVL RANDOM SECONDS LINENO HISTCMD DIRSTACK PIPESTATUS OPTARG OPTIND HOSTNAME HOSTTYPE OSTYPE MACHTYPE SHELLOPTS IFS PATH HOME CDPATH BASH_ENV MAIL MAILCHECK PS1 PS2 PS3 PS4 TIMEFORMAT HISTSIZE HISTFILE HISTFILESIZE LANG LC_ALL LC_COLLATE LC_MESSAGES PROMPT_COMMAND IGNOREEOF TIMEOUT FCEDIT FIGNORE GLOBIGNORE INPUTRC HISTCONTROL histchars HOSTFILE auto_resume HISTIGNORE OPTERR MAILPATH 
endif
syn match  bashSpecialShellVariables "\$[-#@*$?!0-9]"

" The default methods for highlighting.  Can be overridden later


if !exists("did_bash_syntax_inits")
  let did_bash_syntax_inits = 1
  hi link bashAdminStatement	Function
  hi link bashBlock		Function
  hi link bashCaseError		Error
  hi link bashColon		bashStatement
  hi link bashCommandOpts	Operator
  hi link bashComment 		Comment
  hi link bashConditional 	Conditional
  hi link bashCurlyError	Error
  hi link bashDeref		bashShellVariables
  hi link bashDerefOperator 	bashOperator
  hi link bashDoError		Error
  hi link bashDoubleQuote	bashString
  hi link bashEcho		bashString
  hi link bashEmbeddedEcho	bashString
  hi link bashEsacError		Error
  hi link bashFunction	        Function
  hi link bashFunctionName	Function
  hi link bashHereDoc		bashString
  hi link bashIdentifier	Identifier
  hi link bashIfError		Error
  hi link bashInError		Error
  hi link bashNumber		Number
  hi link bashOperator		Operator
  hi link bashParenError	Error
  hi link bashRedir		bashOperator
  hi link bashRepeat		Repeat
  hi link bashShellVariables	PreProc
  hi link bashSinglequote	bashString
  hi link bashSource		bashOperator
  hi link bashSpecial		Special
  hi link bashSpecial		Special
  hi link bashSpecialShellVar	bashSpecialVariables
  hi link bashSpecialVariables	bashSpecialVars
  hi link bashSpecialVars	Identifier
  hi link bashStatement		Statement
  hi link bashString		String
  hi link bashTestError		Error
  hi link bashTestOpr		bashConditional
  hi link bashTodo		Todo
  hi link bashVariables		PreProc
  hi link bashWrapLineOperator	bashOperator
endif
let b:current_syntax = "bash"

" vim: ts=8
</pre></body></html>    ( > \ s � � � � � �                           *�