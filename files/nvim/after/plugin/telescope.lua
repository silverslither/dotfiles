local previewers = require('telescope.previewers')
local previewers_utils = require('telescope.previewers.utils')

local max_size = 102400
local truncate = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then return end
        if stat.size > max_size then
            local cmd = {"head", "-c", max_size, filepath}
            previewers_utils.job_maker(cmd, bufnr, opts)
        else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
    end)
end

require('telescope').setup({
    defaults = {
        buffer_previewer_maker = truncate,
    }
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fr", builtin.git_files, {})
vim.keymap.set("n", "<leader>fs", builtin.live_grep, {})
