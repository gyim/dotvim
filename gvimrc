if has("gui_macvim")

""""""""""""""""""""""""""""""""""""""""
" MacVim key mappings
""""""""""""""""""""""""""""""""""""""""

macmenu Tools.List\ Errors key=<nop>
macmenu File.Open\.\.\. key=<nop>
macmenu File.Print key=<nop>
macmenu Tools.Spelling.Suggest\ Corrections key=<nop>

set guioptions=egmt
if has('gui')
	set cursorline
	highlight Cursor guifg=white guibg=steelblue
endif

endif

