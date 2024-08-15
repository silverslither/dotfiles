return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            win_options = {
                signcolumn = "yes"
            },
            delete_to_trash = true,
            view_options = {
                show_hidden = true
            }
        })
        vim.keymap.set("n", "<leader>e", vim.cmd.Oil)
    end
}
