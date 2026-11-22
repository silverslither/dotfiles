local augroup = vim.api.nvim_create_augroup("slither", { clear = true })

vim.api.nvim_create_autocmd("ModeChanged", {
    group = augroup,
    callback = function() vim.schedule(vim.cmd.redrawstatus) end
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

vim.api.nvim_create_user_command("Redir", function(ctx)
    local lines = vim.split(vim.api.nvim_exec(ctx.args, true), "\n", { plain = true })
    vim.cmd.new()
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.opt_local.modified = false
    vim.opt_local.filetype = "text"
end, { nargs = "+", complete = "command" })

vim.api.nvim_create_user_command("MergeCompileCommands", function()
    local root = vim.fn.getcwd()
    local output = vim.fs.normalize(root .. "/compile_commands.json")

    local databases = vim.tbl_filter(function(path)
        return vim.fs.normalize(path) ~= output
    end, vim.fn.glob(root .. "/**/compile_commands.json", false, true))

    table.sort(databases)

    if #databases == 0 then
        vim.notify("No compile_commands.json files found", vim.log.levels.WARN)
        return
    end

    local merged, indices = {}, {}

    local function absolute(path, base)
        if not path:match("^/") then
            path = base .. "/" .. path
        end
        return vim.fs.normalize(path)
    end

    for _, db in ipairs(databases) do
        local ok, entries = pcall(
            vim.json.decode,
            table.concat(vim.fn.readfile(db), "\n")
        )

        if not ok or type(entries) ~= "table" then
            vim.notify("Invalid database: " .. db, vim.log.levels.ERROR)
            return
        end

        for _, entry in ipairs(entries) do
            local dir = absolute(entry.directory, vim.fs.dirname(db))
            local file = absolute(entry.file, dir)

            entry.directory = dir
            entry.file = file

            if indices[file] then
                merged[indices[file]] = entry
            else
                merged[#merged + 1] = entry
                indices[file] = #merged
            end
        end
    end

    vim.fn.writefile(
        { vim.json.encode(merged) },
        root .. "/compile_commands.json"
    )

    vim.notify(
        string.format("Merged %d databases, %d files", #databases, #merged)
    )
end, {})
