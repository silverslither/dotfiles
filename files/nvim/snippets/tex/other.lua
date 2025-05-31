local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

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

    s({ trig = ";ss" },
        fmta(
            "\\<>{<>}{<>}",
            { i(1), i(2), i(3) }
        )
    ),

    s({ trig = ";tu" },
        fmta(
            "\\textsuperscript{<>}",
            { i(1) }
        )
    ),

    s({ trig = ";td" },
        fmta(
            "\\textsubscript{<>}",
            { i(1) }
        )
    ),

    s({ trig = ";1" },
        fmta(
            [[
            \smallskip

            <>
            ]],
            { i(0) }
        )
    ),

    s({ trig = ";2" },
        fmta(
            [[
            \medskip

            <>
            ]],
            { i(0) }
        )
    ),

    s({ trig = ";3" },
        fmta(
            [[
            \bigskip

            <>
            ]],
            { i(0) }
        )
    ),
}
