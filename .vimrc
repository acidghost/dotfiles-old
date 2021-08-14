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
set colorcolumn=100 " Vertical column

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
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdTree'
Plug 'liuchengxu/vista.vim'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'dhruvasagar/vim-prosession'
" Language / syntax support
Plug 'sheerun/vim-polyglot'
Plug 'vim-latex/vim-latex'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'souffle-lang/souffle.vim'
Plug 'aliou/bats.vim'

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
    \             [ 'readonly', 'filename', 'modified', 'method' ],
    \             [ 'obsession' ] ]
    \ },
    \ 'component': {
    \   'obsession': '%{ObsessionStatus("", "")}',
    \ },
    \ 'component_function': {
    \   'method': 'NearestMethodOrFunction',
    \ },
    \ }

" neovim lsp
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    set_keymap('n', '<leader>lD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    set_keymap('n', '<leader>ld', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    set_keymap('n', '<leader>lh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    set_keymap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    set_keymap('n', '<leader>lk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    set_keymap('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    set_keymap('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    set_keymap('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    set_keymap('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    set_keymap('n', '<leader>lx', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    set_keymap('n', '<leader>ldd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    set_keymap('n', '<leader>ldp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    set_keymap('n', '<leader>ldn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    set_keymap('n', '<leader>ldq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
    clangd = {};
    -- fsautocomplete = {};
    gopls = {};
    hls = {};
    pyright = {};
    rust_analyzer = {
        cargo = {
            loadOutDirsFromCheck = true
        },
        procMacro = {
            enable = true
        },
    };
    tsserver = {};
}
for lsp, settings in pairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = { debounce_text_changes = nil },
        settings = settings,
    }
end
EOF

" deoplete
" let g:deoplete#enable_at_startup = 1
" set completeopt-=preview

" completion-nvim
autocmd BufEnter * lua require'completion'.on_attach()
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" Prosession config
let g:prosession_tmux_title = 1
let g:prosession_tmux_title_format = ":@@@"
let g:prosession_on_startup = 1

" vista.vim
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

" FZF
command! -bang -nargs=* RgPreview
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

""" vim-latex
let g:tex_flavor='latex'

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
cmap <C-h> :History:<CR>
nmap <C-h> :Helptags<CR>

nmap <C-s> :Obsession<CR>
nmap <C-s>s :Prosession<Space>
nmap <C-s>d :ProsessionDelete<CR>

nmap <Leader>v :Vista!!<CR>
nmap <Leader>vf :Vista finder<CR>
nmap <Leader>vs :Vista focus<CR>

noremap @ :nohl<CR>

imap <silent> <c-p> <Plug>(completion_trigger)

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
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

" Useful utilities

command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_
        \ | diffthis | wincmd p | diffthis
