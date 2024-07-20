local handle
local desktop = os.getenv("XDG_CURRENT_DESKTOP")
if (desktop == "KDE") then
    handle = io.popen([=[qdbus --literal org.kde.keyboard /Layouts getLayoutsList | grep -oP ' \(sss\) \K[^]]*"' | sed -n $(expr $(qdbus --literal org.kde.keyboard /Layouts getLayout) + 1)p]=])
elseif (desktop == "Hyprland") then
    handle = io.popen([[hyprctl devices | grep at-translated-set-2-keyboard -A 2 | tail -n 1]])
end

if (handle ~= nil) then
    local layout = handle:read("*a")
    handle:close()

    if (layout:find("Colemak")) then
        -- j -> n -> k -> e -> j  |  i <-> l
        vim.cmd("set langmap=nj,NJ,kn,KN,ek,EK,je,JE,il,IL,li,LI")
    end
end
