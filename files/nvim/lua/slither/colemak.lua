local handle = nil
local desktop = os.getenv("XDG_CURRENT_DESKTOP")
if (desktop == "KDE") then
    handle = io.popen([=[qdbus --literal org.kde.keyboard /Layouts getLayoutsList | grep -oP ' \(sss\) \K[^]]*"' | sed -n $(expr $(qdbus --literal org.kde.keyboard /Layouts getLayout) + 1)p]=])
elseif (desktop == "Hyprland") then
    handle = io.popen([[hyprctl devices -j | jq -r ".keyboards.[]|select(.main==true)|.active_keymap"]])
end

local function L() vim.cmd("norm! " .. math.max(1, math.floor(0.5 * vim.fn.getwininfo(vim.fn.win_getid())[1].height - 1)) .. "gjzzm'") end

if (handle ~= nil) then
    local layout = handle:read("*a")
    handle:close()

    if (layout:find("Colemak")) then
        -- j -> n -> k -> e -> j, i <-> l
        vim.g.colemak_enabled = true

        -- movement, mode navigation
        vim.keymap.set({ "n", "x", "o" }, "n", "gj")
        vim.keymap.set({ "n", "x", "o" }, "gn", "j")
        vim.keymap.set({ "n", "o" }, "N", "mzJ`z")

        vim.keymap.set({ "n", "x", "o" }, "k", "nzzzv")
        vim.keymap.set({ "o" }, "gk", "gn")
        vim.keymap.set({ "n", "x", "o" }, "K", "Nzzzv")

        vim.keymap.set({ "n", "x", "o" }, "e", "gk")
        vim.keymap.set({ "n", "x", "o" }, "ge", "k")
        vim.keymap.set({ "n", "o" }, "E", "K")

        vim.keymap.set({ "n", "x", "o" }, "j", "e")
        vim.keymap.set({ "n", "x", "o" }, "J", "E")

        vim.keymap.set({ "n", "x" }, "i", "l")
        vim.keymap.set({ "n", "x" }, "I", L)
        vim.keymap.set({ "o" }, "I", "L")
        vim.keymap.set({ "n", "x" }, "l", "i")
        vim.keymap.set({ "n", "x", "o" }, "L", "I")

        -- editing
        vim.keymap.set("x", "N", ":m '>+1<CR>gv=gv")
        vim.keymap.set("x", "E", ":m '<-2<CR>gv=gv")

        -- tab navigation
        vim.keymap.set("n", "<leader>tk", vim.cmd.tabnew)
        vim.keymap.set("n", "<leader>tn", "<nop>")

        vim.keymap.set("t", "<Esc><leader>tk", vim.cmd.tabnew)
        vim.keymap.set("t", "<Esc><leader>tn", "<nop>")

        -- window navigation
        vim.keymap.set({ "n", "x", "o" }, "<C-n>", "<C-w>j")
        vim.keymap.set({ "n", "x", "o" }, "<C-w>n", "<C-w>J")
        vim.keymap.set("t", "<C-n>", "<C-\\><C-n><C-w>j")
        vim.keymap.set("t", "<C-w>n", "<C-\\><C-n><C-w>J")

        vim.keymap.set({ "n", "x", "o" }, "<C-w>k", vim.cmd.vnew)
        vim.keymap.set({ "n", "x", "o" }, "<C-w><C-k>", vim.cmd.vnew)

        vim.keymap.set({ "n", "x", "o" }, "<C-e>", "<C-w>k")
        vim.keymap.set({ "n", "x", "o" }, "<C-w>e", "<C-w>K")
        vim.keymap.set("t", "<C-e>", "<C-\\><C-n><C-w>k")
        vim.keymap.set("t", "<C-w>e", "<C-\\><C-n><C-w>K")

        vim.keymap.set({ "n", "x", "o", "t" }, "<C-j>", "<nop>")
        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w>j", "<nop>")

        vim.keymap.set({ "n", "x", "o" }, "<C-i>", "<C-w>l")
        vim.keymap.set({ "n", "x", "o" }, "<C-w>i", "<C-w>L")
        vim.keymap.set("t", "<C-i>", "<C-\\><C-n><C-w>l")
        vim.keymap.set("t", "<C-w>i", "<C-\\><C-n><C-w>L")

        vim.keymap.set({ "n", "x", "o", "t" }, "<C-l>", "<nop>")
        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w>l", "<nop>")

        local nvls = require("nvls")
        local options = nvls.get_nvls_options()
        options.player.mappings.backward = "n"
        options.player.mappings.small_backward = "N"
        options.player.mappings.forward = "e"
        options.player.mappings.small_forward = "E"
        nvls.setup(options)
    end
end
