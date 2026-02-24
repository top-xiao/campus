-- 基本设置
vim.g.tex_flavor = 'latex'
vim.g.tex_comment_nospell = 1
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_compiler_progname = 'nvr'

-- 编译器设置
vim.cmd([[
let g:vimtex_compiler_latexmk = {
\ 'background': 1,
\ 'build_dir': '',
\ 'continuous': 1,
\ 'options': [
\   '-lualatex',
\   '-verbose',
\   '-file-line-error',
\   '-synctex=1',
\   '-interaction=nonstopmode',
\ ],
\}
]])

-- PDF viewer: Zathura
--vim.g.vimtex_view_method = 'zathura'
--vim.g.vimtex_view_general_viewer = 'zathura'
--vim.g.vimtex_view_general_options = '--synctex-forward @line:@col:@tex @pdf'
-- 如果你还想用 qpdfview，可改成：
-- vim.g.vimtex_view_method = 'general'
-- vim.g.vimtex_view_general_viewer = 'qpdfview'
-- vim.g.vimtex_view_general_options = '--unique @pdf#src:@tex:@line:@col'
vim.g.vimtex_view_method = "zathura"



