function _tabline()
    local s = ""

    for i = 1, vim.fn.tabpagenr("$") do
        s = s .. ((i == vim.fn.tabpagenr()) and "%#TabLineSel#" or "%#TabLine#")

        local buflist = vim.fn.tabpagebuflist(i)
        local winnr = vim.fn.tabpagewinnr(i)
        local mod = vim.fn.getbufvar(buflist[winnr], "&mod")
        local bufname = vim.fn.bufname(buflist[winnr])
        bufname = (bufname == "") and "[No Name]" or vim.fn.fnamemodify(bufname, ":t")

        s = s .. "%" .. i .. "T " .. i .. ((mod == 1) and "[+] " or " ") .. bufname .. " "
    end

    s = s .. "%#TabLineFill#%T"
    return s
end

vim.cmd("highlight TabLineSel gui=bold")

vim.opt.tabline = "%!v:lua._tabline()"
