local handle
local desktop = os.getenv("XDG_CURRENT_DESKTOP")
if (desktop == "KDE") then
    handle = io.popen(
        [=[qdbus --literal org.kde.keyboard /Layouts getLayoutsList | grep -oP ' \(sss\) \K[^]]*"' | sed -n $(expr $(qdbus --literal org.kde.keyboard /Layouts getLayout) + 1)p]=]
    )
elseif (desktop == "Hyprland") then
    handle = io.popen([[hyprctl devices -j | jq -r ".keyboards.[]|select(.main==true)|.active_keymap"]])
end

local function L() vim.cmd("norm! " ..
    math.max(1, math.floor(0.5 * vim.fn.getwininfo(vim.fn.win_getid())[1].height - 1)) .. "gjzzm'") end

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
        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w>n", "<C-w>j")
        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w>N", "<C-w>J")
        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w><C-n>", "<C-w><C-j>")

        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w>k", vim.cmd.vnew)
        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w>K", "<nop>")
        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w><C-k>", vim.cmd.vnew)

        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w>e", "<C-w>k")
        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w>E", "<C-w>K")
        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w><C-e>", "<C-w><C-k>")

        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w>j", "<nop>")
        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w>J", "<nop>")
        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w><C-j>", "<nop>")

        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w>i", "<C-w>l")
        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w>I", "<C-w>L")
        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w><C-i>", "<C-w><C-l>")

        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w>l", "<nop>")
        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w>L", "<nop>")
        vim.keymap.set({ "n", "x", "o", "t" }, "<C-w><C-l>", "<nop>")

        local nvls = require("nvls")
        local options = nvls.get_nvls_options()
        options.player.mappings.backward = "n"
        options.player.mappings.small_backward = "N"
        options.player.mappings.forward = "e"
        options.player.mappings.small_forward = "E"
        nvls.setup(options)
    end
end
