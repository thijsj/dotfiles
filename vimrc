" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

"
" From http://vim.wikia.com/wiki/Integration_with_PyUnit_testing_framework
" now use :make to run the alltests.py
if has("autocmd")
  au BufRead,BufNewFile *.py,*pyw compiler pyunit
  au BufRead,BufNewFile *.py,*pyw setlocal makeprg=./alltests.py
endif

" Make crosswalk rules and slowfoot files look like python
" http://www.xnote.com/forums/viewthread.php?tid=87
if has("autocmd")
    augroup ext
        autocmd BufRead,BufNewFile *.rules,*.sf set filetype=python
    augroup END
endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
if has("autocmd")
  filetype indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd     " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set incsearch       " Incremental search
set autowrite       " Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set nohlsearch      " Disable hlsearch

set tabstop=4
set shiftwidth=4
set autoindent
set expandtab
set nu
set modeline
set modelines=5

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

let username = $REMOTE_USERNAME
if empty(username)
    let username = $USER
endif

let userconfigfile = $HOME . "/.thijsj-vim/" . username
if filereadable(userconfigfile)
    call vundle#begin($HOME . "/.thijsj-vim-data/")
    exe "source " . userconfigfile
else
    call vundle#begin()
endif

if $VIM_OPTIONS != ""
    exe $VIM_OPTIONS
endif

autocmd  FocusGained Makefile  :set expandtabs !
autocmd  FocusLost Makefile  :set expandtabs

" ###

set encoding=utf-8
set nocompatible              " be iMproved, required
filetype off                  " required

" System OS name
let s:uname = system("echo -n $(uname -s)")

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Use Ctrl + P to open files.
Bundle 'https://github.com/ctrlpvim/ctrlp.vim'

" SuperTab works lik ctrl+p in insert mode, completing words. And some other
" stuff
Bundle 'https://github.com/ervandew/supertab.git'

" Strip whitespace and highlight whitespace
" To strip do :StripWhitespace
Bundle 'https://github.com/ntpeters/vim-better-whitespace'

" Airline
Bundle 'https://github.com/vim-airline/vim-airline'

" Airline Themes
Bundle 'https://github.com/vim-airline/vim-airline-themes'

" Git plugin
Bundle 'https://github.com/tpope/vim-fugitive'

" Surround
" cs"' Change surrounding " to '
" ysiw" Surround inner word with "
Bundle 'https://github.com/tpope/vim-surround'

" Comments
" gcc Toggle comment line
" <c-_><c-_> Toggle comment in insert mode
Bundle 'https://github.com/tomtom/tcomment_vim'

" Multi select words using <C-n>
Bundle 'https://github.com/terryma/vim-multiple-cursors.git'

" Solarized
Bundle 'https://github.com/altercation/vim-colors-solarized.git'

" Ansible
Bundle 'https://github.com/pearofducks/ansible-vim.git'

" Bbye
" Say goodbye to a buffer in a split window with :Bdelete
Bundle 'https://github.com/moll/vim-bbye.git'

" Flake 8
Bundle 'https://github.com/nvie/vim-flake8.git'

" toml
Bundle 'https://github.com/cespare/vim-toml.git'

" Caddyfile support
Bundle 'https://github.com/isobit/vim-caddyfile.git'

" vim-nftables
Bundle 'https://github.com/nfnty/vim-nftables.git'

" jsonc Json with comments
Bundle 'https://github.com/neoclide/jsonc.vim.git'

" Github Copilot
Bundle 'https://github.com/github/copilot.vim'

" Plugin Black for python
Bundle 'psf/black'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required

syntax enable


colorscheme solarized
set cursorline
set wildignore+=*.swp,*.bak,*.pyc,*.class

set laststatus=2

set term=xterm-256color
set mouse=a

let background_pref = $BACKGROUND_THIJS_VIM
if background_pref == 'dark'
    set background=dark
else
    set background=light
endif

" Whitespace settings
"

" by default, the indent is 4 spaces.
set shiftwidth=4
set softtabstop=4
set tabstop=4

" for html/yaml files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype yaml setlocal ts=2 sw=2 expandtab

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
" Whitespace, no confirmation on exit/save. Just strip it.
let g:strip_whitespace_confirm=0

" CtrlP settings for ignoring.
"
let g:ctrlp_custom_ignore = 'target/\|DS_Store\|\.git\|tmpdir'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" match window place on top (default bottom, order:btt)
" let g:ctrlp_match_window = 'top,order:ttb'

" Set leader key to ,
let mapleader = ","
" Voor johan
map \ <Leader>

" Open file dialog
nnoremap <silent> <leader>f :CtrlP<CR>

" set line numbers
" <silent> does not show the command.
nnoremap <silent> <leader>l :set invnumber<CR>
" set paste mode (and reverse it)
nnoremap <silent> <leader>p :set invpaste<CR>

" Powerline fonts
let g:airline_powerline_fonts=1
" Tabline
let g:airline#extensions#tabline#enabled=1

" Airline Theme
let g:airline_theme='solarized'


" Flake 8 config
let g:flake8_show_quickfix=0
let g:flake8_show_in_gutter=1
let g:flake8_ignore="E501,C326"

" Save all
nnoremap <silent> <leader>S :wall<CR>
" Save current
nnoremap <silent> <leader>s :w<CR>

" Tab navigation like Firefox.
nnoremap <silent> <leader><S-tab> :bprevious<CR>
nnoremap <silent> <leader><tab>   :bnext<CR>
nnoremap <silent> <leader>d   :bd<CR>

" Simple surround
nnoremap <leader>{ viw<esc>a}<esc>hbi{<esc>lel
nnoremap <leader>[ viw<esc>a]<esc>hbi[<esc>lel
nnoremap <leader>< viw<esc>a><esc>hbi<<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel


" Switch to split window
nnoremap <S-Down> <C-w><C-j>
nnoremap <S-Up> <C-w><C-k>
nnoremap <S-Right> <C-w><C-l>
nnoremap <S-Left> <C-w><C-h>

function! SwapBackground()
    if &background == 'light'
        set background=dark
    else
        set background=light
    endif
endfunction
nnoremap <leader>b :call SwapBackground()<CR>

function! UnCamelCase()
    let l:tgt = expand('<cword>')
    let l:repl = substitute(l:tgt, '\u', '_\l&', 'g')
    exe "normal ciw" . l:repl
endfunction
command! -nargs=0 UnCamelCase :call UnCamelCase()

command! -range TestToAssert <line1>,<line2>s/test.eq(\(.*\), \(.*\))/assert \2 == \1/

" *.hujson render as *.jsonc
autocmd BufNewFile,BufRead *.hujson setlocal filetype=jsonc

" vim:filetype=vim
