" 显示当前模式
set showmode
" 共享系统粘贴板
" set clipborad=unamed
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmode
set number
set relativenumber
set scrolloff=3
" 模拟的插件为 vim-surround 提供快捷的对操作。比如添加括号，双引号等等
set surround
" Move half page faster
nnoremap <Space>d  <C-d>
nnoremap <Space>u  <C-u>


" Insert mode shortcut
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>

" Yank to the end of line
nnoremap Y y$

" Auto indent pasted text
" nnoremap p p=`]<C-o>

" 设置前导键
let mapleader=";"
" 定义快速跳转
nmap <Leader>t <C-]>
" 定义快速跳转回退
nmap <Leader>T <C-t>

" Quit insert mode
inoremap jj <esc>

" Quit visual mode
vnoremap v <esc>
" copy and paste
" noremap <Leader>y "y
" nnoremap <Leader>p "p
" nnoremap <Leader>P "+p
" nnoremap Y "+y
" 复制到系统剪贴板
vnoremap Y "+y
vnoremap P "+p
vnoremap <C-c> "+y
vnoremap <C-v> "+p
"设置快捷键将系统剪贴板内容粘贴至 vim
noremap <C-v> "+p
" noremap sgp "+gp
