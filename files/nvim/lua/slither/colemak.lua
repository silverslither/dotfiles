local handle
local desktop = os.getenv("XDG_CURRENT_DESKTOP")
if (desktop == "KDE") then
    handle = io.popen(
        [=[qdbus --literal org.kde.keyboard /Layouts getLayoutsList | grep -oP ' \(sss\) \K[^]]*"' | sed -n $(expr $(qdbus --literal org.kde.keyboard /Layouts getLayout) + 1)p]=]
    )
elseif (desktop == "Hyprland") then
    handle = io.popen([[hyprctl devices | grep at-translated-set-2-keyboard -A 2 | tail -n 1]])
end

function L() vim.cmd("norm! " .. math.max(1, math.floor(0.5 * vim.fn.getwininfo(vim.fn.win_getid())[1].height - 1)) .. "gjzzm'") end

if (handle ~= nil) then
    local layout = handle:read("*a")
    handle:close()

    if (layout:find("Colemak")) then
        vim.g.colemak_enabled = true

        -- j -> n -> k -> e -> j
        vim.keymap.set({ "n", "x", "o" }, "n", "gj")
        vim.keymap.set({ "n", "x", "o" }, "gn", "j")
        vim.keymap.set({ "n", "o" }, "N", "mzJ`z")
        vim.keymap.set("x", "N", ":m '>+1<CR>gv=gv")


        vim.keymap.set({ "n", "x", "o" }, "k", "nzzzv")
        vim.keymap.set({ "o" }, "gk", "gn")
        vim.keymap.set({ "n", "x", "o" }, "K", "Nzzzv")

        vim.keymap.set({ "n", "x", "o" }, "e", "gk")
        vim.keymap.set({ "n", "x", "o" }, "ge", "k")
        vim.keymap.set({ "n", "o" }, "E", "K")
        vim.keymap.set("x", "E", ":m '<-2<CR>gv=gv")

        vim.keymap.set({ "n", "x", "o" }, "j", "e")
        vim.keymap.set({ "n", "x", "o" }, "J", "E")

        -- i <-> l
        vim.keymap.set({ "n", "x" }, "i", "l")
        vim.keymap.set({ "n", "x" }, "I", L)
        vim.keymap.set({ "o" }, "I", "L")
        vim.keymap.set({ "n", "x" }, "l", "i")
        vim.keymap.set({ "n", "x", "o" }, "L", "I")
    end
end
