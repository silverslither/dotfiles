local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
    s({ trig = ";m" },
        fmta(
            "$<>$",
            { i(1) }
        )
    ),

    s({ trig = ";f" },
        fmta(
            "\\frac{<>}{<>}",
            { i(1), i(2) }
        )
    ),

    s({ trig = ";u" },
        fmta(
            "^{<>}",
            { i(1) }
        )
    ),

    s({ trig = ";b" },
        fmta(
            "_{<>}",
            { i(1) }
        )
    ),

    s({ trig = "+-" }, t("\\pm")),

    s({ trig = "-+" }, t("\\mp")),

    s({ trig = "!=" }, t("\\neq")),

    s({ trig = "<=" }, t("\\leq")),

    s({ trig = ">=" }, t("\\geq")),

    s({ trig = "<<" }, t("\\ll")),

    s({ trig = ">>" }, t("\\gg")),

    s({ trig = "~~" }, t("\\sim")),

    s({ trig = "~=" }, t("\\approx")),

    s({ trig = "-=" }, t("\\equiv")),

    s({ trig = "**" }, t("\\cdot")),

    s({ trig = ";x" }, t("\\times")),

    s({ trig = "+O" }, t("\\oplus")),

    s({ trig = "*O" }, t("\\otimes")),

    s({ trig = "->" }, t("\\rightarrow")),
    s({ trig = "-->" }, t("\\longrightarrow")),
    s({ trig = "=>" }, t("\\implies")),
    s({ trig = "==>" }, t("\\Rightarrow")),
    s({ trig = "===>" }, t("\\Longrightarrow")),

    s({ trig = "<-" }, t("\\leftarrow")),
    s({ trig = "<--" }, t("\\longleftarrow")),
    s({ trig = "<=" }, t("\\impliedby")),
    s({ trig = "<==" }, t("\\Leftarrow")),
    s({ trig = "<===" }, t("\\Longleftarrow")),

    s({ trig = "<->" }, t("\\leftrightarrow")),
    s({ trig = "<-->" }, t("\\longleftrightarrow")),
    s({ trig = "<=>" }, t("\\iff")),
    s({ trig = "<==>" }, t("\\Leftrightarrow")),
    s({ trig = "<===>" }, t("\\Longleftrightarrow")),

    --s({ trig = "|->" }, t("\\mapsto")),
    --s({ trig = "|-->" }, t("\\longmapsto")),
}
