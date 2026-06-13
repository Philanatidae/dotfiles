return {
    'rebelot/heirline.nvim',
    enabled = true,
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local conditions = require('heirline.conditions')
        local utils = require('heirline.utils')

        local _, theme = pcall(require, 'lualine.themes.' .. (vim.g.colors_name or 'default'))
        if theme == nil or type(theme) ~= 'table' then
            theme = {}
        end

        local mode_palettes = {
            normal = theme.normal or
                { a = { fg = '#1e1e2e', bg = '#89b4fa', bold = true }, b = { fg = '#89b4fa', bg = '#313244' }, c = { fg = '#bac2de', bg = '#181825' } },
            insert = theme.insert or
                { a = { fg = '#1e1e2e', bg = '#a6e3a1', bold = true }, b = { fg = '#a6e3a1', bg = '#313244' }, c = { fg = '#bac2de', bg = '#181825' } },
            visual = theme.visual or
                { a = { fg = '#1e1e2e', bg = '#cba6f7', bold = true }, b = { fg = '#cba6f7', bg = '#313244' }, c = { fg = '#bac2de', bg = '#181825' } },
            replace = theme.replace or
                { a = { fg = '#1e1e2e', bg = '#f38ba8', bold = true }, b = { fg = '#f38ba8', bg = '#313244' }, c = { fg = '#bac2de', bg = '#181825' } },
            command = theme.command or
                { a = { fg = '#1e1e2e', bg = '#fab387', bold = true }, b = { fg = '#fab387', bg = '#313244' }, c = { fg = '#bac2de', bg = '#181825' } },
            terminal = theme.terminal or
                { a = { fg = '#1e1e2e', bg = '#f9e2af', bold = true }, b = { fg = '#f9e2af', bg = '#313244' }, c = { fg = '#bac2de', bg = '#181825' } },
        }
        for _, palette in pairs(mode_palettes) do
            if not palette.c then
                palette.c = mode_palettes.normal.c
            end
        end
        mode_palettes.n = mode_palettes.normal
        mode_palettes.v = mode_palettes.visual
        mode_palettes.V = mode_palettes.visual
        mode_palettes['\22'] = mode_palettes.visual
        mode_palettes.s = mode_palettes.visual
        mode_palettes.S = mode_palettes.visual
        mode_palettes['\19'] = mode_palettes.visual
        mode_palettes.i = mode_palettes.insert
        mode_palettes.R = mode_palettes.replace
        mode_palettes.c = mode_palettes.command
        mode_palettes.r = mode_palettes.replace
        mode_palettes['!'] = mode_palettes.terminal
        mode_palettes.t = mode_palettes.terminal

        local function get_hydra()
            local ok, hydra = pcall(require, 'hydra.statusline')
            if ok and hydra.is_active() then
                return hydra
            end
            return nil
        end

        local function get_mode_palette()
            local hydra = get_hydra()
            if hydra then
                local color = hydra.get_color() or '#ff5f5f'
                return {
                    a = { fg = mode_palettes.normal.a.fg, bg = color },
                    b = { fg = color, bg = mode_palettes.normal.b.bg },
                    c = { fg = '#bac2de', bg = mode_palettes.normal.c.bg }
                }
            else
                local mode = vim.api.nvim_get_mode().mode
                return mode_palettes[mode:sub(1, 1)] or mode_palettes.n
            end
        end

        local Mode = {
            init = function(self)
                local hydra = get_hydra()
                if hydra then
                    self.mode_text = hydra.get_name() or 'HYDRA'
                else
                    local m = vim.api.nvim_get_mode().mode
                    self.mode_text = self.mode_names[m] or m
                end
            end,
            static = {
                mode_names = {
                    ['n']     = 'NORMAL',
                    ['no']    = 'O-PENDING',
                    ['nov']   = 'O-PENDING',
                    ['noV']   = 'O-PENDING',
                    ['no\22'] = 'O-PENDING',
                    ['niI']   = 'NORMAL',
                    ['niR']   = 'NORMAL',
                    ['niV']   = 'NORMAL',
                    ['nt']    = 'NORMAL',
                    ['ntT']   = 'NORMAL',
                    ['v']     = 'VISUAL',
                    ['vs']    = 'VISUAL',
                    ['V']     = 'V-LINE',
                    ['Vs']    = 'V-LINE',
                    ['\22']   = 'V-BLOCK',
                    ['\22s']  = 'V-BLOCK',
                    ['s']     = 'SELECT',
                    ['S']     = 'S-LINE',
                    ['\19']   = 'S-BLOCK',
                    ['i']     = 'INSERT',
                    ['ic']    = 'INSERT',
                    ['ix']    = 'INSERT',
                    ['R']     = 'REPLACE',
                    ['Rc']    = 'REPLACE',
                    ['Rx']    = 'REPLACE',
                    ['Rv']    = 'V-REPLACE',
                    ['Rvc']   = 'V-REPLACE',
                    ['Rvx']   = 'V-REPLACE',
                    ['c']     = 'COMMAND',
                    ['cv']    = 'EX',
                    ['ce']    = 'EX',
                    ['r']     = 'REPLACE',
                    ['rm']    = 'MORE',
                    ['r?']    = 'CONFIRM',
                    ['!']     = 'SHELL',
                    ['t']     = 'TERMINAL',
                },
            },
            provider = function(self)
                return self.mode_text
            end,
            -- hl = function(self)
            --     return { fg = '#ffffff', bg = self.mode_color, bold = true }
            -- end,
            update = {
                'ModeChanged',
                'User',
                pattern = { '*:*', 'HydraEnter', 'HydraExit' },
                -- pattern = '*:*',
                callback = vim.schedule_wrap(function()
                    -- @todo This is hardcoded to tabline, allow switch between tabline or statusline
                    vim.cmd('redrawtabline')
                end)
            },
        }

        local Ruler = {
            provider = '%3l/%3L %3p%%',
        }

        local Clock = {
            -- Depends on outside redraw loop on 1s interval
            provider = function()
                return '%{strftime(\'%l:%M %p\')}'
            end,
        }

        local DeviconFiletype = {
            init = function(self)
                local devicons = require('nvim-web-devicons')
                local ft = vim.bo.filetype
                if ft == '' then
                    self.filetype = 'unknown 󰡯 '
                else
                    local icon = devicons.get_icon_by_filetype(ft, { default = true })
                    self.filetype = ft .. ' ' .. (icon or '') .. ' '
                end
            end,
            provider = function(self)
                return self.filetype
            end,
        }

        local LspStatus = {
            provider = function()
                local names = {}
                for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                    table.insert(names, server.name)
                end
                if #names > 0 then
                    return ' ' .. table.concat(names, ' ')
                else
                    return ' LSP Inactive'
                end
            end,
            update = {
                'LspAttach',
                'LspDetach',
                'ModeChanged',
                'User',
            },
        }

        local Diagnostics = {
            condition = conditions.has_diagnostics,

            static = {
                error_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.ERROR],
                warn_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.WARN],
                info_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.INFO],
                hint_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.HINT],
            },

            init = function(self)
                self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
            end,

            update = { "DiagnosticChanged", "BufEnter" },

            {
                provider = function(self)
                    -- 0 is just another output, we can decide to print it or not!
                    return self.errors > 0 and (self.error_icon .. ' ' .. self.errors .. ' ')
                end,
                hl = { fg = utils.get_highlight("DiagnosticError").fg },
            },
            {
                provider = function(self)
                    return self.warnings > 0 and (self.warn_icon .. ' ' .. self.warnings .. ' ')
                end,
                hl = { fg = utils.get_highlight("DiagnosticWarn").fg },
            },
            {
                provider = function(self)
                    return self.info > 0 and (self.info_icon .. ' ' .. self.info .. ' ')
                end,
                hl = { fg = utils.get_highlight("DiagnosticInfo").fg },
            },
            {
                provider = function(self)
                    return self.hints > 0 and (self.hint_icon .. ' ' .. self.hints)
                end,
                hl = { fg = utils.get_highlight("DiagnosticHint").fg },
            },
        }

        local Space = {
            provider = ' '
        }

        local SectionA = {
            hl = function()
                return get_mode_palette().a
            end,
            Space,
            Mode,
            Space,
        }
        local SectionB = {
            hl = function()
                return get_mode_palette().b
            end,
            {
                provider = '',
            },
            Space,
            LspStatus,
            Space,
        }
        local SectionC = {
            hl = function()
                return get_mode_palette().c
            end,
            {
                provider = '',
                hl = function()
                    local palette = get_mode_palette()
                    return {
                        fg = palette.b.bg,
                        bg = palette.c.bg,
                    }
                end,
            },
            Space,
            Diagnostics,
        }

        local SectionX = {
            hl = function()
                return get_mode_palette().c
            end,
            {
                provider = '%f',
            },
            Space,
            {
                provider = '',
                hl = function()
                    local palette = get_mode_palette()
                    return {
                        fg = palette.b.bg,
                        bg = palette.c.bg,
                    }
                end,
            },
        }
        local SectionY = {
            hl = function()
                return get_mode_palette().b
            end,
            Space,
            DeviconFiletype,
            {
                provider = '',
            },
        }
        local SectionZ = {
            hl = function()
                return get_mode_palette().a
            end,
            Space,
            Clock,
            {
                provider = '  ',
            },
            Ruler,
            Space
        }

        local status_line = {
            SectionA,
            SectionB,
            SectionC,
            { provider = '%=' },
            SectionX,
            SectionY,
            SectionZ,
        }
        require('heirline').setup({
            tabline = status_line,
        })

        if _G.heirline_clock_timer then
            _G.heirline_clock_timer:stop()
            _G.heirline_clock_timer:close()
            _G.heirline_clock_timer = nil
        end

        _G.heirline_clock_timer = vim.uv.new_timer()
        if _G.heirline_clock_timer then
            _G.heirline_clock_timer:start(0, 1000, vim.schedule_wrap(function()
                if vim.v.exiting == vim.NIL then
                    vim.cmd("redrawstatus")
                else
                    if _G.heirline_clock_timer then
                        _G.heirline_clock_timer:stop()
                        _G.heirline_clock_timer:close()
                        _G.heirline_clock_timer = nil
                    end
                end
            end))
        end
    end
}
