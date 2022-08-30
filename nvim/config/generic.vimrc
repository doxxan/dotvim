set enc=utf-8
set relativenumber
set number
set nowrap
augroup auto_numbers
  autocmd!
  au InsertEnter * :set norelativenumber
  au InsertLeave * set number | :set relativenumber
augroup END

augroup basic_filetype_overrides
  autocmd!
  au FileType make set noexpandtab
  au FileType rust set ts=4 sw=4 sts=4
  au FileType c set ts=2 sw=2 sts=2
  au BufRead,BufNewFile *.rs set ts=4 sw=4 sts=4
  au BufRead,BufNewFile *.c set ts=2 sw=2 sts=2
  au BufRead,BufNewFile *.h set ts=2 sw=2 sts=2
augroup END

set nobackup
set noswapfile
set mouse=n
set path+=**
set wildmenu
filetype indent plugin on
syn on
set cc=120
set lazyredraw
set maxmempattern=20000

" Tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab

" Splits
set splitbelow
set splitright

" Autoreload changed files
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
set autoread
augroup auto_reload
  autocmd!
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
        \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
  autocmd FileChangedShellPost *
        \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END

" NOTE: Update to vim.lsp.buf.format() on nvim 0.8.0
augroup odin
  autocmd!
  " autocmd bufwritepre *.odin execute 'lua vim.lsp.buf.formatting_sync()'
  autocmd bufwritepost *.odin silent !odinfmt -w <afile>
augroup END

" project local vim config support
silent! so .vimlocal

" netrw
let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

" Eyecandy
set cursorline
augroup dynamic_cursorline
  autocmd!
  autocmd WinEnter,BufEnter,BufWinEnter * set cursorline
  autocmd WinLeave,BufLeave,BufWinLeave * set nocursorline
augroup END
set termguicolors
let &t_ut=''
" set background=light
" color edge
set background=dark
colorscheme palenight
set fillchars=vert:\│
hi! VertSplit guifg=darkgray

" Markdown
let g:markdown_fenced_languages = ['html']

" GLSL
augroup custom_glsl_types
  autocmd!
  autocmd BufNewFile,BufRead *.glsl set filetype=glsl
  autocmd BufNewFile,BufRead *.frag set filetype=glsl
  autocmd BufNewFile,BufRead *.vert set filetype=glsl
augroup END

" Make
nnoremap <leader>m :echo "Building..."\|make\|redraw\|botright cwindow\|echo "Done!"<CR>

" signs
set signcolumn=auto:2

" prettier
let g:prettier#autoformat_require_pragma=0
let g:prettier#autoformat_config_present=1

" easymotion
map <Leader>. <Plug>(easymotion-prefix)
