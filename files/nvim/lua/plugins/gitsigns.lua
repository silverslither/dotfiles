local function remap_blame_open(event)
    local buf = event.buf
    if not vim.api.nvim_buf_is_valid(buf) then return end

    local edit = vim.iter(vim.api.nvim_buf_get_keymap(buf, "n")):find(function(map)
        return map.lhs == "e" and map.desc == "Show commit in current window"
    end)
    if not edit or not edit.callback then return end

    vim.keymap.set("n", "o", edit.callback, { buffer = buf, expr = true, desc = edit.desc })
    vim.keymap.del("n", "e", { buffer = buf })

    local menu = "]GitsignsBlame"
    local item = vim.iter(vim.fn.menu_info(menu, "n").submenus or {}):find(function(label)
        return vim.endswith(label, "(current window) (e)")
    end)
    if not item then return end

    local path = menu .. "." .. vim.fn.escape(item, " ")
    local new_path = path:gsub("%(e%)$", "(o)")
    vim.cmd("nunmenu " .. path)
    vim.cmd("nmenu <silent> " .. new_path .. " o")
end

local function _config()
    require("gitsigns").setup({
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
            return " " .. (status.head == nil and "" or status.head) .. (#s > 1 and table.concat(s, " ") or "")
        end
    })

    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("slither.gitsigns", { clear = true }),
        pattern = "gitsigns-blame",
        callback = vim.schedule_wrap(remap_blame_open),
    })
end

return {
    "lewis6991/gitsigns.nvim",
    dependencies = {
        "marko-cerovac/material.nvim",
        "nvim-tree/nvim-web-devicons"
    },
    config = _config
}
