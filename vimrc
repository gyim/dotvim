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
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-speeddating'

Bundle 'kien/ctrlp.vim'
Bundle 'sjbach/lusty'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Raimondi/delimitMate'
Bundle 'mileszs/ack.vim'
Bundle 'Shougo/unite.vim'
Bundle 'h1mesuke/unite-outline'

" vim-scripts.org
Bundle 'a.vim'

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

" Suppress warnings
set hidden
let g:LustyExplorerSuppressRubyWarning = 1
set visualbell

" GUI settings
set guioptions=egmt
if has('gui')
	set cursorline number
	highlight Cursor guifg=white guibg=steelblue
endif

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
colorscheme moria
set guifont=Monaco:h12
let g:Powerline_symbols = 'compatible'
set noantialias

" good colorschemes: moria wombat slate desert pyte mayansmoke

let g:NERDTreeDirArrows=0

""""""""""""""""""""""""""""""""""""""""
" Key mappings
""""""""""""""""""""""""""""""""""""""""

" Commands
if has('ruby')
	nmap <C-l> :LustyBufferExplorer<CR>
	nmap <leader>O :LustyFilesystemExplorer<CR>
else
	nmap <C-l> :Unite buffer<CR>
	nmap <leader>O :Unite file<CR>
endif

nmap <A-D-Up> :A<CR>
nmap ,. :bnext<CR>
nmap ,m :bprev<CR>
nmap <leader>n :NERDTree<CR>
nmap <leader>o :Unite outline<CR>
nmap <leader>uo :Unite file<CR>
nmap <leader>ui :Unite buffer<CR>

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

""""""""""""""""""""""""""""""""""""""""
" Commands
""""""""""""""""""""""""""""""""""""""""
command! -nargs=1 SO SessionOpen <args>
command! SS SessionSave
command! SL SessionList
command! SA SessionSaveAs
command! SC SessionClose

""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""
" Ctrl-P
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

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
	set foldclose=all
endfunction
au FileType c,objc,cpp call FoldPragma()
au FileType c,objc,cpp set noexpandtab
au FileType c,objc,cpp set commentstring=//%s
au FileType c,objc,cpp nmap [l ?^#pragma mark -<CR>
au FileType c,objc,cpp nmap ]l /^#pragma mark -<CR>

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

" HTML
au FileType xml,html,php set smartindent
au FileType xml,html,php let b:delimitMate_matchpairs = "(:),[:],{:}"

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

""""""""""""""""""""""""""""""""""""""""
" Other
""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on "required for Vundle