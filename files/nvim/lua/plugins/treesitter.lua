function _config()
    vim.api.nvim_create_autocmd("FileType", {
        callback = function()
            if pcall(vim.treesitter.start) then
                -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                -- vim.wo.foldmethod = 'expr'
                vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
            end
        end,
    })
end

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = _config
}
