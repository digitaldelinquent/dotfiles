" Plugins

call plug#begin()

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim'

call plug#end()

" Theme

let g:dracula_colorterm = 0
set termguicolors
colorscheme dracula
highlight Normal ctermbg=None

" Status Bar

let g:airline_theme='dracula'

" Don't try to be vi compatible

set nocompatible

" Helps force plugins to load correctly when it is turned back on below

filetype off

" Turn on syntax highlighting

syntax on

" For plugins to load correctly

filetype plugin indent on

set modelines=0

" Show line numbers

set number

" Show file stats

set ruler

" Blink cursor on error instead of beeping (grr)

set visualbell

" Cursor line and column

set cursorline
set cursorcolumn

" Encoding

set encoding=utf-8

" clipboard copy/paste

set clipboard=unnamed,unnamedplus

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Whitespace

set wrap

set textwidth=79

set formatoptions=tcqrn1

set tabstop=4

set shiftwidth=4

set softtabstop=4

set expandtab

set noshiftround

" Cursor motion

set scrolloff=3

set backspace=indent,eol,start

" use % to jump between pairs

set matchpairs+=<:>

runtime! macros/matchit.vim

" Move up/down editor lines

nnoremap j gj

nnoremap k gk

" Allow hidden buffers

set hidden

" Rendering

set ttyfast

" Status bar

set laststatus=2

" Last line

set showmode

set showcmd

" Searching

nnoremap / /\v

vnoremap / /\v

set hlsearch

set incsearch

set ignorecase

set smartcase

set showmatch

autocmd BufWritePost *.md !pandoc -s <afile> -o <afile>.pdf

map <leader><space> :let @/=''<cr> " clear search

" Remap help key.

inoremap <F1> <ESC>:set invfullscreen<CR>a

nnoremap <F1> :set invfullscreen<CR>

vnoremap <F1> :set invfullscreen<CR>

" Formatting

map <leader>q gqip

" Visualize tabs and newlines

set listchars=tab:▸\ ,eol:¬

" Uncomment this to enable by default:

" set list " To enable by default

" Or use your leader key + l to toggle on/off

map <leader>l :set list!<CR> " Toggle tabs and EOL
