return {
    "L3MON4D3/LuaSnip",
    -- 去掉 ft 限制，防止因未识别文件类型导致插件不初始化
    lazy = false, 
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        local ls = require("luasnip")
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local f = ls.function_node
        local d = ls.dynamic_node
        local sn = ls.snippet_node
        local fmta = require("luasnip.extras.fmt").fmta

        -- ===================================================================
        -- 【关键修复】快捷键绑定：让 Tab 键具备展开和跳转占位符的功能
        -- ===================================================================
        vim.keymap.set({"i", "s"}, "<Tab>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            else
                -- 如果没有可展开的，就输入正常的 Tab
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
            end
        end, { silent = true })

        vim.keymap.set({"i", "s"}, "<S-Tab>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, { silent = true })

        -- 允许 autosnippet (自动触发)
        ls.config.set_config({
            enable_autosnippets = true,
            history = true,
            updateevents = "TextChanged,TextChangedI",
        })

        -----------------------------------------------------------------------
        -- 1. 环境检查函数 (Context Functions)
        -----------------------------------------------------------------------
        local function in_mathzone()
            return vim.fn['vimtex#syntax#in_mathzone']() == 1
        end

        local function in_comment()
            return vim.fn['vimtex#syntax#in_comment']() == 1
        end

        local math_cond = { show_condition = in_mathzone, condition = in_mathzone }

        -- ==============================================================
        -- =====新增：检查当前光标是否处于行首（或者是纯缩进/纯空格之后）
        -- ==============================================================
        local function at_line_start(line_to_cursor, triggered_trig)
        -- 去掉当前触发词后，判断光标前的字符串是否只包含空格或制表符
        local line_before_trig = line_to_cursor:sub(1, #line_to_cursor - #triggered_trig)
        return line_before_trig:match("^%s*$") ~= nil
end

        -- 创建行首触发的条件对象
        local line_start_cond = { show_condition = at_line_start, condition = at_line_start }
        local math_cond = { show_condition = in_mathzone, condition = in_mathzone }

        -----------------------------------------------------------------------
        -- 2. 辅助函数 (Helper Functions for Visual Selection)
        -----------------------------------------------------------------------
        local function get_visual(_, snip)
            return snip.env.TM_SELECTED_TEXT or {}
        end

        -----------------------------------------------------------------------
        -- 3. 加载 LaTeX 代码片段
        -----------------------------------------------------------------------
        ls.add_snippets("tex", {

            -------------------------------------------------------------------
            -- 普通/全局代码片段 (Global Snippets)
            -------------------------------------------------------------------

            -- template: 基础模板
            s({ trig = "template" }, 
                fmta([[
\RequirePackage{luatex85}
\documentclass[lualatex]{ltjs<>}
\usepackage{luatexja}
\usepackage{mathtools}
\usepackage{xcolor}
\usepackage{mathrsfs}
\usepackage{pifont}
\usepackage{bm}
\usepackage{tikz}
\usepackage{dsfont}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage[all]{xy}
\usepackage{bookmark}
\usepackage{xurl}
\hypersetup{unicode,bookmarksnumbered=true,hidelinks,final} 
\newtheorem{theorem}{Theorem}[section]
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{claim}[theorem]{Claim}
\theoremstyle{remark}
\newtheorem{remark}{Remark}
\theoremstyle{plain} 
\newtheorem{example}[theorem]{Example}
\newtheorem{exercise}[theorem]{Exercise}

\newcommand{\jtoday}{\number \year 年 \number \month 月 \number \day 日}

\everymath{\displaystyle}
\begin{document}
\centerline{\Large <>}
\rightline{Arnold Robinson (鄒暁城)}
\rightline{\jtoday}
%\maketitle
% \setcounter{chapter}{-1}
% \tableofcontents
<>
\end{document}
                ]], { i(1, "article"), i(2), i(0) })
            ),

            -- beg: begin{} / end{}
            s({ trig = "beg"  }, 
                fmta([[
\begin{<>}
% \label{<>:<>}
	<>
\end{<>}
                ]], { i(1), i(1), i(3), i(0), i(1) })
            ),

            -- ... : ldots
            s({ trig = "...", priority = 100, snippetType = "autosnippet" }, { t([[\ldots]]) }),

            -- table: 表格环境
            s({ trig = "table" },
                fmta([[
\begin{table}[<>]
	\centering
	\caption{<>}
	\label{tab:<>}
	\begin{tabular}{<>}
	<>
	\end{tabular}
\end{table}
                ]], { i(1, "htpb"), i(2, "caption"), i(3, "label"), i(4, "c"), i(0) })
            ),

            -- fig: 图片环境
            s({ trig = "fig" },
                fmta([[
\begin{figure}[<>]
	\centering
	\<>{\includegraphics[width=0.8\textwidth]{<>}}
	\caption{<>}
	\label{fig:<>}
\end{figure}
                ]], { i(1, "htpb"), i(2, ""), i(3), i(4, "caption"), i(5, "label") })
            ),

            -- enum: Enumerate
            s({ trig = "enum", line_start_cond },
                fmta([[
\begin{enumerate}
	\item <>
\end{enumerate}
                ]], { i(0) })
            ),

            -- item: Itemize
            s({ trig = "item", line_start_cond  },
                fmta([[
\begin{itemize}
	\item <>
\end{itemize}
                ]], { i(0) })
            ),

            -- desc: Description
            s({ trig = "desc" },
                fmta([[
\begin{description}
	\item[<>] <>
\end{description}
                ]], { i(1), i(0) })
            ),

            -- pac: Package
            s({ trig = "pac" },
                fmta([[\usepackage[<>]{<>}<>]], { i(1, "options"), i(2, "package"), i(0) })
            ),

            -- => : implies
            s({ trig = "=>", snippetType = "autosnippet" }, { t([[\implies ]]) }),

            -- =< : implied by
            s({ trig = "=<", snippetType = "autosnippet" }, { t([[\impliedby ]]) }),

            -- mk : 行内数学公式
            s({ trig = "mk", snippetType = "autosnippet" },
                fmta([[$<>$<>]], { i(1), i(0) })
            ),

            -- dm : 行间数学公式
            s({ trig = "dm", snippetType = "autosnippet" },
                fmta([[
\begin{equation}
	\begin{aligned}
		<>
	\end{aligned}
\end{equation} <>
                ]], { d(1, function(_, snip) return ls.snippet_node(nil, { i(1, get_visual(nil, snip)) }) end), i(0) })
            ),

            -- ali : Align* 环境
            s({ trig = "ali", snippetType = "autosnippet", line_start_cond  },
                fmta([[
\begin{align*}
	<>
.\end{align*}
                ]], { d(1, function(_, snip) return ls.snippet_node(nil, { i(1, get_visual(nil, snip)) }) end) })
            ),

            -- == : 换行对齐等号
            s({ trig = "==", snippetType = "autosnippet" },
                fmta([[&= <> \\ ]], { i(1) })
            ),

            -- != : 不等于
            s({ trig = "!=", snippetType = "autosnippet" }, { t([[\neq ]]) }),

            -- 矩阵与括号组件
            s({ trig = "pmat", snippetType = "autosnippet" }, fmta([[\begin{pmatrix} <> \end{pmatrix} <>]], { i(1), i(0) })),
            s({ trig = "bmat", snippetType = "autosnippet" }, fmta([[\begin{bmatrix} <> \end{bmatrix} <>]], { i(1), i(0) })),

            s({ trig = "lr", snippetType = "autosnippet" }, fmta([[\left( <> \right) <>]], { d(1, function(_, snip) return ls.snippet_node(nil, { i(1, get_visual(nil, snip)) }) end), i(0) })),
            s({ trig = "lr(", snippetType = "autosnippet" }, fmta([[\left( <> \right) <>]], { d(1, function(_, snip) return ls.snippet_node(nil, { i(1, get_visual(nil, snip)) }) end), i(0) })),
            s({ trig = "lr|", snippetType = "autosnippet" }, fmta([[\left| <> \right| <>]], { d(1, function(_, snip) return ls.snippet_node(nil, { i(1, get_visual(nil, snip)) }) end), i(0) })),
            s({ trig = "lr{", snippetType = "autosnippet" }, fmta([[\left\{ <> \right\} <>]], { d(1, function(_, snip) return ls.snippet_node(nil, { i(1, get_visual(nil, snip)) }) end), i(0) })),
            s({ trig = "lrb", snippetType = "autosnippet" }, fmta([[\left\{ <> \right\} <>]], { d(1, function(_, snip) return ls.snippet_node(nil, { i(1, get_visual(nil, snip)) }) end), i(0) })),
            s({ trig = "lr[", snippetType = "autosnippet" }, fmta([[\left[ <> \right] <>]], { d(1, function(_, snip) return ls.snippet_node(nil, { i(1, get_visual(nil, snip)) }) end), i(0) })),

            -- 常用微积分与求和
            s({ trig = "sum" }, fmta([[\sum_{<>}^{<>} <>]], { i(1), i(2), i(0) })),
            s({ trig = "taylor" }, fmta([[\sum_{<>=\mu}^{<>} <> (x-a)^<> <>]], { i(1, "k"), i(2, [[\infty]]), i(3, "c_k"), i(1, "k"), i(0) })),
            s({ trig = "lim" }, fmta([[\lim_{<> \to <>} ]], { i(1, "n"), i(2, [[\infty]]) })),
            s({ trig = "limsup" }, fmta([[\limsup_{<> \to <>} ]], { i(1, "n"), i(2, [[\infty]]) })),
            s({ trig = "prod" }, fmta([[\prod_{<>}^{<>} <> <>]], { i(1, "n=1"), i(2, [[\infty]]), d(3, function(_, snip) return ls.snippet_node(nil, { i(1, get_visual(nil, snip)) }) end), i(0) })),
            s({ trig = "part" }, fmta([[\frac{\partial <>}{\partial <>} <>]], { i(1, "V"), i(2, "x"), i(0) })),

            -- 样式与 TikZ
            s({ trig = "R0+" }, { t([[\R_0^+]]) }),
            s({ trig = "SI", snippetType = "autosnippet" }, fmta([[\SI{<>}{<>}]], { i(1), i(2) })),
            s({ trig = "bigfun", snippetType = "autosnippet" }, 
                fmta([[
\begin{align*}
	<>: <> &\longrightarrow <> \\
	<> &\longmapsto <>(<>) = <>
.\end{align*}
                ]], { i(1), i(2), i(3), i(4), i(1), i(4), i(0) })
            ),
            s({ trig = "cvec", snippetType = "autosnippet" }, fmta([[\begin{pmatrix} <>_1\\ \vdots\\ <>_n \end{pmatrix}]], { i(1, "x"), i(1, "x") })),
            s({ trig = "plot" },
                fmta([[
\begin{figure}[<>]
	\centering
	\begin{tikzpicture}
		\begin{axis}[
			xmin= <>, xmax= <>,
			ymin= <>, ymax = <>,
			axis lines = middle,
		]
			\addplot[domain=<>:<>, samples=<>]{<>};
		\end{axis}
	\end{tikzpicture}
	\caption{<>}
	\label{<>}
\end{figure}
                ]], { i(1), i(2, "-10"), i(3, "10"), i(4, "-10"), i(5, "10"), i(2, "-10"), i(3, "10"), i(6, "100"), i(7), i(8), i(9) })
            ),
            s({ trig = "nn" }, fmta([[\node[<>] (<>) <> {$<>$};<>]], { i(5), i(1), i(3, "at (0,0)"), i(1), i(0) })),
            
            s({ trig = "bf" }, fmta([[\textbf{<>} <>]], { i(1), i(0) })),
            s({ trig = "it" }, fmta([[\textit{<>} <>]], { i(1), i(0) })),
            s({ trig = "col" }, fmta([[\textcolor{<>}{<>} <>]], { i(1, "red"), i(2), i(0) })),


            -------------------------------------------------------------------
            -- 数学环境专属代码片段 (Math-Zone Exclusive Snippets)
            -------------------------------------------------------------------

            -- iff: 当且仅当
            s({ trig = "iff", snippetType = "autosnippet" }, { t([[\iff ]]) }, math_cond),

            -- 分式
            s({ trig = "//", snippetType = "autosnippet" }, fmta([[\frac{<>}{<>}<>]], { i(1), i(2), i(0) }), math_cond),
            s({ trig = "/", priority = 100 }, fmta([[\frac{<>}{<>}<>]], { d(1, function(_, snip) return ls.snippet_node(nil, { i(1, get_visual(nil, snip)) }) end), i(2), i(0) }), math_cond),

            -- 上下取整与基础括号
            s({ trig = "ceil", snippetType = "autosnippet" }, fmta([[\left\lceil <> \right\rceil <>]], { i(1), i(0) }), math_cond),
            s({ trig = "floor", snippetType = "autosnippet" }, fmta([[\left\lfloor <> \right\rfloor<>]], { i(1), i(0) }), math_cond),
            s({ trig = "()", snippetType = "autosnippet" }, fmta([[\left( <> \right) <>]], { d(1, function(_, snip) return ls.snippet_node(nil, { i(1, get_visual(nil, snip)) }) end), i(0) }), math_cond),
            
            -- lra：内部包含尖括号，对其占位符宏进行转义避免冲突
            s({ trig = "lra", snippetType = "autosnippet" }, fmta([[\left\langle <>\right\rangle]], { d(1, function(_, snip) return ls.snippet_node(nil, { i(1, get_visual(nil, snip)) }) end) }), math_cond),

            -- 数学符号快捷键
            s({ trig = "conj", snippetType = "autosnippet" }, fmta([[\overline{<>}<>]], { i(1), i(0) }), math_cond),
            s({ trig = "sq", snippetType = "autosnippet" }, fmta([[\sqrt{<>} <>]], { d(1, function(_, snip) return ls.snippet_node(nil, { i(1, get_visual(nil, snip)) }) end), i(0) }), math_cond),
            s({ trig = "sr", snippetType = "autosnippet" }, { t("^2") }, math_cond),
            s({ trig = "cb", snippetType = "autosnippet" }, { t("^3") }, math_cond),
            s({ trig = "^^", snippetType = "autosnippet" }, fmta([[^{<>}<>]], { i(1), i(0) }), math_cond),
            s({ trig = "rd", snippetType = "autosnippet" }, fmta([[^{(<>)}<>]], { i(1), i(0) }), math_cond),
            s({ trig = "__", snippetType = "autosnippet" }, fmta([[_{<>}<>]], { i(1), i(0) }), math_cond),
            s({ trig = "ooo", snippetType = "autosnippet" }, { t([[\infty]]) }, math_cond),
            
            s({ trig = "rij" }, fmta([[(<>_n)_{<>\in\N}<>]], { i(1, "x"), i(2, "n"), i(0) }), math_cond),
            s({ trig = "<=", snippetType = "autosnippet" }, { t([[\le ]]) }, math_cond),
            s({ trig = ">=", snippetType = "autosnippet" }, { t([[\ge ]]) }, math_cond),
            s({ trig = "EE", snippetType = "autosnippet" }, { t([[\exists ]]) }, math_cond),
            s({ trig = "AA", snippetType = "autosnippet" }, { t([[\forall ]]) }, math_cond),
            
            -- 常用下标变量
            s({ trig = "xnn", snippetType = "autosnippet" }, { t("x_{n}") }, math_cond),
            s({ trig = "ynn", snippetType = "autosnippet" }, { t("y_{n}") }, math_cond),
            s({ trig = "xii", snippetType = "autosnippet" }, { t("x_{i}") }, math_cond),
            s({ trig = "yii", snippetType = "autosnippet" }, { t("y_{i}") }, math_cond),
            s({ trig = "xjj", snippetType = "autosnippet" }, { t("x_{j}") }, math_cond),
            s({ trig = "yjj", snippetType = "autosnippet" }, { t("y_{j}") }, math_cond),
            s({ trig = "xp1", snippetType = "autosnippet" }, { t("x_{n+1}") }, math_cond),
            s({ trig = "xmm", snippetType = "autosnippet" }, { t("x_{m}") }, math_cond),

            -- 字体风格与特殊符号
            s({ trig = "mcal", snippetType = "autosnippet" }, fmta([[\mathcal{<>}<>]], { i(1), i(0) }), math_cond),
            s({ trig = "mrm", snippetType = "autosnippet" }, fmta([[\mathrm{<>}<>]], { i(1), i(0) }), math_cond),
            s({ trig = "lll", snippetType = "autosnippet" }, { t([[\ell]]) }, math_cond),
            s({ trig = "nabl", snippetType = "autosnippet" }, { t([[\nabla ]]) }, math_cond),
            s({ trig = "xx", snippetType = "autosnippet" }, { t([[\times ]]) }, math_cond),
            s({ trig = "**", priority = 100, snippetType = "autosnippet" }, { t([[\cdot ]]) }, math_cond),
            s({ trig = "norm", snippetType = "autosnippet" }, fmta([[\Vert <>\Vert <>]], { i(1), i(0) }), math_cond),

            -- 彻底将带有关键符号的单字片段换用纯 text_node，杜绝 fmta 解析错误
            s({ trig = "->", priority = 100, snippetType = "autosnippet" }, { t([[\to ]]) }, math_cond),
            s({ trig = "<->", priority = 200, snippetType = "autosnippet" }, { t([[\leftrightarrow]]) }, math_cond),
            s({ trig = "<>", snippetType = "autosnippet" }, { t([[\diamond ]]) }, math_cond),

            s({ trig = "!>", snippetType = "autosnippet" }, { t([[\mapsto ]]) }, math_cond),
            s({ trig = "invs", snippetType = "autosnippet" }, { t("^{-1}") }, math_cond),
            s({ trig = "compl", snippetType = "autosnippet" }, { t("^{c}") }, math_cond),
            s({ trig = "\\\\", snippetType = "autosnippet" }, { t([[\setminus]]) }, math_cond),
            s({ trig = ">>", snippetType = "autosnippet" }, { t([[\gg]]) }, math_cond),
            s({ trig = "<<", snippetType = "autosnippet" }, { t([[\ll]]) }, math_cond),
            s({ trig = "~~", snippetType = "autosnippet" }, { t([[\sim ]]) }, math_cond),
            s({ trig = "set", snippetType = "autosnippet" }, fmta([[\{<>\} <>]], { i(1), i(0) }), math_cond),
            s({ trig = "||", snippetType = "autosnippet" }, { t([[\mid ]]) }, math_cond),
            s({ trig = "cc", snippetType = "autosnippet" }, { t([[\subseteq ]]) }, math_cond),
            s({ trig = "notin", snippetType = "autosnippet" }, { t([[\not\in ]]) }, math_cond),
            s({ trig = "inn", snippetType = "autosnippet" }, { t([[\in ]]) }, math_cond),
            s({ trig = "\\N", snippetType = "autosnippet" }, { t([[\mathbb{N}]]) }, math_cond),
            s({ trig = "NN", snippetType = "autosnippet" }, { t([[\cap ]]) }, math_cond),
            s({ trig = "UU", snippetType = "autosnippet" }, { t([[\cup ]]) }, math_cond),
            s({ trig = "uuu", snippetType = "autosnippet" }, fmta([[\bigcup_{<>} <>]], { i(1, [[i \in I]]), i(0) }), math_cond),
            s({ trig = "nnn", snippetType = "autosnippet" }, fmta([[\bigcap_{<>} <>]], { i(1, [[i \in I]]), i(0) }), math_cond),
            s({ trig = "OO", snippetType = "autosnippet" }, { t([[\emptyset]]) }, math_cond),
            s({ trig = "RR", snippetType = "autosnippet" }, { t([[\mathbb{R}]]) }, math_cond),
            s({ trig = "QQ", snippetType = "autosnippet" }, { t([[\mathbb{Q}]]) }, math_cond),
            s({ trig = "ZZ", snippetType = "autosnippet" }, { t([[\mathbb{Z}]]) }, math_cond),
            s({ trig = "<!", snippetType = "autosnippet" }, { t([[\triangleleft ]]) }, math_cond),

            -- 文本与条件分支
            s({ trig = "tt", snippetType = "autosnippet" }, fmta([[\text{<>}<>]], { i(1), i(0) }), math_cond),
            s({ trig = "case", snippetType = "autosnippet" }, 
                fmta([[
\begin{cases}
	<>
\end{cases}
                ]], { i(1) }), 
                math_cond
            ),

            -- 帽徽与修饰
            s({ trig = "bar", priority = 10, snippetType = "autosnippet" }, fmta([[\overline{<>}<>]], { i(1), i(0) }), math_cond),
            s({ trig = "hat", priority = 10, snippetType = "autosnippet" }, fmta([[\hat{<>}<>]], { i(1), i(0) }), math_cond),
            s({ trig = "letw", snippetType = "autosnippet" }, { t([[Let $\Omega \subset \C$ be open.]]) }, math_cond),
            s({ trig = "HH", snippetType = "autosnippet" }, { t([[\mathbb{H}]]) }, math_cond),
            s({ trig = "DD", snippetType = "autosnippet" }, { t([[\mathbb{D}]]) }, math_cond),
            s({ trig = "top", snippetType = "autosnippet" }, fmta([[\left( <> , \mathcal{O}_{<>} \right)]], { i(1), i(1) }), math_cond),

            -------------------------------------------------------------------
            -- 希腊字母快捷键 (Greek Letters)
            -------------------------------------------------------------------
            s({ trig = "@a", snippetType = "autosnippet" }, { t([[\alpha]]) }, math_cond),
            s({ trig = "@b", snippetType = "autosnippet" }, { t([[\beta]]) }, math_cond),
            s({ trig = "@l", snippetType = "autosnippet" }, { t([[\lambda]]) }, math_cond),
            s({ trig = "@L", snippetType = "autosnippet" }, { t([[\Lambda]]) }, math_cond),
            s({ trig = "@f", snippetType = "autosnippet" }, { t([[\varphi]]) }, math_cond),
            s({ trig = "@e", snippetType = "autosnippet" }, { t([[\varepsilon]]) }, math_cond),
            s({ trig = "@p", snippetType = "autosnippet" }, { t([[\varpsi]]) }, math_cond),
            s({ trig = "@z", snippetType = "autosnippet" }, { t([[\zeta]]) }, math_cond),
            s({ trig = "@g", snippetType = "autosnippet" }, { t([[\gamma]]) }, math_cond),
            s({ trig = "@i", snippetType = "autosnippet" }, { t([[\iota]]) }, math_cond),
            s({ trig = "@t", snippetType = "autosnippet" }, { t([[\tau]]) }, math_cond),
            s({ trig = "mu", snippetType = "autosnippet" }, { t([[\mu]]) }, math_cond),
            s({ trig = "nu", snippetType = "autosnippet" }, { t([[\nu]]) }, math_cond),
        })
    end
}
