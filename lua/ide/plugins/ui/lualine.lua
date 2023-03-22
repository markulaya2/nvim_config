local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diagnostic = require("ide.utilities.diagnostic")
local colors = require("ide.plugins.ui.colors")

local hl = function(group, bg, fg, gui)
    local cmd = string.format(
        "highlight %s guibg=%s guifg=%s",
        group,
        bg,
        fg
    )
    if gui ~= nil then
        cmd = cmd .. " gui=" .. gui
    end
    vim.cmd(cmd)
end

local flutter = {
    app_version = function()
        return vim.g.flutter_tools_decorations.app_version
                and vim.g.flutter_tools_decorations.app_version
            or ""
    end,
    device = function()
        return vim.g.flutter_tools_decorations.device
                and vim.g.flutter_tools_decorations.device
            or ""
    end,
}

local theme = {
    normal = {
        a = {
            bg = colors.blue,
            fg = colors.black,
            gui = "bold",
        },
        b = {
            bg = colors.grey1,
            fg = colors.white,
            gui = "bold",
        },
        c = {
            bg = colors.grey0,
            fg = colors.white,
            gui = "bold",
        },
    },
    insert = {
        a = {
            bg = colors.purple,
            fg = colors.black,
            gui = "bold",
        },
        b = {
            bg = colors.grey1,
            fg = colors.white,
            gui = "bold",
        },
        c = {
            bg = colors.grey0,
            fg = colors.white,
            gui = "bold",
        },
    },
    visual = {
        a = {
            bg = colors.red,
            fg = colors.black,
            gui = "bold",
        },
        b = {
            bg = colors.grey1,
            fg = colors.white,
            gui = "bold",
        },
        c = {
            bg = colors.grey0,
            fg = colors.white,
            gui = "bold",
        },
    },
    replace = {
        a = {
            bg = colors.orange,
            fg = colors.black,
            gui = "bold",
        },
        b = {
            bg = colors.grey1,
            fg = colors.white,
            gui = "bold",
        },
        c = {
            bg = colors.grey0,
            fg = colors.white,
            gui = "bold",
        },
    },
    command = {
        a = {
            bg = colors.yellow,
            fg = colors.black,
            gui = "bold",
        },
        b = {
            bg = colors.grey1,
            fg = colors.white,
            gui = "bold",
        },
        c = {
            bg = colors.grey0,
            fg = colors.white,
            gui = "bold",
        },
    },
    terminal = {
        a = {
            bg = colors.green,
            fg = colors.black,
            gui = "bold",
        },
        b = {
            bg = colors.grey1,
            fg = colors.white,
            gui = "bold",
        },
        c = {
            bg = colors.grey0,
            fg = colors.white,
            gui = "bold",
        },
    },
    inactive = {
        a = {
            bg = colors.cyan,
            fg = colors.black,
            gui = "bold",
        },
        b = {
            bg = colors.grey1,
            fg = colors.white,
            gui = "bold",
        },
        c = {
            bg = colors.grey0,
            fg = colors.white,
            gui = "bold",
        },
    },
}

lualine.setup({
    options = {
        icons_enabled = true,
        theme = theme,
        component_separators = {
            left = "",
            right = "",
        },
        section_separators = {
            left = "",
            right = "",
        },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = {
            {
                "mode",
                fmt = function(mode)
                    return string.sub(mode, 1, 1)
                end,
                separator = {
                    left = "",
                    right = "",
                },
            },
        },
        lualine_b = {
            {
                "branch",
                icons_enabled = true,
                icon = "",
                separator = { right = "" },
            },
        },
        lualine_c = {
            {
                "diff",
                colored = true,
                symbols = {
                    added = " ",
                    modified = " ",
                    removed = " ",
                },
                cond = hide_in_width,
            },
            {
                function()
                    local row =
                        vim.api.nvim_win_get_cursor(
                            0
                        )[1]
                    local col =
                        vim.api.nvim_win_get_cursor(
                            0
                        )[2]
                    return " "
                        .. row
                        .. ":"
                        .. col
                        .. ""
                end,
            },
            {
                "filename",
                file_status = true, -- (readonly status, modified status)
                path = 0, -- 0: Just the filename
                -- 1: Relative path
                -- 2: Absolute path
                -- 3: Absolute path, with tilde as the home directory

                shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                -- for other components. (terrible name, any suggestions?)
                symbols = {
                    modified = " ",
                    readonly = " ",
                    unnamed = "[No Name]",
                },
                cond = hide_in_width,
            },
        },
        lualine_x = {
            flutter.app_version,
            flutter.device,
            {
                "filetype",
                colored = true,
                icon_only = false,
                icon = { align = "left" },
                cond = hide_in_width,
            },
            {
                function()
                    return "spaces: "
                        .. vim.api.nvim_get_option(
                            "tabstop"
                        )
                end,
            },
            "encoding",
        },
        lualine_y = {
            {
                "diagnostics",
                sources = { "nvim_lsp" },
                sections = {
                    "error",
                    "warn",
                    "hint",
                },
                diagnostics_color = {
                    error = "LualineYDiagnostic",
                    warn = "LualineYDiagnostic",
                    info = "LualineYDiagnostic",
                    hint = "LualineYDiagnostic",
                },
                symbols = {
                    error = " ",
                    warn = " ",
                    hint = " ",
                },
                colored = true,
                update_in_insert = true,
                always_visible = true,
                separator = { left = "" },
                fmt = function(diagnostics)
                    if
                        diagnostic.get_diagnostic_error()
                        ~= ""
                    then
                        hl(
                            "LualineYDiagnostic",
                            colors.grey1,
                            colors.red,
                            "bold"
                        )
                    elseif
                        diagnostic.get_diagnostic_warn()
                        ~= ""
                    then
                        hl(
                            "LualineYDiagnostic",
                            colors.grey1,
                            colors.yellow,
                            "bold"
                        )
                    elseif
                        diagnostic.get_diagnostic_hint()
                        ~= ""
                    then
                        hl(
                            "LualineYDiagnostic",
                            colors.grey1,
                            colors.green,
                            "bold"
                        )
                    else
                        hl(
                            "LualineYDiagnostic",
                            colors.grey1,
                            colors.white,
                            "bold"
                        )
                    end

                    return diagnostics
                end,
            },
        },
        lualine_z = {
            {
                "progress",
                fmt = function()
                    local progress = math.floor(
                        (
                                vim.api.nvim_win_get_cursor(
                                    0
                                )[1]
                                / vim.api.nvim_buf_line_count(
                                    0
                                )
                                * 100
                            )
                    )
                    return tostring(
                        vim.api.nvim_win_get_cursor(0)[1]
                                    == 1
                                and "Top"
                            or progress == 100 and "Bot"
                            or progress
                    )
                end,
                separator = {
                    left = "",
                    right = "",
                },
            },
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
