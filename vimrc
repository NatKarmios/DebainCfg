set nocompatible
filetype off
filetype plugin indent on
syntax on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'svermeulen/vim-easyclip'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'mbbill/undotree'
Plugin 'vim-syntastic/syntastic'
Plugin 'garbas/vim-snipmate'
Plugin 'mtth/scratch.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mileszs/ack.vim'
Plugin 'ervandew/supertab'
Plugin 'editorconfig/editorconfig-vim'
" Plugin 'vim-scripts/YankRing'

call vundle#end()
set modelines=0

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
set undofile

let mapleader = ","

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

set list
set listchars=tab:▸\ ,eol:¬

:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nnoremap ; :

au FocusLost * :wa

inoremap jj <ESC>

let g:rainbow_conf = {
            \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
            \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
            \   'operators': '_,_',
            \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \   'separately': {
            \       '*': {},
            \       'tex': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
            \       },
            \       'lisp': {
            \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
            \       },
            \       'vim': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
            \       },
            \       'html': {
            \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
            \       },
            \       'css': 0,
            \   }
            \}

nnoremap <leader>R :RainbowToggle

nnoremap <F5> :UndotreeToggle<CR>
nnoremap <F4> :NERDTreeToggle<CR>
autocmd FileType python nnoremap <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>
nnoremap <C-PageUp> :tabp<CR>
nnoremap <C-PageDown> :tabn<CR>

set t_Co=256

let g:airline_solarized_bg='dark'
let g:airline_theme='solarized'

set laststatus=2
let g:airline_powerline_fonts = 1

let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])


" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers=['eslint']

