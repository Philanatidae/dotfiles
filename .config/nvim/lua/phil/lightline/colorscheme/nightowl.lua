local palette = require("night-owl.palette")

local nightowl_ll = {}

nightowl_ll.normal = {
    left = { { palette.dark, palette.magenta } }, -- , { palette.cyan, palette.fg } },
    middle = { { palette.fg, palette.dark } },
    right = { { palette.fg, palette.dark } },     -- { palette.cyan, palette.fg } },
    error = { { palette.fg, palette.error_red } },
    warning = { { palette.cyan, palette.orange } },
}

nightowl_ll.insert = {
    left = { { palette.dark, palette.green }, { palette.fg, palette.dark } },
}

nightowl_ll.visual = {
    left = { { palette.dark, palette.yellow }, { palette.fg, palette.dark } },
}

nightowl_ll.replace = {
    left = { { palette.dark, palette.orange }, { palette.fg, palette.dark } },
}

nightowl_ll.command = {
    left = { { palette.dark, palette.cyan }, { palette.fg, palette.dark } },
}

nightowl_ll.inactive = {
    left = { { palette.light_blue, palette.quickfix_line } },
    middle = { { palette.light_blue, palette.quickfix_line } },
    right = { { palette.light_blue, palette.quickfix_line } },
}

return nightowl_ll
