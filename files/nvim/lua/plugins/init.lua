return {
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },
    {
        "lervag/vimtex",
        config = function()
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_syntax_enabled = 0
        end
    }
}
