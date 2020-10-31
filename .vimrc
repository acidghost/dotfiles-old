set nocompatible   " Disable vi compatibilty
set encoding=utf-8 " Use UTF-8
syntax enable      " Turn on syntax highlighting
set showmatch      " Show matching brackets
set ignorecase     " Do case insensitive matching
set number         " Show numbers
set relativenumber " Show relative numbers
set undolevels=999 " Lots of these
set hlsearch       " Highlight Search
set tabstop=4      " Tab size
set shiftwidth=4   " Indentation size
set softtabstop=4  " Tabs/Spaces interop
set expandtab      " Expands tab to spaces
set nomodeline     " Disable as a security precaution
set mouse=a        " Enable mouse mode
set autoindent     " Enable autoindent
set complete-=i    " Better completion
set laststatus=2   " Always show status line
set ruler          " Show cursor position
set scrolloff=3    " Scroll offset
set sidescrolloff=5
set autoread       " Reload files on change
set history=1000   " More history
set list           " Highlight non whitespace characters
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
set noshowmode     " Hide mode in bottom line given lightline

" allow .vimrc files to reside in project folders
set exrc
set secure

if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    "set termguicolors
endif

if $TERM == "rxvt-unicode-256color"
    set notermguicolors     " Disable true colors (urxvt fix)
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'itchyny/lightline.vim'
Plug 'chriskempson/base16-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdTree'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'cespare/vim-toml'

call plug#end()

if !has('gui_running')
    set t_Co=256
endif

" Sync with base16 shell color
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
    call mkdir($HOME.'/.vim/swap', 'p')
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" Alternative ctags filename
set tags+=.tags

" Lightline configuration
let g:lightline = {
    \ 'colorscheme': 'deus',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified' ],
    \             [ 'obsession' ] ]
    \ },
    \ 'component': {
    \   'obsession': '%{ObsessionStatus("", "")}',
    \ },
    \ }

" Language client configuration
set hidden      " Required for operations modifying multiple buffers like rename.
let g:LanguageClient_serverCommands = {
    \ 'python': ['~/.local/bin/pyls'],
    \ 'rust': ['~/.cargo/bin/rls'],
    \ 'cpp': ['clangd-10'],
    \ 'c': ['clangd-10'],
    \ 'haskell': ['haskell-language-server-wrapper', '--lsp'],
    \ }

" deoplete
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

" Prosession config
let g:prosession_tmux_title = 1
let g:prosession_tmux_title_format = ":@@@"
let g:prosession_on_startup = 1

" FZF
command! -bang -nargs=* RgPreview
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

""" Key mappings
let mapleader = ","

" Yank to PRIMARY clipboard
noremap <Leader>y "*y
" Paste from PRIMARY clipboard
noremap <Leader>p "*p
" Yank to CLIPBOARD clipboard
noremap <Leader>Y "+y
" Paste from CLIPBOARD clipboard
noremap <Leader>P "+p

" Navigate quickfix list
noremap <Leader>eo :botright copen<CR>
noremap <Leader>ef :cfirst<CR>
noremap <Leader>en :cnext<CR>
noremap <Leader>ep :cprevious<CR>

nmap <Down> <C-E>
nmap <Up> <C-Y>
nmap <Left> 20zl
nmap <Right> 20zr

nmap <C-n> :NERDTreeToggle<CR>

nmap <C-p> :FZF<CR>
nmap <C-t> :Tags<CR>
nmap <S-p> :FZF!<CR>
nmap <Leader>f :RgPreview<Space>
nmap <Leader>F :RgPreview!<Space>
nmap <Leader>g :GFiles<CR>
nmap <Leader>G :GFiles!<CR>
nmap <Leader>c :GFiles?<CR>
nmap <Leader>b :Buffers<CR>
cmap <C-r> :History:<CR>
nmap <C-h> :Helptags<CR>

nmap <C-s> :Obsession<CR>
nmap <C-s>s :Prosession<Space>
nmap <C-s>d :ProsessionDelete<CR>

noremap @ :nohl<CR>

function LC_maps()
    if has_key(g:LanguageClient_serverCommands, &filetype)
        nmap <silent><leader>ld <Plug>(lcn-definition)
        nmap <silent><leader>lr <Plug>(lcn-rename)
        nmap <silent><leader>lf <Plug>(lcn-format)
        nmap <silent><leader>lt <Plug>(lcn-type-definition)
        nmap <silent><leader>lx <Plug>(lcn-references)
        " nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
        nmap <silent><leader>la <Plug>(lcn-code-action)
        nmap <silent><leader>lc :call LanguageClient#textDocument_completion()<CR>
        nmap <silent><leader>lh <Plug>(lcn-hover)
        nmap <silent><leader>ls <Plug>(lcn-symbols)
        nmap <silent><leader>lm <Plug>(lcn-menu)
        nmap <silent><leader>le <Plug>(lcn-explain-error)
    endif
endfunction

autocmd FileType * call LC_maps()

autocmd BufRead,BufNewFile $HOME/.aliases set ft=sh
autocmd BufRead,BufNewFile $HOME/.path set ft=sh
autocmd BufRead,BufNewFile *.fc set ft=fennec
autocmd BufRead,BufNewFile *.ll set ft=llvm
autocmd BufRead,BufNewFile *.td set ft=tablegen
autocmd BufRead,BufNewFile *.rasi setf css
autocmd BufRead,BufNewFile Vagrantfile setf ruby

autocmd FileType go setlocal shiftwidth=4 tabstop=4 noexpandtab
autocmd FileType cpp setlocal shiftwidth=2 tabstop=2
autocmd FileType cmake setlocal shiftwidth=2 tabstop=2
autocmd FileType org setlocal shiftwidth=2 tabstop=2

" Useful utilities

command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_
        \ | diffthis | wincmd p | diffthis
