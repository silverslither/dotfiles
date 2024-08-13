return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>vc", vim.cmd.Git);
    end
}
