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

" Note: default plugin installation path is `stdpath('data')/plugged`
" `stdpath('data')` can be found by calling `:echo stdpath('data')`
call plug#begin()
    Plug 'sonph/onehalf', Cond(!exists('g:vscode'), { 'rtp': 'vim' }) " Theme (no 24-bit color)
    Plug 'EdenEast/nightfox.nvim', Cond(!exists('g:vscode')) " Theme (24-bit color, preferred)

    Plug 'xolox/vim-misc' " Dependency for vim-session
    Plug 'xolox/vim-session', Cond(!exists('g:vscode')) " Automatic sessions (may work with VSCode, not yet sure)

    Plug 'nvim-lua/plenary.nvim' " Common Lua functions

    Plug 'preservim/nerdtree', Cond(!exists('g:vscode')) " Side file tree 

    Plug 'nvim-treesitter/nvim-treesitter', Cond(!exists('g:vscode'), { 'do': ':TSUpdate' }) " Used by some plugins

    Plug 'ryanoasis/vim-devicons' " Unicode characters to icons

    Plug 'itchyny/lightline.vim', Cond(!exists('g:vscode')) " Improved status line

    Plug 'junegunn/fzf', Cond(!exists('g:vscode'), { 'do': { -> fzf#install() } }) " Fuzzy file finder
    Plug 'junegunn/fzf.vim', Cond(!exists('g:vscode')) " Vim integration for FZF

    Plug 'skywind3000/asynctasks.vim', Cond(!exists('g:vscode')) " Background tasks
    Plug 'skywind3000/asyncrun.vim', Cond(!exists('g:vscode')) " Allow background tasks to be called

    Plug 'zefei/vim-wintabs', Cond(!exists('g:vscode')) " Tabs for windows
    Plug 'zefei/vim-wintabs-powerline', Cond(!exists('g:vscode')) " Enables powerline fonts for vim-wintabs

    Plug 'williamboman/mason.nvim' " LSP server management
    Plug 'williamboman/mason-lspconfig.nvim' " Bridge mason-lspconfig to nvim-lspconfig
    Plug 'neovim/nvim-lspconfig' " Config between nvim/lsp server
    Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
    Plug 'hrsh7th/cmp-buffer' " Buffer source for nvim-cmp
    Plug 'hrsh7th/cmp-path' " Path source for nvim-cmp
    Plug 'SirVer/ultisnips' " Ultisnips source for nvim-cmp
    Plug 'hrsh7th/nvim-cmp' " Auto-completion

    Plug 'josa42/nvim-lightline-lsp', Cond(!exists('g:vscode')) " LSP diagnostics for lightline
    Plug 'nvim-lua/lsp-status.nvim', Cond(!exists('g:vscode')) " Helper for generating statusline components

    Plug 'voldikss/vim-floaterm', Cond(!exists('g:vscode')) " Floating terminal

    Plug 'mfussenegger/nvim-dap', Cond(!exists('g:vscode')) " Debugger
    Plug 'rcarriga/nvim-dap-ui', Cond(!exists('g:vscode')) " UI for nvim-dap
    Plug 'theHamsta/nvim-dap-virtual-text', Cond(!exists('g:vscode')) " virtual text for nvim-dap
    
    Plug 'tpope/vim-commentary' " Comment plugin

    Plug 'chaoren/vim-wordmotion' " Better 'word' (w/b) motions

    Plug 'folke/todo-comments.nvim' " todo comment highlight & search

    " Plug 'github/copilot.vim' " GitHub Copilot
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

set mouse=a

filetype plugin indent on

"set clipboard=unnamedplus " Use global clipboard

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

" Map escape to terminal escape sequence. Doesn't work reliably, though.
au TermOpen * tnoremap <Esc> <c-\><c-n>

lua << EOF
dump = function(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end
EOF

" == FILE TYPES ==
" We use .hm/.hmm for Objective-C/C++ headers
autocmd BufRead,BufNewFile *.hm set filetype=objc
autocmd BufRead,BufNewFile *.hmm set filetype=objcpp

" Vert/frag are GLSL
autocmd BufRead,BufNewFile *.vert set filetype=glsl
autocmd BufRead,BufNewFile *.frag set filetype=glsl

" == CORE MAPPINGS ==
" Space as Leader
nnoremap <SPACE> <Nop>
nmap <Space> <Leader>

" Save on <leader>w
nnoremap <leader>w :update<CR>
" Save all on <leader><S-w>
nnoremap <leader><S-w> :bufdo update<CR>

" Quit all on <leader><CTL-Q>
function! QuitAll()
    " lua require'dap'.terminate()
    qa
endfunction
nnoremap <silent> <leader><C-q> :call QuitAll()<CR>

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

    let g:lightline = {}
    let g:lightline.enable = { 'statusline': 0, 'tabline': 0 } " Disable both; WinTabs will handle rendering

    function! DevIconsFiletype()
        return strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : ''
    endfunction

    let g:lightline.component = {}
    let g:lightline.component.relativepath = '%f'
    let g:lightline.component.time = '%{strftime(''%l:%M %p'')}'
    
    let g:lightline.component_function = {}
    let g:lightline.component_function.filetype = 'DevIconsFiletype'

    call lightline#lsp#register() " Register LSP components

    let g:lightline.active = {
        \ 'left': [ [ 'mode', 'paste' ],
        \            [ 'lsp_warnings', 'lsp_errors', 'lsp_ok' ],
        \            [ 'lsp_status' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'time' ],
        \            [ 'readonly' ],
        \            [ 'filetype' ],
        \            ['relativepath'] ] }
    let g:lightline.inactive = {
        \ 'left': [ [ 'filename' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'percent' ] ] }
    let g:lightline.tabline = {
        \ 'left': [ [ 'tabs' ] ],
        \ 'right': [ [ 'close' ] ] }

    " Update lightline once per second, for updating the clock if there is no
    " user interation
    function! UpdateLightline(timer)
        call lightline#update()
        execute 'WintabsRefresh'
    endfunction

    " Set the timer to call the UpdateLightline function once per second
    let g:lightline_update_timer = timer_start(1000, 'UpdateLightline', {'repeat': -1})
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

" == NVIM-TREESITTER ==
lua << EOF

require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        disable = function(lang, buf)
            if lang == "c"
                or lang == "cpp"
                or lang == "objc"
                or lang == "objcpp"
                or lang == "xml"
                or lang == "cmake"
                then
                return true
            end
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end
    }
}

EOF

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
    " Ripgrep on Leader-Shift-S
    nnoremap <silent> <leader>S :call FZFOpen(':Rg')<CR>

    au FileType fzf tunmap <Esc>
endif

" == ASYNC TASK ==
if !exists('g:vscode')
    nnoremap <silent> <leader>r :AsyncTask run<CR>
    " Lowercase 'b' used for breakpoints
    nnoremap <silent> <leader>B :AsyncTask build<CR>
endif

" == LSP ==
lua << EOF

require('mason').setup()
require('mason-lspconfig').setup({
    -- My commonly used LSPs
    ensure_installed = {
        'clangd', -- C/C++/ObjC/ObjC++
        'cssls', -- CSS
        'html', -- HTML
        'lua_ls', -- LUA
        'svelte', -- Svelte
        'tsserver', -- TypeScript/JavaScript
        'vimls' -- VimScript
    }
})

-- nvim-cmp (Autocomplete)
-- TODO Move to its own section
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        -- documentation = comp.config.window.bordered(),
    },
    preselect = require('cmp').PreselectMode.Item,
    mapping = {
        --['<C-b>'] = cmp.mapping.scroll_docs(-4),
        --['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
    }, {
        { name = 'buffer' },
    })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Individual config for each LSP
local lsp = require('lspconfig')
lsp.clangd.setup({
    capabilities = capabilities
})
lsp.cssls.setup({
    capabilities = capabilities
})
lsp.html.setup({
    capabilities = capabilities
})
lsp.lua_ls.setup({
    capabilities = capabilities
})
lsp.svelte.setup({
    capabilities = capabilities
})
lsp.tsserver.setup({
    capabilities = capabilities
})
lsp.vimls.setup({
    capabilities = capabilities
})

EOF

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<BS>"
inoremap <silent><expr> <CR> pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"

" == COC ==
" " From coc.vim README
" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: There's always complete item selected by default, you may want to enable
" " no select by `"suggest.noselect": true` in your configuration file.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" " Make <CR> to accept selected completion item or notify coc.nvim to format
" " <C-g>u breaks current undo, please make your own choice.
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" function! CheckBackspace() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif

" " Mapping for switch header/source
" nnoremap <silent> <leader>o :CocCommand clangd.switchSourceHeader<CR>

" " Diagnostics
" nnoremap <silent> <leader>e <Plug>(coc-diagnostic-next-error)
" nnoremap <silent> <leader>E <Plug>(coc-diagnostic-prev-error)
" nnoremap <silent><nowait> <space>ca :<C-u>CocList diagnostics<CR>

" " Rename
" nnoremap <leader>cn <Plug>(coc-rename)

" " go-to code navigation
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Documentation
" function! ShowDocumentation()
"   if CocAction('hasProvider', 'hover')
"     call CocActionAsync('doHover')
"   else
"     call feedkeys('K', 'in')
"   endif
" endfunction

" nnoremap <silent> K :call ShowDocumentation()<CR>

" " Syntax highlighting
" let g:coc_default_semantic_highlight_groups = 1

" == DAP ==
lua << EOF
if not vim.g.vscode then
    local dap = require('dap')
    dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
            -- @todo Is there a way we can not depend on VSCode to supply codelldb?
            command = '/Users/philiprader/.vscode/extensions/vadimcn.vscode-lldb-1.9.0/adapter/codelldb',
            args = {"--port", "${port}"},

            -- This may have to be uncommended on Windows
            -- detatched = false,
        }
    }

    --dap_continue = function()
    --    if vim.fn.filereadable('.vim/dap_launch.json') ~= 0 then
    --        require('dap.ext.vscode').load_launchjs('.vim/dap_launch.json')
    --        print("Preparing to dump")
    --        local dap = require('dap')
    --        require('dap').run(dap.configurations.codelldb)
    --        return
    --    end
    --    print(".vim/dap_launch.json does not exist.")
    --end
end
EOF
if !exists('g:vscode')
    " Define custom signs for nvim-dap
    sign define DapBreakpoint text=● texthl=DebugBreakpoint linehl= numhl=
    sign define DapBreakpointCondition text=○ texthl=DebugBreakpoint linehl= numhl=
    sign define DapLogPoint text=✎ texthl=DebugLogpoint linehl= numhl=
    sign define DapStopped text=■ texthl=DebugStopped linehl= numhl=
    sign define DapBreakpointRejected text=✘ texthl=DebugBreakpointRejected linehl= numhl=

    " https://github.com/mfussenegger/nvim-dap/blob/7389e85233e3483b31b6a1c4ba69cda77336b7a8/doc/dap.txt#L469
    nnoremap <leader>R :lua require'dap'.continue()<CR>
    nnoremap <leader>dq :lua require'dap'.terminate()<CR>
    nnoremap <leader>di :lua require'dap'.step_into()<CR>
    nnoremap <leader>do :lua require'dap'.step_out()<CR>
    " TODO F5 needs to be rebound because iPad's don't have F5
    nnoremap <F5>do :lua require'dap'.step_over()<CR>
    nnoremap <leader>du :lua require'dap'.up()<CR>
    nnoremap <leader>dd :lua require'dap'.down()<CR>
    nnoremap <leader>df :lua require'dap'.focus_frame()<CR>
    nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
endif

" == DAPUI ==
lua << EOF
if not vim.g.vscode then
    local dap = require('dap')
    local dapui = require('dapui')
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
        vim.cmd('NERDTreeClose')
        dapui.open()
    end
    dap.listeners.after.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.after.event_exited["dapui_config"] = function()
        dapui.close()
    end
end
EOF

" == DAP-VIRTUAL-TEXT ==
lua << EOF
if not vim.g.vscode then
    require('nvim-dap-virtual-text').setup {
        all_references = true
    }
end
EOF

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

" == THEME ==
if !exists('g:vscode')
    syntax enable

    if (has("termguicolors"))
        set termguicolors

        colorscheme nightfox
        let g:lightline.colorscheme = "nightfox"
    else
        colorscheme onehalfdark
        let g:lightline.colorscheme = "onehalfdark"
    endif
endif

" == TODO-COMMENTS ==
lua << EOF

if not vim.g.vscode then
    require("todo-comments").setup {
        keywords = {
            FIX = {
              icon = " ", -- icon used for the sign, and in search results
              color = "error", -- can be a hex color, or a named color (see below)
              alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
              -- signs = false, -- configure signs for some keywords individually
            },
            TODO = { icon = " ", color = "info", alt = { "todo" } },
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "warn", "warning" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO", "info", "note" } },
            TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        pattern = [[.*[@\\]{1}<(KEYWORDS)\s*|.*<(KEYWORDS)\s*:]],
    }
end

EOF

if !exists('g:vscode')
    nnoremap <silent> <leader>T :TodoQuickFix keywords=TODO,WARN<CR>
endif

" == EXRC == (MUST GO LAST)
" Read more: https://alpha2phi.medium.com/vim-neovim-managing-multiple-project-settings-b5b6a3a94dd0
set exrc

