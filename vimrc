set formatoptions=l
set lbr
set tabpagemax=25
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set guifont=Monospace\ 10
set hlsearch
set is
set ruler
set list listchars=tab:\ \ ,trail:·

call pathogen#runtime_append_all_bundles()

syntax on
colorscheme elflord

filetype off
" From VimClojure
filetype plugin indent on
"let vimclojure#ParenRainbow = 1
"let vimclojure#HighlightBuiltins = 1
"let vimclojure#DynamicHighlighting = 1
"let vimclojure#WantNailgun = 1
"let vimclojure#NailgunClient = "/home/mike/.vim/bundle/vimclojure/ng"
"let vimclojure#SplitSize = 10

" SnipMate
let g:snippets_dir="~/.vim/snippets"
source ~/.vim/snippets/support_functions.vim

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

function! PrepForPython()
  set tabstop=4
  set shiftwidth=4
  source ~/.vim/python_fold.vim
  set formatoptions+=roq
endfunction

function! PrepForRuby()
  set tabstop=2
  set shiftwidth=2
  set foldmethod=syntax
  "source ~/.vim/vim-ruby-folding-1.1.vim
endfunction

function! PrepForMakefile()
  set tabstop=4
  set shiftwidth=4
  set noexpandtab
endfunction

function! PrepForCSharp()
  set tabstop=4
  set shiftwidth=4
"  set noexpandtab
  source ~/.vim/csharp.vim
"  set foldmarker={,}
"  set foldmethod=marker
"  set foldtext=substitute(getline(v:foldstart),'{.*','{...}',)
"  set foldcolumn=4
"  set foldlevelstart=1
endfunction

function! PrepForCCPP()
  set tabstop=4
  set shiftwidth=4
  set noexpandtab
  set foldmethod=syntax
  " set listchars=tab:»\ ,trail:«,eol:$
  set listchars=tab:»\ 
endfunction

au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru} set ft=ruby
autocmd Filetype python call PrepForPython()
autocmd Filetype ruby call PrepForRuby()
autocmd Filetype eruby call PrepForRuby()
autocmd Filetype make call PrepForMakefile()
autocmd Filetype cs call PrepForCSharp()
autocmd Filetype cpp,c call PrepForCCPP()

" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
