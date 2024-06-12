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
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local not_vimtex_math_ctx = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() ~= 1
end

return {
    s({ trig = ";m" },
        fmta(
            "$<>$",
            { i(1) }
        ),
        { show_condition = not_vimtex_math_ctx }
    ),

    s({ trig = ";f" },
        fmta(
            "\\frac{<>}{<>}",
            { i(1), i(2) }
        ),
        { show_condition = vimtex_math_ctx }
    ),

    s({ trig = ";u" },
        fmta(
            "^{<>}",
            { i(1) }
        ),
        { show_condition = vimtex_math_ctx }
    ),

    s({ trig = ";b" },
        fmta(
            "_{<>}",
            { i(1) }
        ),
        { show_condition = vimtex_math_ctx }
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
