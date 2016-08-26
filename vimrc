set nocompatible
filetype off

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/paredit.vim'
Plugin 'mikem/snipmate-snippets'
Plugin 'msanders/snipmate.vim'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/utl.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-markdown'
Plugin 'derekwyatt/vim-scala'

call vundle#end()

syntax enable
filetype plugin indent on

set formatoptions=l
set linebreak
set tabpagemax=25
set tabstop=2
set smarttab
set shiftwidth=2
set expandtab
set autoindent
set backspace=indent
set guifont="Monospace 10"
set hlsearch
set incsearch
set ruler
set list listchars=tab:\ \ ,trail:·
set scrolloff=3
set wildignore=*.class
set splitright
set spelllang=en
set spellfile=$HOME/.vim/spell/mike.uft-8.add

if has('gui_running')
  colorscheme github
else
  set t_Co=16
  set background=dark
  let g:solarized_visibility="low"
  colorscheme solarized
endif

let NERDSpaceDelims = 1
let g:NERDTreeWinSize = 20

let mapleader = ","
let maplocalleader = ";"

" Make Y consistent with D and C
map Y y$

" Previous/next quickfix file listings (e.g. search results)
map <M-D-Down> :cn<CR>
map <M-D-Up> :cp<CR>

" File tree browser
map <Leader>t :NERDTreeToggle<CR>

" File tree browser showing current file
map <Leader>T :NERDTreeFind<CR>

" Comment/uncomment lines
map <leader>/ <plug>NERDCommenterToggle
map <D-/> <plug>NERDCommenterToggle
imap <D-/> <Esc><plug>NERDCommenterToggle i

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
  "source ~/.vim/python_fold.vim
  set formatoptions+=roq
endfunction

function! PrepForRuby()
  set tabstop=2
  set shiftwidth=2
  set foldmethod=syntax
endfunction

function! PrepForCoffeeScript()
  set tabstop=2
  set shiftwidth=2
  set foldmethod=indent
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

function! PrepForCSS()
  setlocal iskeyword+=-
endfunction

au BufRead,BufNewFile {Gemfile*,Rakefile,Thorfile,config.ru} set ft=ruby
au BufRead,BufNewFile *.json set ft=javascript
au BufRead,BufNewFile *.cljs set ft=clojure
autocmd Filetype python call PrepForPython()
autocmd Filetype ruby,eruby call PrepForRuby()
autocmd Filetype coffee call PrepForCoffeeScript()
autocmd Filetype make call PrepForMakefile()
autocmd Filetype cs call PrepForCSharp()
autocmd Filetype cpp,c call PrepForCCPP()
autocmd Filetype css call PrepForCSS()
autocmd FileType clojure call TurnOnClojureFolding()

" Start with all folds open
autocmd Filetype ruby,coffee,clojure normal zR

" Strip trailing whitespace for code files on save
" C family
autocmd BufWritePre *.m,*.h,*.c,*.mm,*.cpp,*.hpp :%s/\s\+$//e

" Ruby, Rails
autocmd BufWritePre *.rb,*.yml,*.js,*.coffee,*.json,*.css,*.less,*.sass,*.html,*.xml,*.erb,*.haml,*.feature :%s/\s\+$//e

" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" ---------------------------------------------------------------------------
" Say you have layed out a complex window split structure, and want to
" temporarily open one window with max dimensions, but don't want to lose your
" split structure. The following function and mappings let you toggle between
" the split windows and on window maximized. The mappings prevent the default
" behavior of calling :only and losing your finely tuned splits.
"
" http://vim.wikia.com/wiki/Maximize_window_and_return_to_previous_split_structure

nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>

function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

" ---------------------------------------------------------------------------
" Automagic Clojure folding on defn's and defmacro's
"
" Blog post: http://writequit.org/blog/?p=413
" Copied from: https://gist.github.com/3049202
function GetClojureFold()
      if getline(v:lnum) =~ '^\s*(defn.*\s'
            return ">1"
      elseif getline(v:lnum) =~ '^\s*(def\(macro\|method\|page\|partial\).*\s'
            return ">1"
      elseif getline(v:lnum) =~ '^\s*(defmethod.*\s'
            return ">1"
      elseif getline(v:lnum) =~ '^\s*$'
            let my_cljnum = v:lnum
            let my_cljmax = line("$")

            while (1)
                  let my_cljnum = my_cljnum + 1
                  if my_cljnum > my_cljmax
                        return "<1"
                  endif

                  let my_cljdata = getline(my_cljnum)

" If we match an empty line, stop folding
                  if my_cljdata =~ '^$'
                        return "<1"
                  else
                        return "="
                  endif
            endwhile
      else
            return "="
      endif
endfunction

function TurnOnClojureFolding()
      setlocal foldexpr=GetClojureFold()
      setlocal foldmethod=expr
endfunction

" Simplify the fold display
function MinimalFoldText()
  return getline(v:foldstart)
endfunction
set foldtext=MinimalFoldText()
