"Install all of the plugins
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'  "File tree
Plug 'vim-airline/vim-airline' "Airline bar at the bottom
"Plug 'flazz/vim-colorschemes'  "Used for the colorschemes
Plug 'w0rp/ale'  "Used for syntax error highlighting
Plug 'Yggdroot/indentLine'  "Indentation line guides
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }  "Fuzzy searching
Plug 'Chiel92/vim-autoformat'  "Autoformatter
Plug 'arcticicestudio/nord-vim'

"Python only
Plug 'davidhalter/jedi-vim'  "Useful things like jump to definition

call plug#end()

"Colors & syntax highlighting
syntax on  "Turn on syntax highlighting
filetype plugin indent on
color nord "Set the colorscheme

"Information on the following setting can be found with
":help set
set tabstop=4
set expandtab
set autoindent 
set shiftwidth=4  "this is the level of auto indent, adjust to taste
set ruler
set number relativenumber
set backspace=indent,eol,start
set encoding=utf-8

set visualbell
set colorcolumn=125
set splitright
set cursorline
set foldmethod=indent

"Set the swapfile location
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

"Spellcheck settings
set spelllang=en_us
set spell
hi clear SpellBad
hi SpellBad cterm=underline

"Use 256 colors
set t_Co=256

" Split boundary appearance
set fillchars+=vert:\ 
hi vertsplit guifg=fg guibg=bg

"set highlighting in searching. To temporarily turn it off use <C-L>.
"see mapping of <C-L>
set hlsearch

" Uncomment below to make screen not flash on error
set vb t_vb=""

" Sets the column limit indicator color
highlight ColorColumn ctermbg=black

" Remap some keys
:imap jj <Esc>

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR>
nnoremap <C-a> :FZF<CR>

"Nerdtree config
let g:NERDTreeDirArrows=0
nmap <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if ( winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() ) | q | endif

let NERDTreeIgnore=['\.o$', '\.a$', '^00', '^tags$', '\.d$', '\.pyc$', '__pycache__']


" Jedi config
" This is default, but it's here as a reference
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>q"

let g:jedi#use_splits_not_buffers = "right"

" FZF config
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Ale config
let g:ale_linters = {
\  'python': ['black', 'pylint'],
\  'Dockerfile': ['hadolint']
\}

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '--'
let g:airline#extensions#ale#enabled = 1
let g:ale_set_highlights = 1
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_set_signs = 1
let g:ale_lint_on_text_changed = 'always'

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction
set statusline=%{LinterStatus()}

"Autoformat config
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:formatters_python = ['black']
