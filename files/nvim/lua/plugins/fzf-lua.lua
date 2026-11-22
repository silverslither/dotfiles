local function _previewer(_, _, opts)
    local previewer = require("fzf-lua.previewer").new("builtin", opts)
    local parse_entry = previewer.parse_entry
    local max_size = 102400

    function previewer:parse_entry(entry_str, callback)
        local entry = parse_entry(self, entry_str, callback)
        if entry and entry.path and not entry.uri and not entry.cmd then
            local stat = vim.uv.fs_stat(entry.path)
            if stat and stat.type == "file" and stat.size > max_size then
                entry.bufnr = nil
                entry.cmd = { "head", "-c", tostring(max_size), "--", entry.path }
            end
        end
        return entry
    end

    return previewer
end

local function _config()
    local fzf_lua = require("fzf-lua")

    fzf_lua.setup({
        "skim",
        fzf_opts = {
            ["--algo"] = "arinae",
            ["--typos"] = true,
            ["--layout"] = "default"
        },
        keymap = {
            fzf = {
                true,
                ["tab"] = "toggle+up",
                ["shift-btab"] = "toggle+down"
            }
        },
        files = {
            no_ignore = true,
            hidden = false
        },
        winopts = {
            preview = {
                default = { new = _previewer }
            }
        }
    })

    vim.keymap.set("n", "<leader>fe", fzf_lua.files, {})
    vim.keymap.set("n", "<leader>fs", fzf_lua.live_grep, {})
    vim.keymap.set("n", "<leader>b", fzf_lua.buffers, {})
    vim.keymap.set("n", "g/", fzf_lua.lsp_document_symbols, {})
    vim.keymap.set("n", "gr", function()
        fzf_lua.lsp_references({ jump1 = false })
    end, {})
end

return {
    "ibhagwan/fzf-lua",
    config = _config
}
