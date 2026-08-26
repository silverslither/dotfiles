local augroup = vim.api.nvim_create_augroup("slither", { clear = true })

vim.api.nvim_create_autocmd("ModeChanged", {
    group = augroup,
    callback = function() vim.cmd.redrawstatus() end
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = augroup,
    callback = function()
        if vim.api.nvim_win_get_config(vim.api.nvim_get_current_win()).relative ~= "" then return end
        vim.opt_local.statusline = vim.g.active_statusline
    end
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = augroup,
    callback = function()
        if vim.api.nvim_win_get_config(vim.api.nvim_get_current_win()).relative ~= "" then return end
        vim.opt_local.statusline = vim.g.inactive_statusline
    end
})

vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "*" },
    callback = function()
        if pcall(vim.treesitter.start) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end
})

vim.api.nvim_create_autocmd("BufReadPre", {
    group = augroup,
    callback = function(_args)
        local bufnr = _args.buf
        local filesize = vim.loop.fs_stat(vim.api.nvim_buf_get_name(bufnr)).size
        local lines = #vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
        if filesize < 2 * 1024 * 1024 and filesize / lines < 1024 then return true end

        vim.api.nvim_create_autocmd({ "LspAttach" }, {
            buffer = bufnr,
            callback = function(args)
                vim.schedule(function()
                    vim.lsp.buf_detach_client(buf, args.data.client_id)
                end)
            end,
        })

        vim.schedule(function()
            vim.treesitter.stop()
            vim.opt_local.swapfile = false
            vim.opt_local.foldmethod = "manual"
            vim.opt_local.undoreload = 0
            vim.opt_local.list = false
        end)
    end
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = augroup,
    command = "syntax sync fromstart",
    pattern = { "*.ly", "*.ily" }
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup,
    command = "LilyCmp",
    pattern = { "*.ly", "*.ily" }
})

vim.api.nvim_create_user_command("Redir", function(ctx)
    local lines = vim.split(vim.api.nvim_exec(ctx.args, true), "\n", { plain = true })
    vim.cmd.new()
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.opt_local.modified = false
    vim.opt_local.filetype = "text"
end, { nargs = "+", complete = "command" })
