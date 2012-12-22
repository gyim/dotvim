""""""""""""""""""""""""""""""""""""""""
" Init Vundle
""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype on
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

""""""""""""""""""""""""""""""""""""""""
" Bundles
""""""""""""""""""""""""""""""""""""""""

Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-foreplay'

Bundle 'kien/ctrlp.vim'
Bundle 'sjbach/lusty'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-powerline'
"Bundle 'kana/vim-smartinput'
Bundle 'mileszs/ack.vim'
Bundle 'Shougo/unite.vim'
Bundle 'h1mesuke/unite-outline'
Bundle 'godlygeek/tabular'
Bundle 'gregsexton/gitv'
Bundle 'vimoutliner/vimoutliner'
Bundle 'wlangstroth/vim-racket'
Bundle 'guns/vim-clojure-static'
Bundle 'kien/rainbow_parentheses.vim'

" vim-scripts.org
Bundle 'a.vim'
Bundle 'taglist.vim'
Bundle 'JavaBrowser'

" Colorschemes
Bundle 'Wombat'
Bundle 'moria'

""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
set wildignore=*.o,*.a,*.swp,*.egg-info,*.pyc,*.class,Session.vim
set noswapfile nobackup
set autoread
set noeol binary "do not leave an empty line at the end of file"
set wildmenu
set laststatus=2
set encoding=utf-8
set previewheight=15
set incsearch
"do not reindent hashmark lines
inoremap # X#

" Suppress warnings
set hidden
let g:LustyExplorerSuppressRubyWarning = 1
set visualbell

""""""""""""""""""""""""""""""""""""""""
" Editing
""""""""""""""""""""""""""""""""""""""""
set sw=4 ts=4 softtabstop=4
set nowrap
set backspace=indent,eol,start
set ignorecase
let delimitMate_expand_cr = 1
set tags=./tags;$HOME

""""""""""""""""""""""""""""""""""""""""
" GUI settings
""""""""""""""""""""""""""""""""""""""""
syntax on
let moria_style = 'black'
colorscheme tomorrow_night_bright
colorscheme vo_dark
set guifont=Monaco:h12
let g:Powerline_symbols = 'compatible'
set noantialias
set relativenumber
set mouse=a
set colorcolumn=80

" good colorschemes: tomorrow_night_bright moria wombat slate desert pyte mayansmoke

let g:NERDTreeDirArrows=0

""""""""""""""""""""""""""""""""""""""""
" Key mappings
""""""""""""""""""""""""""""""""""""""""

function ToggleCopyMode()
	if &colorcolumn > 0
		set colorcolumn=0 norelativenumber
	else
		set colorcolumn=80 relativenumber
	endif
endfunction

" Commands
if has('ruby')
	nmap <C-l> :LustyBufferExplorer<CR>
	nmap <leader>O :LustyFilesystemExplorer<CR>
else
	nmap <C-l> :Unite buffer<CR>
	nmap <leader>O :Unite file<CR>
endif

nmap <A-D-Up> :A<CR>
nmap <leader>n :NERDTree<CR>
nmap <leader>o :Unite outline<CR>
nmap <leader>uo :Unite file<CR>
nmap <leader>ui :Unite buffer<CR>
nmap <leader>L :call ToggleCopyMode()<CR>
nmap <leader>U :execute "Ack '" . expand("<cword>") . "'" <CR>

" Switch between buffers
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l
nmap <leader>i :only<CR>

" Buffer management
nmap <leader>d :bp<bar>sp<bar>bn<bar>bd<CR>

" Command-mode navigation
nmap <C-k> 5k
nmap <C-j> 5j

" Better indent
nmap <D-[> <<
nmap <D-]> >>
vnoremap < <gv
vnoremap > >gv
vmap <D-[> <gv
vmap <D-]> >gv
imap <D-[> <ESC><<
imap <D-]> <ESC>>>

" Better newline
imap <M-CR> <Esc>o
imap <C-CR> <Esc>A;<CR>
imap <C-S-CR> <Esc>A {<CR>
imap <D-CR> <Esc>A;<CR>
imap <D-S-CR> <Esc>A {<CR>

" Insert mode navigation
imap <C-l> <Esc>A

" Git commands
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gd :Gdiff<cr>
nnoremap <Leader>gD :diffoff!<cr><c-w>h:bd<cr>

" Unimpaired for tabs
nmap [p :tabprev<CR>
nmap ]p :tabnext<CR>

" Fold helpers
nmap <Space> za

""""""""""""""""""""""""""""""""""""""""
" Commands
""""""""""""""""""""""""""""""""""""""""
command! -nargs=1 SO SessionOpen <args>
command! SS SessionSave
command! SL SessionList
command! SA SessionSaveAs
command! SC SessionClose

""""""""""""""""""""""""""""""""""""""""
" Fold settings
""""""""""""""""""""""""""""""""""""""""
set foldmethod=syntax

fu! CustomFoldText()
	"get first non-blank line
	let fs = v:foldstart
	while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
	endwhile
	if fs > v:foldend
		let line = getline(v:foldstart)
	else
		let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
	endif

	let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
	let foldSize = 1 + v:foldend - v:foldstart
	let foldSizeStr = " [" . foldSize . " lines] "
	let foldLevelStr = repeat("+--", v:foldlevel)
	let lineCount = line("$")
	let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr))
	return line . expansionString . foldSizeStr . foldLevelStr
endf

set foldtext=CustomFoldText()

""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""
" Ctrl-P
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|build/.*$\|doc/.*$'

" Fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete

""""""""""""""""""""""""""""""""""""""""
" Language-specific settings
""""""""""""""""""""""""""""""""""""""""

" C / Objective-C
function! FoldPragma()
	setl foldmethod=expr
	setl foldexpr=getline(v:lnum)=~'^\s*#pragma\ mark\ -'
	setl foldminlines=0
	setl foldtext='----'
	setl foldlevel=0
	"set foldclose=all
endfunction
"au FileType c,objc,cpp call FoldPragma()
au FileType c,objc,cpp set noexpandtab
au FileType c,objc,cpp set commentstring=//%s
au FileType c,objc,cpp set foldnestmax=1
"au FileType c,objc,cpp nmap [l ?^#pragma mark -<CR>
"au FileType c,objc,cpp nmap ]l /^#pragma mark -<CR>

" Python
au FileType python set expandtab
au FileType python imap <C-CR> <Esc>o
au FileType python imap <C-S-CR> <Esc>A:<CR>
au FileType python imap <D-CR> <Esc>o
au FileType python imap <D-S-CR> <Esc>A:<CR>

" Ruby
au FileType ruby set expandtab sw=2 ts=2 softtabstop=2
au FileType ruby imap <C-CR> <Esc>o
au FileType ruby imap <C-S-CR> <Esc>oend<Esc>O
au FileType ruby imap <D-CR> <Esc>o
au FileType ruby imap <D-S-CR> <Esc>oend<Esc>O

" HTML / PHP
au FileType xml,html,php set smartindent
au FileType xml,html,php let b:delimitMate_matchpairs = "(:),[:],{:}"
au BufRead,BufNewFile *.tpl set filetype=html
au FileType php set foldlevel=1
au FileType php setl keywordprg=pman
let php_folding = 1
let php_sql_query = 1

" Markdown
au BufRead,BufNewFile *.md set filetype=markdown

" Vimoutliner
au FileType vo_base set foldlevel=1

" Clay
au BufRead,BufNewFile *.clay set filetype=clay
au FileType clay set cindent

function! FoldPageFeed()
	setl foldmethod=expr
	setl foldexpr=getline(v:lnum)[0]==\"\\<c-l>\"
	setl foldminlines=0
	setl foldtext='---\ new\ page\ '
	setl foldlevel=0
	set foldclose=all
endfunction

au FileType clay call FoldPageFeed()

" newLISP
au BufRead,BufNewFile *.lsp set filetype=newlisp autoindent lisp expandtab

" LLVM
au BufRead,BufNewFile *.ll set filetype=llvm smartindent

""""""""""""""""""""""""""""""""""""""""
" Other
""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on "required for Vundle