set nocompatible 
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'
Plugin 'sudar/vim-arduino-syntax'

call vundle#end() 
filetype plugin indent on

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

autocmd vimenter * NERDTree
autocmd VimEnter * wincmd p
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_auto_loc_list = 1
highlight YcmWarningLine guibg=#ffffcc
highlight YcmWarningSign guibg=#ffffcc
highlight YcmWarningSection guibg=#ffffcc

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#disable_refresh = 1
let g:airline#extensions#default#section_truncate_width = {
      \ 'b': 79,
      \ 'x': 60,
      \ 'y': 70,
      \ 'z': 45,
      \ 'warning': 80,
      \ 'error': 80,
      \ }

let g:tmuxline_powerline_separators = 0
let g:airline#extensions#tmuxline#enabled = 0
let g:tmuxline_preset = 'tmux'

set number
set expandtab
set softtabstop=2
set shiftwidth=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
set autoindent
syntax on
set clipboard+=unnamed
map <C-J> :bprev<CR>
map <C-K> :bnext<CR>
set mouse=a
