local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local vimtex_math_ctx = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

local not_vimtex_math_ctx = function()
    return vim.fn['vimtex#syntax#in_mathzone']() ~= 1
end

return {
    s({ trig = ";e" },
        fmta(
            [[
            \begin{<>}
                <>
            \end{<>}
            ]],
            { i(1), i(0), rep(1) }
        )
    ),

    s({ trig = "--" },
        t("\\item")
    ),

    s({ trig = ";s" },
        fmta(
            "\\<>{<>}",
            { i(1), i(2) }
        )
    ),

    s({ trig = ";d" },
        fmta(
            "\\<>{<>}{<>}",
            { i(1), i(2), i(3) }
        )
    ),

    s({ trig = ";t" },
        fmta(
            "\\text<>{<>}",
            { i(1), i(2) }
        ),
        { show_condition = not_vimtex_math_ctx }
    ),

    s({ trig = ";t" },
        fmta(
            "\\math<>{<>}",
            { i(1), i(2) }
        ),
        { show_condition = vimtex_math_ctx }
    ),

    s({ trig = ";1" },
        fmta(
            [[
            \medskip\\
            <>
            ]],
            { i(0) }
        ),
        { show_condition = not_vimtex_math_ctx }
    ),

    s({ trig = ";2" },
        fmta(
            [[
            \bigskip\\
            <>
            ]],
            { i(0) }
        ),
        { show_condition = not_vimtex_math_ctx }
    ),

    s({ trig = ";3" },
        fmta(
            [[
            \bigskip\bigskip\\
            <>
            ]],
            { i(0) }
        ),
        { show_condition = not_vimtex_math_ctx }
    ),
}
