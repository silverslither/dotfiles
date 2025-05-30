if vim.g.statusline_icons ~= nil then
    vim.g.statusline_icons = not (vim.g.vscode or os.getenv("TERM") == "linux")
end

local diagnostics_icons = {
    error = "󰅚 ",
    warn = "󰀪 ",
    info = "󰋽 ",
    hint = "󰌶 ",
}

local diagnostics_map = {
    error = "E:",
    warn = "W:",
    info = "I:",
    hint = "H:",
}

local fileformat_icons = {
    unix = " ",
    dos = " ",
    mac = " ",
}

local fileformat_map = {
    unix = "LF",
    dos = "CRLF",
    mac = "CR",
}

local mode_map = {
    ["n"] = "NORMAL",
    ["no"] = "O-PENDING",
    ["nov"] = "O-PENDING",
    ["noV"] = "O-PENDING",
    ["no\22"] = "O-PENDING",
    ["niI"] = "NORMAL",
    ["niR"] = "NORMAL",
    ["niV"] = "NORMAL",
    ["nt"] = "NORMAL",
    ["ntT"] = "NORMAL",
    ["v"] = "VISUAL",
    ["vs"] = "VISUAL",
    ["V"] = "V-LINE",
    ["Vs"] = "V-LINE",
    ["\22"] = "V-BLOCK",
    ["\22s"] = "V-BLOCK",
    ["s"] = "SELECT",
    ["S"] = "S-LINE",
    ["\19"] = "S-BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["ix"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rc"] = "REPLACE",
    ["Rx"] = "REPLACE",
    ["Rv"] = "V-REPLACE",
    ["Rvc"] = "V-REPLACE",
    ["Rvx"] = "V-REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "EX",
    ["ce"] = "EX",
    ["r"] = "REPLACE",
    ["rm"] = "MORE",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}

local highlight_map = {
    ["VISUAL"] = "_visual#",
    ["V-BLOCK"] = "_visual#",
    ["V-LINE"] = "_visual#",
    ["SELECT"] = "_visual#",
    ["S-LINE"] = "_visual#",
    ["S-BLOCK"] = "_visual#",
    ["REPLACE"] = "_replace#",
    ["V-REPLACE"] = "_replace#",
    ["INSERT"] = "_insert#",
    ["COMMAND"] = "_command#",
    ["EX"] = "_command#",
    ["MORE"] = "_command#",
    ["CONFIRM"] = "_command#",
    ["TERMINAL"] = "_terminal#",
}

if not (vim.g.vscode or os.getenv("TERM") == "linux") then
    local highlight_modes = { "normal", "visual", "replace", "insert", "command", "terminal", "inactive" }

    local theme = vim.g.material_lualine_theme
    for _, mode in pairs(highlight_modes) do
        if theme[mode] == nil then
            theme[mode] = theme.normal
        end
        for _, i in pairs({ "a", "b", "c" }) do
            local m = theme[mode]
            if m[i] == nil then m[i] = theme.normal[i] end
            if m[i].fg == nil then m[i].fg = theme.normal[i].fg end
            if m[i].bg == nil then m[i].bg = theme.normal[i].bg end

            local gui = m[i].gui or ""
            if string.find(gui, "nocombine") == nil then
                gui = gui ~= "" and gui .. ",nocombine" or "nocombine"
            end

            vim.cmd.highlight("_statusline_" .. i .. "_" .. mode .. " guifg=" .. m[i].fg .. " guibg=" .. m[i].bg .. " gui=" .. gui)
        end

        vim.cmd.highlight("_statusline_ab_" .. mode .. " guifg=" .. theme[mode].a.bg .. " guibg=" .. theme[mode].b.bg .. " gui=nocombine")
        vim.cmd.highlight("_statusline_bc_" .. mode .. " guifg=" .. theme[mode].b.bg .. " guibg=" .. theme[mode].c.bg .. " gui=nocombine")
        vim.cmd.highlight("_statusline_ac_" .. mode .. " guifg=" .. theme[mode].a.bg .. " guibg=" .. theme[mode].c.bg .. " gui=nocombine")
    end

    local colors = require("material.colors")

    vim.cmd.highlight("_statusline_diff_added guifg=" .. colors.git.added .. " guibg=" .. theme.normal.b.bg .. " gui=nocombine")
    vim.cmd.highlight("_statusline_diff_modified guifg=" .. colors.git.modified .. " guibg=" .. theme.normal.b.bg .. " gui=nocombine")
    vim.cmd.highlight("_statusline_diff_removed guifg=" .. colors.git.removed .. " guibg=" .. theme.normal.b.bg .. " gui=nocombine")

    vim.cmd.highlight("_statusline_diagnostic_error guifg=" .. colors.lsp.error .. " guibg=" .. theme.normal.b.bg .. " gui=nocombine")
    vim.cmd.highlight("_statusline_diagnostic_warn guifg=" .. colors.lsp.warning .. " guibg=" .. theme.normal.b.bg .. " gui=nocombine")
    vim.cmd.highlight("_statusline_diagnostic_info guifg=" .. colors.lsp.info .. " guibg=" .. theme.normal.b.bg .. " gui=nocombine")
    vim.cmd.highlight("_statusline_diagnostic_hint guifg=" .. colors.lsp.hint .. " guibg=" .. theme.normal.b.bg .. " gui=nocombine")
end

local ft_hlgroups = {}
local devicons_ok, devicons = pcall(require, "nvim-web-devicons")

function _statusline()
    local mode = vim.api.nvim_get_mode().mode
    local a = mode_map[mode]
    if a == nil then
        a = "UNKNOWN (" .. mode .. ")"
    end
    local highlight = highlight_map[a]
    if highlight == nil then
        highlight = "_normal#"
    end
    local reg = vim.fn.reg_recording()
    if #reg > 0 then
        a = a .. " (@" .. reg .. ")"
    end

    local b = {}
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.b.gitsigns_status and #vim.b.gitsigns_status > 0 then
        table.insert(b, vim.b.gitsigns_status)
    end

    local diagnostics_prefix = diagnostics_map
    if vim.g.statusline_icons then diagnostics_prefix = diagnostics_icons end
    local diagnostics = {}
    local n = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
    if n > 0 then table.insert(diagnostics, "%#_statusline_diagnostic_error#" .. diagnostics_prefix.error .. n) end
    n = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN })
    if n > 0 then table.insert(diagnostics, "%#_statusline_diagnostic_warn#" .. diagnostics_prefix.warn .. n) end
    n = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.INFO })
    if n > 0 then table.insert(diagnostics, "%#_statusline_diagnostic_info#" .. diagnostics_prefix.info .. n) end
    n = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.HINT })
    if n > 0 then table.insert(diagnostics, "%#_statusline_diagnostic_hint#" .. diagnostics_prefix.hint .. n) end

    if #diagnostics > 0 then
        table.insert(b, table.concat(diagnostics, " "))
    end
    b = table.concat(b, "%#_statusline_b" .. highlight .. "  ")

    local x = {}
    n = vim.opt.fileencoding:get()
    if #n > 0 then table.insert(x, n) end
    n = vim.opt.fileformat:get()
    if #n > 0 then
        local m = fileformat_map[n]
        if vim.g.statusline_icons then
            local icon = fileformat_icons[n]
            if icon ~= nil then
                m = icon .. m
            end
        end
        table.insert(x, m)
    end
    n = vim.opt.filetype:get()
    if #n > 0 then
        if vim.g.statusline_icons and devicons_ok then
            local icon, group = devicons.get_icon_by_filetype(n)
            if ft_hlgroups[group] == nil and group ~= nil and theme ~= nil then
                local hlgroup = vim.api.nvim_get_hl_by_name(group, true)
                vim.cmd.highlight("_statusline_" .. group .. " guifg=#" .. string.format("%06x", hlgroup.foreground) .. " guibg=" .. theme.normal.c.bg .. " gui=nocombine")
                ft_hlgroups[group] = true
            end
            if icon == nil or group == nil then
                icon = ""
                group = "c".. highlight:sub(1, #highlight - 1)
            end
            n = "%#_statusline_" .. group .. "#" .. icon .. "%#_statusline_c" .. highlight .. " " .. n
        end
        table.insert(x, n)
    end
    x = table.concat(x, "  ")

    local sep = ""
    if theme == nil then sep = "" end
    local s = "%#_statusline_a" .. highlight .. " " .. a
    if #b > 0 then
        s = s .. " %#_statusline_ab" .. highlight .. sep .. "%#_statusline_b" .. highlight .. " "
        s = s .. b
        s = s .. " %#_statusline_bc" .. highlight .. sep .. "%#_statusline_c" .. highlight
    else
        s = s .. " %#_statusline_ac" .. highlight .. sep .. "%#_statusline_c" .. highlight
    end
    s = s .. " %<%f %h%w%m%r "
    s = s .. "%="
    sep = ""
    if theme == nil then sep = "" end
    s = s .. x
    s = s .. " %#_statusline_bc" .. highlight .. sep .. "%#_statusline_b" .. highlight
    s = s .. " %P "
    s = s .. "%#_statusline_ab" .. highlight .. sep .. "%#_statusline_a" .. highlight
    s = s .. " %l:%c "
    return s
end

vim.g.active_statusline = "%{%v:lua._statusline()%}"
vim.g.inactive_statusline = " %<%f %h%w%m%r %=%l:%c "
vim.opt.statusline = vim.g.active_statusline

vim.uv.new_timer():start(1000, 1000, function()
    vim.schedule(function()
        vim.cmd.redrawstatus()
    end)
end)
