let s:logo_42 = [
			\"        :::      ::::::::",
			\"      :+:      :+:    :+:",
			\"    +:+ +:+         +:+  ",
			\"  +#+  +:+       +#+     ",
			\"+#+#+#+#+#+   +#+        ",
			\"     #+#    #+#          ",
			\"    ###   ########.fr    "
			\]

" Check former presence of valid header
 
function s:formerheader ()
	let s:match = [
				\'/\* \*\{74\} \*/',
				\'/\* \{76\}\*/',
				\'/\* \{48\}' . s:logo_42[0] . '   \*/',
				\'/\* \{3\}[[:graph:]]\+.c *' . s:logo_42[1] . '   \*/',
				\'/\* \{48\}' . s:logo_42[2] . '   \*/',
				\'/\* \{3\}By: [[:graph:]]\+ <[[:graph:]]\+> *' . s:logo_42[3] . '   \*/',
				\'/\* \{48\}' . s:logo_42[4] . '   \*/',
				\'/\* \{3\}[[:alpha:]]\{7\}: [[:digit:]]\{4\}\(/[[:digit:]]\{2\}\)\{2\} \([[:digit:]]\{2\}:\)\{2\}[[:digit:]]\{2\} by [[:graph:]]* *' . s:logo_42[5] . '   \*/',
				\'/\* \{3\}[[:alpha:]]\{7\}: [[:digit:]]\{4\}\(/[[:digit:]]\{2\}\)\{2\} \([[:digit:]]\{2\}:\)\{2\}[[:digit:]]\{2\} by [[:graph:]]* *' . s:logo_42[6] . '   \*/',
				\'/\* \{76\}\*/',
				\'/\* \*\{74\} \*/'
				\]	

	let l:i = 0
   	for line in getbufline('%', 0, 11)
       let l:str = matchstr(line, s:match[i])
       if strlen(l:str) == 0
           let l:i = 0
           break
       endif
       let l:i += 1
   	endfor

	if l:i != 11 
		call s:insert ()
	endif

endfunction

" main function

function s:insert ()

	let s:file = fnamemodify(bufname('%'),':t')
	let s:user = strpart($USER, 0, 9)
	let s:mail = strpart($MAIL, 0, (strlen(s:user) + 14))
	if !$MAIL
		let	s:mail = s:user . "@student.42.fr"
	endif	
	let s:comment = "/* "
	let s:endcomment = "   */"
	let s:endcomment2 = " */"
	let s:dateline = repeat(' ', (13 - strlen(s:user)))
	let s:stars = s:comment . repeat('*', 74) . s:endcomment2
	let s:user = strpart($USER, 0, 9)
	let s:void = s:comment . repeat(' ', 74) . s:endcomment2
	let s:void_42 = s:comment . repeat(' ', 47)
	let s:filename = s:comment . "  " . s:file . repeat(' ', 45 - strlen(s:file))
	let s:author = s:comment . "  By: " . s:user . " <" . s:mail . ">"
	let s:authorline =  s:author . repeat(' ', (46 - (8 + strlen(s:user) + strlen(s:mail))))
	let s:created = s:comment . "  Created: " . strftime ("%Y/%m/%d %H:%M:%S") . " by " . s:user

	call append (0, s:stars)
	call append (0, s:void)
	call append (0, "")
	call append (0, s:created . s:dateline . s:logo_42[5] . s:endcomment)
	call append (0, s:void_42 . s:logo_42[4] . s:endcomment)
	call append (0, s:authorline . s:logo_42[3] . s:endcomment)
	call append (0, s:void_42 . s:logo_42[2] . s:endcomment)
	call append (0, s:filename . s:logo_42[1] . s:endcomment)
	call append (0, s:void_42 . s:logo_42[0] . s:endcomment)
	call append (0, s:void)
	call append (0, s:stars)

	call s:insert_update ()

endfunction

" Insert the updated line

function s:insert_update ()

	let l:insert_update = s:comment . "  Updated: " . strftime ("%Y/%m/%d %H:%M:%S") . " by " . s:user

	call setline (9, l:insert_update . s:dateline . s:logo_42[6] . s:endcomment)

endfunction


" Update the date of last modification

function s:update ()
	let modified = getbufvar(bufname('%'), "&mod") 
	if modified == 1
		call s:insert_update ()
	endif

endfunction


command Header42 call s:formerheader ()
autocmd BufWritePre *.c call s:update ()
