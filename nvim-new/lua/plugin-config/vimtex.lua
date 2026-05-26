-- ~/.config/nvim/lua/plugin-config/vimtex.lua

-- 基本设置
vim.g.tex_flavor = 'latex'
vim.g.tex_comment_nospell = 1
vim.g.vimtex_quickfix_mode = 0
--vim.g.vimtex_compiler_progname = 'nvr'

-- 编译器设置 (使用 Lua Table 代替 vim.cmd 字符串)
vim.g.vimtex_compiler_latexmk = {
    background = 1,
    build_dir = '',
    continuous = 1,
    options = {
        '-lualatex',
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
    },
}

-- PDF 阅读器设置: Zathura
vim.g.vimtex_view_method = 'zathura'

-- 如果将来想切换到其他阅读器，可以参考以下 Lua 写法：
-- qpdfview 示例:
-- vim.g.vimtex_view_method = 'general'
-- vim.g.vimtex_view_general_viewer = 'qpdfview'
-- vim.g.vimtex_view_general_options = '--unique @pdf#src:@tex:@line:@col'
