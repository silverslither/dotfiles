local group = vim.api.nvim_create_augroup("slither", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
    group = group,
    callback = function()
        vim.cmd.startinsert()
    end
})

vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    pattern = "term://*",
    callback = function()
        vim.cmd.startinsert()
    end
})

vim.api.nvim_create_user_command("Redir", function(ctx)
    local lines = vim.split(vim.api.nvim_exec(ctx.args, true), "\n", { plain = true })
    vim.cmd.new()
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.opt_local.modified = false
    vim.opt_local.filetype = "text"
end, { nargs = "+", complete = "command" })
