
--LaTeX
vim.cmd([[
" Starting server for LaTeX inverse search.
function! s:myinversetex()
    if !filereadable('/tmp/sv4nvim' . expand("%:p"))
        call mkdir('/tmp/sv4nvim' . expand("%:p:h"),"p")
        call serverstart('/tmp/sv4nvim' . expand("%:p"))
    endif
endfunction
command! Serverorig call s:myinversetex()

augroup latex_new
" texソースのときに自動実行
autocmd!
autocmd BufRead *.tex Serverorig
autocmd BufRead *.ltx Serverorig
autocmd BufWritePost *.tex Serverorig
autocmd BufWritePost *.ltx Serverorig
augroup END
]])


vim.cmd([[

filetype plugin indent on
syntax enable

]])
vim.g.tex_flavor='latex'
vim.g.vimtex_compiler_latexmk_engines = {
    _ = '-lualatex'
}
vim.g.tex_comment_nospell = 1
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_compiler_progname = 'nvr'
--vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
vim.g.tex_conceal = 'abdmg'


vim.cmd([[

let g:vimtex_compiler_latexmk = { 'continuous' : 0,}
" qpdfviewでpdfプレビュー
let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_view_general_options = '--unique @pdf\#src:@tex:@line:@col'
]])

