set nocompatible " No Vi support

" External dependencies (use `brew` on macOS):
"  - fzf
"  - ripgrep
"
" Then, use the following in .zshrc/.bashrc:
"   if type rg &> /dev/null; then
"     export FZF_DEFAULT_COMMAND='rg --files'
"     export FZF_DEFAULT_OPTS='-i -m --height 50% --border'
"   fi
"
" https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko

" !!! NOTE !!!
" VSCode compatibility is still being worked on.
"
" This config is compatible with VSCode Neovim:
"  - https://github.com/vscode-neovim/vscode-neovim
" When Neovim is within VSCode, `g:vscode` is defined
" and can be used in an `if` statement:
" ```
" if exists('g:vscode')
"   " VSCode extension
" else
"   " Neovim proper
" endif
" ```
" 
" For vim-plug, a condition can be added:
" `Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))`
" 
" Additionally, VSCode will consume special shortcuts (control/alt).
" For these to be passed to Neovim, bindings must be explicitly
" sent to Neovim. For this config, the following must be added to
" `keybindings.json` (see VSCOde Neovim README for more information):
"
"

" == PLUGINS ==
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin()
    Plug 'sonph/onehalf', Cond(!exists('g:vscode'), { 'rtp': 'vim' }) " Theme (no 24-bit color)
    Plug 'EdenEast/nightfox.nvim', Cond(!exists('g:vscode')) " Theme (24-bit color, preferred)

    Plug 'xolox/vim-misc' " Dependency for vim-session
    Plug 'xolox/vim-session', Cond(!exists('g:vscode')) " Automatic sessions (may work with VSCode, not yet sure)

    Plug 'preservim/nerdtree', Cond(!exists('g:vscode')) " Side file tree 
    "Plug 'tiagofumo/vim-nerdtree-syntax-highlight', Cond(!exists('g:vscode')) " File icons for NERDTree
    Plug 'johnstef99/vim-nerdtree-syntax-highlight', Cond(!exists('g:vscode')) "Switch back to main branch (tiagofumo) once #54 is merged
    Plug 'ryanoasis/vim-devicons', Cond(!exists('g:vscode'))" Unicode characters to icons

    Plug 'itchyny/lightline.vim', Cond(!exists('g:vscode')) " Improved status line

    Plug 'junegunn/fzf', Cond(!exists('g:vscode'), { 'do': { -> fzf#install() } }) " Fuzzy file finder
    Plug 'junegunn/fzf.vim', Cond(!exists('g:vscode')) " Vim integration for FZF

    Plug 'skywind3000/asynctasks.vim', Cond(!exists('g:vscode')) " Background tasks
    Plug 'skywind3000/asyncrun.vim', Cond(!exists('g:vscode')) " Allow background tasks to be called

    Plug 'zefei/vim-wintabs', Cond(!exists('g:vscode')) " Tabs for windows
    Plug 'zefei/vim-wintabs-powerline', Cond(!exists('g:vscode')) " Enables powerline fonts for vim-wintabs

    Plug 'neoclide/coc.nvim', {'branch': 'release'} " Completion engine

    Plug 'voldikss/vim-floaterm', Cond(!exists('g:vscode')) " Floating terminal
    
    Plug 'tpope/vim-commentary' " Comment plugin

    Plug 'tikhomirov/vim-glsl' " GLSL formatting
call plug#end()

" == GLOBAL CONFIG ==
"set lazyredraw ~ This was used to attempt to speed up SSH, but this needs more research

let g:no_plugin_maps=1 " Disable plugin mappings (we map bindings manually wherever possible)

set nobackup " No backup before overwriting file
set nowritebackup " ^^^
set updatetime=750 " 750ms after no input before writing swap file
set confirm " Prompt to save buffer if unsaved

set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent

filetype plugin indent on

set clipboard=unnamedplus " Use global clipboard

set cursorline " Highlight cursor line
set signcolumn=yes " Needed for breakpoints, etc.
set splitbelow " More natural window split direction
set splitright " ^^^
set number " Relative line numbers
augroup numbertoggle " Auto switch between relative/absolute line numbers
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu
augroup END

set ignorecase
set smartcase " Search is case-sensitive if there is an uppercase letter

au TermOpen * tnoremap <Esc> <c-\><c-n>

" == THEME ==
if !exists('g:vscode')
    syntax enable

    if (has("termguicolors"))
        set termguicolors

        colorscheme nightfox
        let g:lightline = { 'colorscheme': "nightfox" }
    else
        colorscheme onehalfdark
        let g:lightline = { 'colorscheme': "onehalfdark" }
    endif
endif

" == FILE TYPES ==
" We use .hm/.hmm for Objective-C/C++ headers
autocmd BufRead,BufNewFile *.hm set filetype=objc
autocmd BufRead,BufNewFile *.hmm set filetype=objcpp

" == CORE MAPPINGS ==
" Space as Leader
nnoremap <SPACE> <Nop>
nmap <Space> <Leader>

" Save on <leader>w
nnoremap <leader>w :update<CR>
" Save all on <leader><S-w>
nnoremap <leader><S-w> :bufdo update<CR>

" Quit all on <leader><CTL-Q>
nnoremap <silent> <leader><C-q> :qa<CR>

" Resize left/right with -/=, resize down/up with _/= (S--, S-+)
nnoremap <silent> = :<C-u>exe 'vertical resize +' . v:count1<CR>
nnoremap <silent> - :<C-u>exe 'vertical resize -' . v:count1<CR>
nnoremap <silent> + :<C-u>exe 'resize +' . v:count1<CR>
nnoremap <silent> _ :<C-u>exe 'resize -' . v:count1<CR>

" Remap window movement to leader instead of Ctl-W
nnoremap <silent> <leader>l :<C-u>exe ':wincmd ' . v:count1 . 'l'<CR>
nnoremap <silent> <leader>k :<C-u>exe ':wincmd ' . v:count1 . 'k'<CR>
nnoremap <silent> <leader>j :<C-u>exe ':wincmd ' . v:count1 . 'j'<CR>
nnoremap <silent> <leader>h :<C-u>exe ':wincmd ' . v:count1 . 'h'<CR>

" Map redo to shift-u
nnoremap U :redo<CR>

" == WINTABS ==
if !exists('g:vscode')
    let g:wintabs_display = 'statusline' " Put wintabs on the statusline, move lightline to tabline (WinTabs is already configured for this)
    let g:wintabs_ignored_filetypes = ['gitcommit', 'vundle', 'qf', 'vimfiler', 'nerdtree']

    " Change tabs with [/]
    nnoremap [ <NOP>
    nnoremap ] <NOP>
    nnoremap <silent> ] :WintabsNext<CR>
    nnoremap <silent> [ :WintabsPrevious<CR>

    nnoremap <silent> <leader>q :WintabsClose<CR> " Close tab on Leader-q
    nnoremap <silent> <leader><S-q> :WintabsCloseWindow<CR> " Close window on Leader-Q
endif

:function SplitWinRight()
    if !exists('g:vscode')
        vnew
        wincmd h
        WintabsMoveToWindow l
    else
        " @todo
    endif
:endfunction
:function SplitWinDown()
    if !exists('g:vscode')
        new
        wincmd k
        WintabsMoveToWindow j
    else
        " @todo
    endif
:endfunction

nnoremap <silent> <leader><C-l> :call SplitWinRight()<CR> " Split right with Leader-L
nnoremap <silent> <leader><C-j> :call SplitWinDown()<CR> " Split down with Leader-J
if(!exists('g:vscode'))
    nnoremap <silent> <leader>L :WintabsMoveToWindow l<CR> " Move wintabs to right
    nnoremap <silent> <leader>H :WintabsMoveToWindow l<CR> " Move wintabs to left
    nnoremap <silent> <leader>K :WintabsMoveToWindow l<CR> " Move wintabs to above
    nnoremap <silent> <leader>J :WintabsMoveToWindow l<CR> " Move wintabs to below
endif

" == LIGHT LINE ==
if !exists('g:vscode')
    set noshowmode " Lightline shows mode on left side, we don't need this in the command section

    let g:lightline.enable = { 'statusline': 0, 'tabline': 0 } " Disable both; WinTabs will handle rendering

    let g:lightline.active = {
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'readonly' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'filetype' ] ] }
    let g:lightline.inactive = {
        \ 'left': [ [ 'filename' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'percent' ] ] }
    let g:lightline.tabline = {
        \ 'left': [ [ 'tabs' ] ],
        \ 'right': [ [ 'close' ] ] }

endif

" == NERD TREE ==
if !exists('g:vscode')
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'

    let g:NERDTreeShowLineNumbers=1
    autocmd FileType nerdtree setlocal relativenumber " Show relative line numbers in NERDTree

    nnoremap <silent> <C-t> :NERDTreeToggle<CR>

    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTreeToggle | endif

    " Exit Vim if NERDTree is the only window remaining in the only tab.
    "autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

    nnoremap <silent> <leader>t :NERDTreeFind<CR>
endif

" == FZF ==
if !exists('g:vscode')
    " Prevent FZF and NERDTree clashing in the same buffer
    function! FZFOpen(command_str)
    if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
        exe "normal! \<c-w>\<c-w>"
    endif
    exe 'normal! ' . a:command_str . "\<cr>"
    endfunction

    " Files on Leader-s
    nnoremap <silent> <leader>s :call FZFOpen(':Files')<CR>
    " Buffers on Leader-/
    nnoremap <silent> <leader>/ :call FZFOpen(':BLines')<CR>

    au FileType fzf tunmap <Esc>
endif

" == ASYNC TASK ==
if !exists('g:vscode')
    nnoremap <silent> <leader>r :AsyncTask run<CR>
endif

" == COC ==
" From coc.vim README
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Put shortcut for switch header/source
nnoremap <silent> <leader>o :CocCommand clangd.switchSourceHeader<CR>

" Syntax highlighting
let g:coc_default_semantic_highlight_groups = 1

" == FLOATERM ==
nnoremap <silent> ` :FloatermToggle<CR>
tnoremap <silent> ` <C-\><C-n>:FloatermToggle<CR>

" == SESSION ==
set sessionoptions-=buffers " Don't save hidden and unloaded buffers in sessions
set sessionoptions-=options " Don't persist options and mappings

let g:session_autoload='yes' " Automatically restore session
let g:session_autosave='yes' " Automatically save sesssion when exiting Vim
let g:session_default_to_last=1 " Automatically default to the last open session instead of the default session

" Persist options
let g:session_persist_globals = ['&sessionoptions']
call add(g:session_persist_globals, 'g:session_autoload')
call add(g:session_persist_globals, 'g:session_autosave')
call add(g:session_persist_globals, 'g:session_default_to_last')
call add(g:session_persist_globals, 'g:session_persist_globals')

