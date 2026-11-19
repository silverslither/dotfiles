local function _config()
    local augroup = vim.api.nvim_create_augroup("slither.treesitter", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        pattern = { "*" },
        callback = function()
            if pcall(vim.treesitter.start) then
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        end
    })
end

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = _config
}
