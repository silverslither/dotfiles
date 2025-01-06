local group = vim.api.nvim_create_augroup("slither", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
    group = group,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scl = "no"
        vim.cmd("startinsert")
    end
})

vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    pattern = "term://*",
    callback = function()
        vim.cmd("startinsert")
    end
})
