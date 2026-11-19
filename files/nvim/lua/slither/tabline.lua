local is_windows = vim.fn.has("win32") == 1

local function proc_info(pid)
    local f = io.open("/proc/" .. pid .. "/stat")
    if not f then return end

    local stat = f:read("*l")
    f:close()
    if not stat then return end

    local name, fields = stat:match("^%d+ %((.*)%) (.+)$")
    if not fields then return end

    local pgid, tpgid = fields:match("^%S+ %S+ (%S+) %S+ %S+ (%S+)")

    return name, tonumber(pgid), tonumber(tpgid)
end

local DEFAULT_TERM_TITLE = "term"
local function term_program(bufnr)
    if is_windows then return DEFAULT_TERM_TITLE end

    local channel = vim.bo[bufnr].channel
    if channel == 0 then return DEFAULT_TERM_TITLE end

    local ok, pid = pcall(vim.fn.jobpid, channel)
    if not ok or not pid or pid <= 0 then return DEFAULT_TERM_TITLE end

    local name, pgid, tpgid = proc_info(pid)
    if not name then return DEFAULT_TERM_TITLE end
    if not tpgid or tpgid <= 0 or tpgid == pgid then return name end

    return (proc_info(tpgid)) or name
end

function _tabline()
    local s = ""

    for i = 1, vim.fn.tabpagenr("$") do
        s = s .. ((i == vim.fn.tabpagenr()) and "%#TabLineSel#" or "%#TabLine#")

        local buflist = vim.fn.tabpagebuflist(i)
        local winnr = vim.fn.tabpagewinnr(i)
        local bufnr = buflist[winnr]
        local mod = vim.fn.getbufvar(bufnr, "&mod")
        local bufname = vim.fn.bufname(bufnr)
        local tabtitle

        if vim.bo[bufnr].buftype == "terminal" then
            tabtitle = term_program(bufnr)
        else
            tabtitle = (bufname == "") and "[No Name]" or vim.fn.fnamemodify(bufname, ":t")
            if tabtitle == "" then -- for oil
                tabtitle = vim.fn.fnamemodify(bufname:sub(1, -2), ":t")
            end
        end

        tabtitle = tabtitle:gsub("%%", "%%%%")

        s = s .. "%" .. i .. "T " .. i .. ((mod == 1) and "[+] " or " ") .. tabtitle .. " "
    end

    s = s .. "%#TabLineFill#%T"
    return s
end

vim.cmd.highlight("TabLineSel gui=bold")
vim.o.tabline = "%!v:lua._tabline()"

if not is_windows then
    if vim._tabline_timer then
        vim._tabline_timer:stop()
        vim._tabline_timer:close()
    end

    vim._tabline_timer = vim.uv.new_timer()
    vim._tabline_timer:start(1000, 1000, vim.schedule_wrap(function()
        vim.cmd.redrawtabline()
    end))
end
