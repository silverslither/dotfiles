return {
    "lewis6991/gitsigns.nvim",
    dependencies = {
        "marko-cerovac/material.nvim",
        "nvim-tree/nvim-web-devicons"
    },
    opts = {
        status_formatter = function(status)
            local s = { " " }
            if status.added and status.added > 0 then
                table.insert(s, "%#_statusline_b_diff_added#+" .. status.added)
            end
            if status.changed and status.changed > 0 then
                table.insert(s, "%#_statusline_b_diff_modified#~" .. status.changed)
            end
            if status.removed and status.removed > 0 then
                table.insert(s, "%#_statusline_b_diff_removed#-" .. status.removed)
            end
            return " " .. status.head .. (#s > 1 and table.concat(s, " ") or "")
        end
    }
}
