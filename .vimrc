noremap <silent> <F11> :cal VimCommanderToggle()<CR>
syn on
"set nu
set si
set hls
set smartindent
set hid
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set bufhidden=hide
set nowrap
set laststatus=2
set ruler
set backspace=indent,eol,start
set formatoptions=croq
set sm
set printoptions=number:y,paper:letter
set pfn=:h9
set incsearch
set foldmethod=syntax
" vertical splitting will open the new window on the right. 
set splitright
"http://vim.wikia.com/wiki/Highlight_current_line
set cursorline
set ruler
set bg=light
set ic
set fileencodings=ucs-bom,utf-8,latin2
map <F12> :set number!<CR>
"set noexpandtab
"au GUIEnter * simalt ~x
let Tlist_Inc_Winwidth = 0
filetype plugin on
set omnifunc=syntaxcomplete#Complete


	" vim -b : edit binary using xxd-format!
	augroup Binary
	  au!
	  au BufReadPre  *.bin,*.dgr,*.exe let &bin=1
	  au BufReadPost *.bin,*.dgr,*.exe if &bin | %!xxd
	  au BufReadPost *.bin,*.dgr,*.exe set ft=xxd | endif
	  au BufWritePre *.bin,*.dgr,*.exe if &bin | %!xxd -r
	  au BufWritePre *.bin,*.dgr,*.exe endif
	  au BufWritePost *.bin,*.dgr,*.exe if &bin | %!xxd
	  au BufWritePost *.bin,*.dgr,*.exe set nomod | endif
	augroup END
  
function! <SID>SwitchPSCStyle() 
  if exists("g:colors_name") 
    if g:colors_name == 'ps_color'
      if exists("g:psc_style") 
        if g:psc_style == 'cool' 
          let g:psc_style = 'warm' 
        elseif g:psc_style == 'warm' 
          let g:psc_style = 'cool' 
        endif 
      else 
        let g:psc_style = 'warm' 
      endif 
    endif
  endif
endfunction 




function! <SID>SwitchColorSchemes() 
  if exists("g:colors_name") 
    if g:colors_name == 'default' 
      colorscheme elflord
    elseif g:colors_name == 'elflord' 
      colorscheme desert 
    elseif g:colors_name == 'desert' 
      colorscheme ps_color 
    elseif g:colors_name == 'ps_color' 
      colorscheme shine 
    elseif g:colors_name == 'shine' 
      colorscheme seashell 
    elseif g:colors_name == 'seashell' 
      colorscheme default 
    endif 
  else
    colorscheme elflord  
  endif 
endfunction 


                                                                              
map <silent> <F7> :call <SID>SwitchPSCStyle()<CR>  
map <silent> <F6> :call <SID>SwitchColorSchemes()<CR> 

runtime ftplugin/man.vim


if has('autocmd')
  function! ConvertHtmlEncoding(encoding)
    if a:encoding ==? 'gb2312'
      return 'cp936'            " GB2312 imprecisely means CP936 in HTML
    elseif a:encoding ==? 'iso-8859-1'
      return 'latin1'           " The canonical encoding name in Vim
    elseif a:encoding ==? 'utf8'
      return 'utf-8'            " Other encoding aliases should follow here
    else
      return a:encoding
    endif
  endfunction

  function! DetectHtmlEncoding()
    if &filetype != 'html'
      return
    endif
    normal m`
    normal gg
    if search('\c<meta http-equiv=\("\?\)Content-Type\1 content="text/html; charset=[-A-Za-z0-9_]\+">') != 0
      let reg_bak=@"
      normal y$
      let charset=matchstr(@", 'text/html; charset=\zs[-A-Za-z0-9_]\+')
      let charset=ConvertHtmlEncoding(charset)
      normal ``
      let @"=reg_bak
      if &fileencodings == ''
        let auto_encodings=',' . &encoding . ','
      else
        let auto_encodings=',' . &fileencodings . ','
      endif
      if charset !=? &fileencoding &&
        \auto_encodings =~ ',' . &fileencoding . ','
        silent! exec 'e ++enc=' . charset
      endif
    else
      normal ``
    endif
  endfunction

" Detect charset encoding in an HTML file
  au BufReadPost *.htm* nested      call DetectHtmlEncoding()
endif

:au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" Toggle fold state between closed and opened.
"
" If there is no fold at current line, just moves forward.
" If it is present, reverse it's state.
fun! ToggleFold()
  if foldlevel('.') == 0
    normal! l
  else
    if foldclosed('.') < 0
      . foldclose
    else
      . foldopen
    endif
  endif
  " Clear status line
  echo
endfun

" Map this function to Space key.
noremap <space> :call ToggleFold()<CR>



" vimplate configuration
let Vimplate = "$HOME/.vim/vimplate"


set guifont=Free\ Courier\ Medium\ 7


