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

Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-obsession'
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-vinegar'
Bundle 'tpope/vim-projectionist'
Bundle 'tpope/vim-leiningen'

Bundle 'kien/ctrlp.vim'
Bundle 'sjbach/lusty'
Bundle 'mileszs/ack.vim'
Bundle 'gregsexton/gitv'
Bundle 'wlangstroth/vim-racket'
Bundle 'guns/vim-clojure-static'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'guns/vim-slamhound'
" another rainbow plugin
"Bundle 'amdt/vim-niji'
Bundle 'Blackrush/vim-gocode'
Bundle 'mattn/zencoding-vim'
Bundle '907th/vim-auto-save'
Bundle 'tommcdo/vim-exchange'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'guns/xterm-color-table.vim'
Bundle 'tfnico/vim-gradle'

" vim-scripts.org
Bundle 'a.vim'
"Bundle 'paredit.vim'
Bundle 'spacewalk.vim'

""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
set wildignore=*.o,*.a,*.swp,*.egg-info,*.pyc,*.class,Session.vim
let delimitMate_expand_cr = 1
set noswapfile nobackup
set noeol binary "do not leave an empty line at the end of file"
set encoding=utf-8
set previewheight=15
set ignorecase smartcase
set fileformats=unix,dos,mac
set hidden visualbell
set linebreak
set hlsearch
set splitright
set wildmode=full wildmenu
let g:LustyExplorerSuppressRubyWarning=1
let g:auto_save=0

""""""""""""""""""""""""""""""""""""""""
" Editing
""""""""""""""""""""""""""""""""""""""""
set sw=4 ts=4 sts=4
set nowrap
set tags=./tags;$HOME

" Operator mappings
onoremap p i(
onoremap q i(
onoremap P :<c-u>normal! f(vi(<cr>
onoremap Q :<c-u>normal! f"vi"<cr>

""""""""""""""""""""""""""""""""""""""""
" GUI settings
""""""""""""""""""""""""""""""""""""""""
syntax on
set guifont=Monaco:h12
set noantialias
set number
set relativenumber
set mouse=a
set colorcolumn=80

" good colorschemes: tomorrow_night_bright moria wombat slate desert pyte mayansmoke
if !exists('g:loaded_colorschemes')
	let g:loaded_colorschemes=1
	colorscheme tomorrow_night_bright
endif

hi VertSplit ctermbg=235 guibg=black
hi StatusLine ctermfg=235 guifg=black ctermbg=black guibg=white
hi StatusLineNC ctermfg=234 guifg=black ctermbg=black guibg=white

""""""""""""""""""""""""""""""""""""""""
" Key mappings
""""""""""""""""""""""""""""""""""""""""

fu! ToggleCopyMode()
	if &colorcolumn > 0
		set colorcolumn=0 norelativenumber
	else
		set colorcolumn=80 relativenumber
	endif
endf

" Commands
if has('ruby')
	nnoremap <C-l> :LustyBufferExplorer<CR>
	nnoremap <leader>O :LustyFilesystemExplorer<CR>
endif

nnoremap <leader>L :call ToggleCopyMode()<CR>
nnoremap <leader>U :execute "Ack '" . expand("<cword>") . "'" <CR>
nnoremap <silent> <leader>n :noh<CR>

" Clipboard
nnoremap <leader>c "+y
nnoremap <leader>v "+p
nnoremap <leader>p "+p
nnoremap <leader>P "+P

vnoremap <leader>c "+y
vnoremap <leader>v "+p
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Buffer management
nnoremap [a :prev<CR>:args<CR>
nnoremap ]a :next<CR>:args<CR>
nnoremap <leader>d :bd<CR>
nnoremap ZD :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap ZC :cclose<CR> :pclose<CR>

" Git commands
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gd :Gdiff<cr>
nnoremap <Leader>gD :diffoff!<cr><c-w>h:bd<cr>

" Fold helpers
nnoremap <Space> za

" Jira
nmap <leader>j :call JiraBrowseTicket()<cr>
fu! JiraBrowseTicket()
	let ticket = expand("<cword>")
	call system("open http://jira.ustream-adm.in/browse/" . ticket)
endf

" Clojure
nnoremap <leader>sl :Slamhound<CR>

""""""""""""""""""""""""""""""""""""""""
" Fold settings
""""""""""""""""""""""""""""""""""""""""
set foldmethod=syntax foldnestmax=1 nofoldenable

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

" Mail
au FileType mail setl formatoptions+=aw wrap

" C/C++/Objective 
au FileType c,objc,cpp setl noexpandtab
au FileType c,objc,cpp setl commentstring=//%s

" Python
au FileType python setl expandtab

" Ruby
au FileType ruby setl expandtab sw=2 ts=2 sts=2
au BufRead,BufNewFile Vagrantfile set filetype=ruby

" HTML / PHP
au FileType xml,html,php setl smartindent nocindent
au FileType php setl keywordprg=pman

" Markdown
au BufRead,BufNewFile *.md setl filetype=markdown

" Vimoutliner
au FileType vo_base setl foldlevel=1 foldnestmax=5 foldenable

" Clojure
au VimEnter * RainbowParenthesesToggle
au Syntax clojure RainbowParenthesesLoadRound
au Syntax clojure RainbowParenthesesLoadSquare
au Syntax clojure RainbowParenthesesLoadBraces
au FileType clojure set lispwords+=fact,facts,into
let g:paredit_electric_return=0

" LLVM
au BufRead,BufNewFile *.ll setl filetype=llvm smartindent

""""""""""""""""""""""""""""""""""""""""
" Other
""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on "required for Vundle