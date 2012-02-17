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

" --- end ---
endif

