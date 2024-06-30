handle = io.popen([=[qdbus --literal org.kde.keyboard /Layouts getLayoutsList | grep -oP ' \(sss\) \K[^]]*"' | sed -n $(expr $(qdbus --literal org.kde.keyboard /Layouts getLayout) + 1)p]=])
layout = handle:read("*a")
handle:close()

if (layout:find("Colemak")) then
    -- j -> n -> k -> e -> j  |  i <-> l
    vim.cmd("set langmap=nj,NJ,kn,KN,ek,EK,je,JE,il,IL,li,LI")
end
