" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Turn on syntax highlighting.
syntax on

" Customize browser
:let g:netrw_browsex_viewer= "chrome"

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" Show cursor line
set cursorline

" highlight colors
hi TabLineFill ctermfg=Grey ctermbg=DarkGreen
hi TabLine ctermfg=DarkGreen ctermbg=Grey
hi TabLineSel ctermfg=Black ctermbg=LightGreen
hi StatusLineNC cterm=bold ctermfg=black ctermbg=gray
hi StatusLine cterm=bold ctermfg=black ctermbg=cyan
hi Pmenu ctermbg=Grey
hi PmenuSel cterm=bold ctermbg=Red ctermfg=white
hi MatchParen cterm=none ctermbg=grey ctermfg=blue

" Always show the stamus line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Show command
set showcmd

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Set color 
set background=dark

"learnvim defaults

set nocompatible               " NEVER change this! Use Vim mode, not vi mode.
filetype plugin indent on      " Enable automatic settings based on file type
syntax on                      " Enable colour syntax highlighting

""""""""""
" Options
""""""""""
" Use :help 'option (including the ' character) to learn more about each one.
"
" Buffer (File) Options:
set hidden                     " Edit multiple unsaved files at the same time
set confirm                    " Prompt to save unsaved changes when exiting
			       " Keep various histories between edits
set viminfo='1000,f1,<500,:100,/100,h

" Search Options:
set hlsearch                   " Highlight searches. See below for more.
set ignorecase                 " Do case insensitive matching...
set smartcase                  " ...except when using capital letters
set noincsearch                  " Incremental search (disabled)

" Insert (Edit) Options:
set backspace=indent,eol,start " Better handling of backspace key
set autoindent                 " Sane indenting when filetype not recognised
set nostartofline              " Emulate typical editor navigation behaviour
set nopaste                    " Start in normal (non-paste) mode
set pastetoggle=<f11>          " Use <F11> to toggle paste modes

" Status / Command Line Options:
set wildmenu                   " Better commandline completion
set wildmode=longest:full,full " Expand match on first Tab complete
set showcmd                    " Show (partial) command in status line.
set laststatus=2               " Always show a status line
set cmdheight=2                " Prevent "Press Enter" messages
			       " Show detailed information in status line
set statusline=%f%m%r%h%w\ [%n:%{&ff}/%Y]%=[0x\%04.4B][%03v][%p%%\ line\ %l\ of\ %L]

" Interface Options:
set number                     " Display line numbers at left of screen
set visualbell                 " Flash the screen instead of beeping on errors
set t_vb=                      " And then disable even the flashing
set mouse-=a                    " Enable mouse usage (all modes) in terminals (disabled)
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Indentation Options:
set tabstop=8                  " NEVER change this!
"e Change the '2' value below to your preferred indentation level
set shiftwidth=2               " Number of spaces for
set softtabstop=2              " ...each indent level set expandtab
set smarttab

"""""""
" Maps
"""""""
"
" F1 to be a context sensitive keyword-under-cursor lookup
nnoremap <F1> :help <C-R><C-W><CR>

" Reformat current paragraph
nnoremap Q gqip

" Move cursor between visual lines on screen
nnoremap <Up> gk
nnoremap <Down> gj

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Toggle search highlighting
nnoremap <C-Bslash>       :set hls!<bar>:set hls?<CR>
inoremap <C-Bslash>       <Esc>:set hls!<bar>:set hls?<CR>a

" Disable splash screen
set shortmess=I

" Autocompletion
set cot=menu,longest,preview
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

""""""""""""""""
" Auto commands
""""""""""""""""
"
if has("autocmd")
  augroup filetype
    " Remove ALL autocommands for the current group.
    autocmd!

    " Jump to last-known-position when editing files
    " Note: The | character is used in Vim as a command separator (like ; in C)
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  augroup END
endif


"vim plug

call plug#begin(('~/.vim/plugged'))
Plug 'https://github.com/tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/tpope/vim-unimpaired'
Plug 'https://github.com/tpope/vim-surround'
Plug 'junegunn/rainbow_parentheses.vim'
call plug#end()

"plugin settings
autocmd VimEnter * RainbowParentheses 
let g:rainbow#pairs = [['(', ')'], ['[', ']'],['{', '}']]
let g:rainbow#blacklist = ['#80a0ff',]
let g:rainbow#max_level = 14

set rtp+=~/.fzf
