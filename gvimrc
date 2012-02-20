if has("gui_macvim")

""""""""""""""""""""""""""""""""""""""""
" GUI settings
""""""""""""""""""""""""""""""""""""""""
set guioptions=egmt
set cursorline number
highlight Cursor guifg=white guibg=steelblue

""""""""""""""""""""""""""""""""""""""""
" MacVim key mappings
""""""""""""""""""""""""""""""""""""""""

macmenu Tools.List\ Errors key=<nop>
macmenu File.Open\.\.\. key=<nop>
macmenu File.Print key=<nop>
macmenu Tools.Spelling.Suggest\ Corrections key=<nop>

nunmap <C-i>
nunmap <C-o>
nmap <C-i> :LustyBufferExplorer<CR>
nmap <C-o> :LustyFilesystemExplorer<CR>

" delimitMate fixes for MacVim
" (see https://github.com/Raimondi/delimitMate/issues/63#issuecomment-3194225)
imap <M-Left> <Plug>delimitMateC-Left
imap <M-Right> <Plug>delimitMateC-Right
imap <D-Left> <Plug>delimitMateHome
imap <D-Right> <Plug>delimitMateEnd

" --- end ---
endif

