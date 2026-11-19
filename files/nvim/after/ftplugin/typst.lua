vim.keymap.set("n", "<leader>ll", function()
    local typ = vim.fn.shellescape(vim.fn.expand("%:p"))
    local pdf = vim.fn.shellescape(vim.fn.expand("%:p:r") .. ".pdf")

    local cmd = string.format(
        [[typst watch -- %s >/dev/null 2>&1 & pid=$!; trap 'kill "$pid" 2>/dev/null' EXIT; zathura -- %s]],
        typ, pdf
    )

    vim.fn.jobstart({ "sh", "-c", cmd }, { detach = true })
end, {
    buffer = true,
})
