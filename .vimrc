let g:glsl_file_extensions = '*.glsl,*.vsh,*.fsh,*.frag,*.vert'

execute pathogen#infect()

" Generic settings
set enc=utf-8
syntax on
filetype plugin indent on
set relativenumber
set number
set nowrap
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * set number | :set relativenumber

" golang
let $GOPATH = "/Users/perloennwege/Projects/go"

" NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowLineNumbers = 1

" CtrlP
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

" Tabs
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab

" Splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
set splitbelow
set splitright

" Tabular
let mapleader=','
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:/l0c1<CR>
vmap <Leader>a: :Tabularize /:/l0c1<CR>

" jsx
let g:jsx_ext_required = 1

" Eyecandy
if has('gui_running')
  set cursorline

  if has('win32')
    set guifont=PragmataPro:h10
  else
  set guifont=PragmataPro:h11
  endif

	" Turning off scrollbars
	set guioptions-=r
	set guioptions-=R
	set guioptions-=l
	set guioptions-=L
  set guioptions-=T
  set guioptions-=m
endif

" airline
let g:airline_powerline_fonts = 1

set background=dark
let g:gruvbox_contrast_dark = "hard"
color gruvbox
set fillchars=vert:\ 
hi NonText guifg=bg

" syntastic
autocmd bufwritepost *.js silent !semistandard % --format
set autoread
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_javascript_standard_exec = 'semistandard'
