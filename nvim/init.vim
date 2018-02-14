set nocompatible    " required
filetype off        " required

" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()

" let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'
" Plugin 'vim-scripts/indentpython.vim'
" Plugin 'scrooloose/nerdtree'
" Plugin 'nvie/vim-flake8'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
" Plugin 'chriskempson/base16-vim'
" Plugin 'stephenmckinney/vim-solarized-powerline'
" Plugin 'Lokaltog/vim-powerline'
" Plugin 'altercation/vim-colors-solarized'
" Plugin 'tpope/vim-fugitive'
" Plugin 'majutsushi/tagbar'
" Plugin 'ctrlpvim/ctrlp.vim'

let python_highlight_all=1

" All of your Plugins must be added before the following line
" call vundle#end()

" execute pathogen#infect()

call plug#begin('~/.local/share/nvim/plugged') 

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-obsession'
Plug 'w0rp/ale'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'

call plug#end()

syntax on

filetype plugin indent on

syntax enable
set background=light
"set background=dark
colorscheme solarized

" ALE javascript local eslint
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = '/Users/christopherlam/git/development/javascript/graphqljs/node_modules/.bin/eslint'

" switch vim color depending on time
"if strftime("%H") >= 5 && strftime("%H") <= 17
"  set background=light
"else
"  set background=dark
"endif
" source vimrc everytime save so it knows what color to use
" if has("autocmd")
"  autocmd bufwritepost * source ~/.vimrc
" endif

" powerline setup
"set guifont=Inconsolata\ for\ Powerline:h15
" let g:Powerline_symbols = 'fancy' " this causes problems for the symbols now, did not use to
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
if !has('nvim')
    set term=xterm-256color
endif
set termencoding=utf-8
" the following is to show powerline when there are no split windows
set laststatus=2

" powerline color scheme
let g:Powerline_theme='short'
let g:Powerline_colorscheme='solarized256_light'

"------------Start Python PEP 8 stuff----------------
" Number of spaces that a pre-existing tab is equal to.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4

"spaces for indents
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py set softtabstop=4

" Use UNIX (\n) line endings.
 au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw, set textwidth=100

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" python should use utf-8
set encoding=utf-8
" python with virtualenv support

" python run script remap of key
"map <F9> :w<CR>:!python %<CR>

" 1 tab == 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
map <C-n> :NERDTreeToggle<CR>
" open nerdree to current doc folder
" this command doesnt seem to work - autocmd BufEnter * lcd %:p:h
map <leader>n :NERDTreeFind<cr>

set ruler
set cursorline

" turn on omnifunc
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" set up tagbar
let g:tagbar_ctags_bin='/usr/local/bin/ctags'  " Proper Ctags locations
let g:tagbar_width=26                          " Default is 40, seems too wide
noremap <silent> <Leader>t :TagbarToggle       " Display panel with y (or ,y)

" sets up classpath of CntrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
" Use <leader>t to open ctrlp
let g:ctrlp_map = '<leader>p'
" Ignore these directories
set wildignore+=*/build/**,*.class,*/bin/**
" disable caching
" let g:ctrlp_use_caching=0
" let ctrlp match files top to bottom
let g:ctrlp_match_window = 'bottom,order:ttb'
" let ctrlp open files in new buffers
let g:ctrlp_switch_buffer = 0
" let ctrlp change the working path and respect it
let g:ctrlp_working_path_mode = 0
" no max files
let g:ctrlp_max_files=0

" override split Vim split default
set splitbelow
set splitright

" Better split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l)
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

tnoremap <C-h> <C-\><C-n><C-h>
tnoremap <C-j> <C-\><C-n><C-j>
tnoremap <C-k> <C-\><C-n><C-k>
tnoremap <C-l> <C-\><C-n><C-l>

if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  " Hack to get C-h working in neovim
  nmap <BS> <C-W>h
  tnoremap <Esc> <C-\><C-n>
endif

" Get output of shell commands
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>"

" set font
"set guifont=Menlo\ Regular:h12
set guifont=DroidSansMono\ Nerd\ Font:h11

" compile gradle
map <F4> :w<CR> :compiler gradle<CR> :make test<CR>:cw 4<CR>

" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

" vim-ruby setup
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" highlight 81 chars (tip from Damian Conway)
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

function! HLNext (blinktime)
    highlight WhiteOnRed ctermfg=white ctermbg=red

        let [bufnum, lnum, col, off] = getpos('.')
        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
        let target_pat = '\c\%#'.@/
        let ring = matchadd('WhiteOnRed', target_pat, 101)
        redraw
        exec 'sleep ' . float2nr(a:blinktime * 1000) .  'm'
        call matchdelete(ring)
        redraw
endfunction

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
