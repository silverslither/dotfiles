local separators = {
    component = { left = "", right = "" },
    section = { left = "", right = "" },
}

local diagnostics = {
    text = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
    icons = { error = "󰅚 ", warn = "󰀪 ", info = "󰋽 ", hint = "󰌶 " },
}

local fileformat = {
    text = { unix = "LF", dos = "CRLF", mac = "CR" },
    icons = { unix = " ", dos = " ", mac = " " },
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
    ["VISUAL"] = "_visual",
    ["V-BLOCK"] = "_visual",
    ["V-LINE"] = "_visual",
    ["SELECT"] = "_visual",
    ["S-LINE"] = "_visual",
    ["S-BLOCK"] = "_visual",
    ["REPLACE"] = "_replace",
    ["V-REPLACE"] = "_replace",
    ["INSERT"] = "_insert",
    ["COMMAND"] = "_command",
    ["EX"] = "_command",
    ["MORE"] = "_command",
    ["CONFIRM"] = "_command",
    ["TERMINAL"] = "_terminal",
}

local advanced_terminal = not (vim.g.vscode or os.getenv("TERM") == "linux")
if vim.g.statusline_icons == nil then
    vim.g.statusline_icons = advanced_terminal
end

local theme = nil
if advanced_terminal then
    local highlight_modes = { "normal", "visual", "replace", "insert", "command", "terminal" }
    local colors = require("material.colors")
    theme = vim.g.material_lualine_theme

    for _, mode in pairs(highlight_modes) do
        if theme[mode] == nil then theme[mode] = theme.normal end

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

    vim.cmd.highlight("_statusline_b_diff_added guifg=" .. colors.git.added .. " guibg=" .. theme.normal.b.bg .. " gui=nocombine")
    vim.cmd.highlight("_statusline_b_diff_modified guifg=" .. colors.git.modified .. " guibg=" .. theme.normal.b.bg .. " gui=nocombine")
    vim.cmd.highlight("_statusline_b_diff_removed guifg=" .. colors.git.removed .. " guibg=" .. theme.normal.b.bg .. " gui=nocombine")

    vim.cmd.highlight("_statusline_b_diagnostic_error guifg=" .. colors.lsp.error .. " guibg=" .. theme.normal.b.bg .. " gui=nocombine")
    vim.cmd.highlight("_statusline_b_diagnostic_warn guifg=" .. colors.lsp.warning .. " guibg=" .. theme.normal.b.bg .. " gui=nocombine")
    vim.cmd.highlight("_statusline_b_diagnostic_info guifg=" .. colors.lsp.info .. " guibg=" .. theme.normal.b.bg .. " gui=nocombine")
    vim.cmd.highlight("_statusline_b_diagnostic_hint guifg=" .. colors.lsp.hint .. " guibg=" .. theme.normal.b.bg .. " gui=nocombine")
end

local ft_hlgroups = {}
local devicons_ok, devicons = pcall(require, "nvim-web-devicons")

local highlight = "_normal"
local function hlg(section, group)
    group = group or highlight
    return "%#_statusline_" .. section .. group .. "#"
end

function _statusline()
    local mode = vim.api.nvim_get_mode().mode
    local a = " " .. (mode_map[mode] or ("UNKNOWN (" .. mode .. ")")) .. " "
    local reg = vim.fn.reg_recording()
    if #reg > 0 then
        a = a .. "(@" .. reg .. ") "
    end

    highlight = highlight_map[a]
    if highlight == nil then
        highlight = "_normal"
    end

    local _b = {}
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.b.gitsigns_status and #vim.b.gitsigns_status > 0 then
        table.insert(_b, vim.b.gitsigns_status)
    end

    local d = {}
    local prefix = vim.g.statusline_icons and "icons" or "text"
    local n = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
    if n > 0 then table.insert(d, hlg("b", "_diagnostic_error") .. diagnostics[prefix].error .. n) end
    n = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN })
    if n > 0 then table.insert(d, hlg("b", "_diagnostic_warn") .. diagnostics[prefix].warn .. n) end
    n = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.INFO })
    if n > 0 then table.insert(d, hlg("b", "_diagnostic_info") .. diagnostics[prefix].info .. n) end
    n = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.HINT })
    if n > 0 then table.insert(d, hlg("b", "_diagnostic_hint") .. diagnostics[prefix].hint .. n) end

    if #d > 0 then
        table.insert(_b, table.concat(d, " "))
    end
    local b = table.concat(_b, hlg("b") .. " " .. separators.component.left .. " ")

    local _x = {}
    n = vim.opt.fileencoding:get()
    if #n > 0 then table.insert(_x, n) end
    n = vim.opt.fileformat:get()
    if #n > 0 then
        local m = fileformat.text[n]
        if vim.g.statusline_icons then
            local icon = fileformat.icons[n]
            if icon ~= nil then
                m = icon .. m
            end
        end
        table.insert(_x, m)
    end
    n = vim.opt.filetype:get()
    if #n > 0 then
        if vim.g.statusline_icons and devicons_ok then
            local icon, group = devicons.get_icon_by_filetype(n)
            if ft_hlgroups[group] == nil and group ~= nil and theme ~= nil then
                local hlgroup = vim.api.nvim_get_hl_by_name(group, true)
                group = "_" .. group
                vim.cmd.highlight("_statusline_c" .. group .. " guifg=#" .. string.format("%06x", hlgroup.foreground) .. " guibg=" .. theme.normal.c.bg .. " gui=nocombine")
                ft_hlgroups[group] = true
            end
            if icon == nil or group == nil then
                icon = ""
                group = highlight
            end
            n = hlg("c", group) .. icon .. hlg("c") .. " " .. n
        end
        table.insert(_x, n)
    end
    x = table.concat(_x, " " .. separators.component.right .. " ") .. " "

    local separator = advanced_terminal and separators.section.left or separators.component.left
    local s = hlg("a") .. a
    if #b > 0 then
        b = " " .. b .. " "
        s = s .. hlg("ab") .. separator .. hlg("b") .. b
        s = s .. hlg("bc") .. separator .. hlg("c")
    else
        s = s .. hlg("ac") .. separator .. hlg("c")
    end
    s = s .. " %<%f %h%w%m%r "
    s = s .. "%="
    separator = advanced_terminal and separators.section.right or separators.component.right
    s = s .. x .. hlg("bc") .. separator .. hlg("b")
    s = s .. " %P " .. hlg("ab") .. separator .. hlg("a")
    s = s .. " %l:%c "
    return s
end

vim.g.active_statusline = "%{%v:lua._statusline()%}"
vim.g.inactive_statusline = " %<%f %h%w%m%r %=%l:%c "
vim.opt.statusline = vim.g.active_statusline

vim.uv.new_timer():start(1000, 1000, function()
    vim.schedule(vim.cmd.redrawstatus)
end)
