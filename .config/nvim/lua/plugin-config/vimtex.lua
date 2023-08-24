vim.g.tex_flavor='latex'
vim.g.vimtex_compiler_latexmk_engines = {
    _ = '-lualatex'
}
vim.g.tex_comment_nospell = 1
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_compiler_progname = 'nvr'
--vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]


vim.cmd([[
 let g:vimtex_compiler_latexmk = {
 \ 'background': 1,
 \ 'build_dir': '',
 \ 'continuous': 1,
 \ 'options': [
 \ '-pdfdvi',
 \ '-verbose',
 \ '-file-line-error',
 \ '-synctex=1',
 \ '-interaction=nonstopmode',
 \],
 \}
" qpdfviewでpdfプレビュー
let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_view_general_options = '--unique @pdf\#src:@tex:@line:@col'

" preview via zathura
"let g:vimtex_view_method='zathura'
]])

