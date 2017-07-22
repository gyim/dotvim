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
"Bundle 'tpope/vim-rsi'
Bundle 'tpope/vim-rhubarb'

Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'sjbach/lusty'
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/unite.vim'
Bundle 'mileszs/ack.vim'
Bundle 'gregsexton/gitv'
Bundle 'wlangstroth/vim-racket'
Bundle 'guns/vim-sexp'
"Bundle 'bhurlow/vim-parinfer'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'guns/vim-slamhound'
Bundle 'fatih/vim-go'
Bundle 'mattn/emmet-vim'
"Bundle 'jlanzarotta/bufexplorer'
Bundle 'guns/xterm-color-table.vim'
Bundle 'tfnico/vim-gradle'
Bundle 'JuliaLang/julia-vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'wting/rust.vim'
Bundle 'vim-pandoc/vim-pandoc-syntax'
Bundle 'shumphrey/fugitive-gitlab.vim'
Bundle 'will133/vim-dirdiff'

" vim-scripts.org
Bundle 'a.vim'

""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
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
let g:LustyExplorerSuppressRubyWarning=1
let g:auto_save=0
let g:netrw_liststyle=3

""""""""""""""""""""""""""""""""""""""""
" Editing
""""""""""""""""""""""""""""""""""""""""
set sw=4 ts=4 sts=4
set nowrap breakindent
set tags=./tags;$HOME
set diffopt=filler

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

" good colorschemes: tomorrow_night_bright solarized moria wombat slate desert pyte mayansmoke
if !exists('g:loaded_colorschemes')
	let g:loaded_colorschemes=1
	"silent! colorscheme solarized
	silent! colorscheme tomorrow_night_bright
	if $COLORFGBG =~ "11;15"
		set background=light
	else
		set background=dark
	endif
endif

hi VertSplit ctermbg=235 guibg=black
hi StatusLine ctermfg=235 guifg=black ctermbg=245 guibg=white
hi StatusLineNC ctermfg=234 guifg=black ctermbg=black guibg=white
hi TabLineFill ctermfg=235
hi TabLine ctermfg=235 ctermbg=245
hi TabLineSel ctermfg=gray ctermbg=black
hi DiffAdd ctermbg=22
hi DiffChange ctermbg=17
hi DiffText ctermbg=19
hi DiffDelete ctermbg=52

let g:rbpt_colorpairs = [
\ ['brown',       'RoyalBlue3'],
\ ['Darkblue',    'SeaGreen3'],
\ ['darkgray',    'DarkOrchid3'],
\ ['darkgreen',   'firebrick3'],
\ ['darkcyan',    'RoyalBlue3'],
\ ['darkred',     'SeaGreen3'],
\ ['darkmagenta', 'DarkOrchid3'],
\ ['brown',       'firebrick3'],
\ ['gray',        'RoyalBlue3'],
\ ['darkmagenta', 'DarkOrchid3'],
\ ['Darkblue',    'firebrick3'],
\ ['darkgreen',   'RoyalBlue3'],
\ ['darkcyan',    'SeaGreen3'],
\ ['darkred',     'DarkOrchid3'],
\ ['red',         'firebrick3'],
\ ]

""""""""""""""""""""""""""""""""""""""""
" Key mappings
""""""""""""""""""""""""""""""""""""""""

" Commands
if has('ruby')
nnoremap <C-l> :LustyBufferExplorer<CR>
nnoremap <leader>O :LustyFilesystemExplorer<CR>
endif

" Unite
"call unite#custom#source('file,file/new,buffer,file_rec', 'matchers', 'matcher_fuzzy')
"nnoremap <silent> <C-p> :<C-u>Unite -start-insert file_rec/git<CR>
"nnoremap <silent> <C-l> :<C-u>Unite buffer<CR>

nnoremap <leader>U :execute "Ggrep '" . expand("<cword>") . "'" <CR>
nnoremap <silent> <leader>n :noh<CR>
nnoremap <silent> <leader>o :ccl<CR>:pc<CR>:lcl<CR>

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
au BufRead,BufNewFile Vagrantfile* set filetype=ruby

" HTML / PHP
au FileType xml,html,php setl smartindent nocindent
au FileType php setl keywordprg=pman

" JavaScript
au BufRead,BufNewFile *.jsm setl filetype=javascript

" Markdown
au BufRead,BufNewFile *.md setl filetype=markdown

" AsciiDoc
au BufRead,BufNewFile *.adoc setl filetype=asciidoc

" Vimoutliner
au FileType vo_base setl foldlevel=1 foldnestmax=5 foldenable

" Clojure
au VimEnter * RainbowParenthesesToggle
au Syntax clojure RainbowParenthesesLoadRound
au Syntax clojure RainbowParenthesesLoadSquare
au Syntax clojure RainbowParenthesesLoadBraces
au FileType clojure set lispwords+=ns,fact,facts,into,for,doseq,when-let,when-some,when-not,if-let,for,doseq,fn,go,go-loop,while,loop,catch,binding,try,reify,condp,locking,doto,testing,local-job,remote-job,extend-protocol
au FileType clojure set lispwords-=do
au BufRead,BufNewFile *.pxi set filetype=clojure

" LLVM
au BufRead,BufNewFile *.ll setl filetype=llvm smartindent

""""""""""""""""""""""""""""""""""""""""
" Other
""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on "required for Vundle

if filereadable($HOME . "/.vimrc.secret")
	source $HOME/.vimrc.secret
endif
