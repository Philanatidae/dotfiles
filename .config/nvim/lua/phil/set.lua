-- General
vim.opt.backup = false      -- No backup before overwriting file
vim.opt.writebackup = false -- ^^^
vim.opt.updatetime = 250
vim.opt.timeoutlen = 750
vim.opt.confirm = true
vim.opt.exrc = true
vim.opt.undofile = true
vim.opt.mouse = "a"

-- Indent w/ 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.breakindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.inccommand = "split"

-- Appearance
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Auto switch between relative and normal
local numbertoggle_augroup = vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
    pattern = "*",
    group = numbertoggle_augroup,
    command = "if &nu && mode() != 'i' | set rnu   | endif",
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
    pattern = "*",
    group = numbertoggle_augroup,
    command = "if &nu | set nornu | endif",
})

-- If using wl-clipboard, we need to set manually so that *
-- is the same as +.
if vim.env.WAYLAND_DISPLAY ~= nil and vim.env.WAYLAND_DISPLAY ~= ''
    and vim.fn.executable('wl-copy') == 1
    and vim.fn.executable('wl-paste') == 1 then
    vim.g.clipboard = {
        name = 'wl-clipboard',
        copy = {
            ['+'] = { 'wl-copy', '--type', 'text/plain' },
            ['*'] = { 'wl-copy', '--type', 'text/plain' },
        },
        paste = {
            ['+'] = { 'wl-paste', '--no-newline' },
            ['*'] = { 'wl-paste', '--no-newline' },
        },
        cache_enabled = 0,
    }
end


local sev = vim.diagnostic.severity
vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    signs = {
        text = {
            [sev.ERROR] = '',
            [sev.WARN] = '',
            [sev.INFO] = '',
            [sev.HINT] = '',
        }
    },
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
        suffix = "",
    }
})
