""""""""""""""""""""""""""""""""""""""""
" Init Vundle
""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

if finddir('~/.vim/bundle/Vundle.vim') != ""
	call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'
	set regexpengine=1 " fix performance issues in Ruby
	set shell=/bin/bash
endif

""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""

if exists(':Plugin')
	Plugin 'tpope/vim-sensible'
	Plugin 'tpope/vim-fugitive'
	Plugin 'tpope/vim-commentary'
	Plugin 'tpope/vim-haml'
	Plugin 'tpope/vim-ragtag'
	Plugin 'tpope/vim-rails'
	Plugin 'tpope/vim-repeat'
	Plugin 'tpope/vim-surround'
	Plugin 'tpope/vim-unimpaired'
	Plugin 'tpope/vim-eunuch'
	Plugin 'tpope/vim-sleuth'
	Plugin 'tpope/vim-endwise'
	Plugin 'tpope/vim-fireplace'
	Plugin 'tpope/vim-vinegar'
	Plugin 'tpope/vim-projectionist'
	Plugin 'tpope/vim-leiningen'
	Plugin 'tpope/vim-rhubarb'
	Plugin 'tpope/vim-scriptease'
	Plugin 'tpope/vim-tbone'

	Plugin 'ctrlpvim/ctrlp.vim'
	Plugin 'gregsexton/gitv'
	Plugin 'guns/vim-sexp'
	Plugin 'kien/rainbow_parentheses.vim'
	Plugin 'guns/xterm-color-table.vim'
	Plugin 'junegunn/fzf'
	Plugin 'junegunn/fzf.vim'
	Plugin 'airblade/vim-gitgutter'

	Plugin 'fatih/vim-go'
	Plugin 'mattn/emmet-vim'
	Plugin 'JuliaLang/julia-vim'
	Plugin 'wting/rust.vim'
	Plugin 'vim-pandoc/vim-pandoc-syntax'
	Plugin 'hashivim/vim-terraform'
	Plugin 'will133/vim-dirdiff'
	Plugin 'pangloss/vim-javascript'
	Plugin 'mxw/vim-jsx'
	Plugin 'HerringtonDarkholme/yats.vim'
	Plugin 'Quramy/tsuquyomi'
	Plugin 'andreshazard/vim-freemarker'

	" Own plugins
	Plugin 'gyim/vim-boxdraw'

	call vundle#end()
endif

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""
set wildignore=*.o,*.a,*.swp,*.egg-info,*.pyc,*.class,Session.vim
set noswapfile nobackup
set noeol binary "do not leave an empty line at the end of file"
set encoding=utf-8
set previewheight=20
set ignorecase smartcase
set fileformats=unix,dos,mac
set hidden visualbell
set linebreak
set hlsearch
set splitright
set wildmode=full wildmenu
set cryptmethod=blowfish2
set updatetime=1000
let g:auto_save=0
let g:netrw_liststyle=0
let g:netrw_preview = 1
let g:jsx_ext_required = 0

""""""""""""""""""""""""""""""""""""""""
" Editing
""""""""""""""""""""""""""""""""""""""""
set sw=4 ts=4 sts=4
set nowrap breakindent
set tags=./tags;$HOME
set diffopt=filler

""""""""""""""""""""""""""""""""""""""""
" GUI settings
""""""""""""""""""""""""""""""""""""""""
syntax on
set guifont=Monaco:h12
set noantialias
set number
set relativenumber
set mouse=a ttymouse=sgr
nnoremap <A-LeftMouse> <LeftMouse><C-V>
set colorcolumn=80
silent! colorscheme tomorrow_night_bright

""""""""""""""""""""""""""""""""""""""""
" Key mappings
""""""""""""""""""""""""""""""""""""""""

" Commands
nnoremap <leader>U :execute "Ggrep '" . expand("<cword>") . "'" <CR>
nnoremap <silent> <leader>n :noh<CR>:pc<CR>:ccl<CR>
nnoremap <silent> <leader>m *<C-o>
nnoremap <silent> <leader>\ :Commentary<CR>
vnoremap <silent> <leader>\ :Commentary<CR>

" FZF mappings
nnoremap <leader>r :execute "Rg " . expand("<cword>") . "" <CR>
nnoremap <leader>b :execute "Buffers"<CR>
nnoremap <leader>f :execute "Files"<CR>
nnoremap <leader>C :execute "Commits"<CR>

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

" Clojure
nnoremap <silent><leader>sl :w<CR>:Slamhound<CR>
nnoremap <silent>cpR :w<CR>:Require<CR>
nnoremap <silent>cpo :w<CR>:Eval<CR>
let g:leiningen_no_auto_repl=1

" Go
nnoremap <leader>gt :w<CR>:GoTestFunc<CR>
nnoremap <leader>gT :w<CR>:GoTest<CR>
nnoremap <leader>gb :w<CR>:GoBuild<CR>
nnoremap <leader>gi :w<CR>:GoInstall<CR>

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
autocmd BufNewFile,BufRead fugitive://* set bufhidden=delete

" Netrw workaround
autocmd FileType netrw setl bufhidden=delete

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
iabbrev pybang #!/usr/bin/env python
iabbrev pybang3 #!/usr/bin/env python
iabbrev ifmain if __name__ == '__main__':<CR>    main()

" Ruby
au FileType ruby setl expandtab sw=2 ts=2 sts=2
au FileType ruby setl foldmethod=manual " fix performance issues
au BufRead,BufNewFile Vagrantfile* set filetype=ruby

" HTML / PHP
au FileType xml,html,php setl smartindent nocindent
au FileType php setl keywordprg=pman

" JavaScript
au BufRead,BufNewFile *.jsm setl filetype=javascript
au FileType javascript setl expandtab sw=2 ts=2 sts=2

" TypeScript
au FileType typescript setl foldmethod=manual

" Markdown
au BufRead,BufNewFile *.md setl filetype=markdown

" AsciiDoc
au BufRead,BufNewFile *.adoc setl filetype=asciidoc

" Clojure
if exists(':RainbowParenthesesToggle')
	au VimEnter * RainbowParenthesesToggle
	au Syntax clojure RainbowParenthesesLoadRound
	au Syntax clojure RainbowParenthesesLoadSquare
	au Syntax clojure RainbowParenthesesLoadBraces
endif
au FileType clojure set lispwords+=ns,fact,facts,into,for,doseq,when-let,when-some,when-not,if-let,for,doseq,fn,go,go-loop,while,loop,catch,binding,try,reify,condp,locking,doto,testing,local-job,remote-job,extend-protocol
au FileType clojure set lispwords-=do
au BufRead,BufNewFile *.pxi set filetype=clojure

" LLVM
au BufRead,BufNewFile *.ll setl filetype=llvm smartindent

" Shell script
iabbrev shbang #!/bin/bash

""""""""""""""""""""""""""""""""""""""""
" Other
""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on "required for Vundle

if filereadable($HOME . "/.vimrc.secret")
	source $HOME/.vimrc.secret
endif