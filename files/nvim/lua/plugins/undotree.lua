local function _config()
    vim.keymap.set("n", "<leader>u", function()
        local width = math.floor(0.5 * vim.o.columns)
        vim.g.undotree_CustomUndotreeCmd = ("botright vertical %d new"):format(width)
        vim.cmd.UndotreeToggle()
    end)
end

return {
    "mbbill/undotree",
    config = _config
}
