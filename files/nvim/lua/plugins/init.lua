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
        end
    }
}
