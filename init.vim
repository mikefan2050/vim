call plug#begin('~/.vim/plugged')

Plug 'ludovicchabant/vim-gutentags'
"Plug 'skywind3000/asyncrun.vim'
Plug 'scrooloose/nerdtree'
Plug 'vivien/vim-linux-coding-style'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'terryma/vim-smooth-scroll'
Plug 'arithran/vim-delete-hidden-buffers'
Plug 'sheerun/vim-polyglot'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'mgee/lightline-bufferline'
Plug 'Shougo/deoplete-clangx'
Plug 'zchee/deoplete-jedi'
Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

call plug#end()

" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
  let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
  let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
if !isdirectory(s:vim_tags)
  silent! call mkdir(s:vim_tags, 'p')
endif

"let g:asyncrun_open = 6
"let g:asyncrun_bell = 1
"nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
"let g:autocmdsyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 

autocmd Vimenter * NERDTree
autocmd VimEnter * wincmd p
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinSize=28

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'tabline': {'left': [['buffers']], 'right': [['fan']]},
      \ 'active': {
      \   'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']],
      \   'right': [['lineinfo'], ['percent'], ['linter_warnings', 'linter_errors', 'linter_ok'], ['fileformat', 'fileencoding', 'filetype']],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \ },
      \ 'component': { 'fan': 'Fan' },
      \ 'component_expand': {
      \   'linter_warnings': 'LightlineLinterWarnings',
      \   'linter_errors': 'LightlineLinterErrors',
      \   'linter_ok': 'LightlineLinterOK',
      \   'buffers': 'lightline#bufferline#buffers',
      \ },
      \ 'component_type': {
      \   'readonly': 'error',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'ok',
      \   'buffers': 'tabsel',
      \ },
      \}

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ▲', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓' : ''
endfunction

"let timer = timer_start(1000, 'LightlineTimeUpdate', {'repeat':-1})
"function! LightlineTimeUpdate(timer)
"call lightline#update()
"endfunction

"function! LightlineTime() abort
"return '%{strftime("%H:%M")}'
"endfunction

set background=dark
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.tabline.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
let s:palette.inactive.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]


set noshowmode


let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_buffers_jump = 1
nnoremap <silent> <c-p> :FZF<cr>
nnoremap <silent> <c-P> :FZF ~<cr>

"let g:Lf_ShortcutF = '<c-p>'
"let g:Lf_ShortcutB = '<M-p>'
"noremap <c-n> :LeaderfMru<cr>
noremap <c-l> :LeaderfFunction<cr>
"noremap <M-n> :LeaderfBuffer<cr>
"noremap <M-m> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

let g:deoplete#enable_at_startup = 1
set completeopt-=preview

let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
let g:ale_sign_warning = '!'
"let g:ale_c_gcc_options = '-std=c11 -Wall'
map <c-M-j> :ALEPreviousWrap<CR>
map <c-M-k> :ALENextWrap<CR>


if has("cscope")
  set csprg=/usr/local/bin/cscope
  set csto=0
  set cst
  " add any database in current directory
  if filereadable("cscope.out")
    silent cs add cscope.out
    " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
    silent cs add $CSCOPE_DB
  endif
endif

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>a :cs find a <C-R>=expand("<cword>")<CR><CR>

set showtabline=2
set termguicolors
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
set updatetime=250
set number
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set clipboard+=unnamed
set ignorecase
map <C-j> :bprev<CR>
map <C-k> :bnext<CR>
set encoding=utf-8
