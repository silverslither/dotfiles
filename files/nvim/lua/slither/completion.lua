local group = vim.api.nvim_create_augroup("slither.completion", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client or not client:supports_method("textDocument/completion", event.buf) then return end

        vim.bo[event.buf].completeopt = "menu,menuone,noselect,popup"
        vim.bo[event.buf].autocomplete = false
        vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })

        vim.api.nvim_clear_autocmds({ group = group, buffer = event.buf, event = "InsertCharPre" })
        vim.api.nvim_create_autocmd("InsertCharPre", {
            group = group,
            buffer = event.buf,
            callback = function()
                if vim.fn.match(vim.v.char, [[^\k$]]) >= 0 then
                    vim.schedule(vim.lsp.completion.get)
                end
            end,
        })
    end,
})

local function map_popup_key(key, action)
    vim.keymap.set("i", key, function()
        return vim.fn.pumvisible() == 1 and action or key
    end, { expr = true })
end

if vim.g.colemak_enabled then
    map_popup_key("<C-e>", "<C-p>")
else
    map_popup_key("<C-j>", "<C-n>")
    map_popup_key("<C-k>", "<C-p>")
    map_popup_key("<C-n>", "<Ignore>")
end

map_popup_key("<C-p>", "<Ignore>")
map_popup_key("<C-y>", "<Ignore>")

vim.keymap.set({ "i", "s" }, "<Tab>", function()
    if vim.fn.pumvisible() == 1 then
        if vim.fn.complete_info({ "selected" }).selected >= 0 then
            return "<C-y>"
        end

        local first = vim.fn.complete_info({ "matches" }).matches[1]
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local typed = vim.api.nvim_get_current_line():sub(1, col)
        local fully_typed = first and first.word ~= "" and vim.endswith(typed, first.word) and vim.fn.match(typed:sub(1, #typed - #first.word), [[\k$]]) == -1

        if not fully_typed then
            return "<C-n><C-y>"
        end
    end

    if vim.snippet.active({ direction = 1 }) then
        return "<Cmd>lua vim.snippet.jump(1)<CR>"
    end

    return "<Tab>"
end, { expr = true })
