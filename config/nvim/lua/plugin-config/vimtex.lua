vim.cmd([[
" Starting server for LaTeX inverse search.
"function! s:myinversetex()
"    if !filereadable('/tmp/sv4nvim' . expand("%:p"))
"        call mkdir('/tmp/sv4nvim' . expand("%:p:h"), "p")
"        call serverstart('/tmp/sv4nvim' . expand("%:p"))
"    endif
"endfunction
"command! Serverorig call s:myinversetex()

"augroup latex_new
    " Automatically run for LaTeX source files
"autocmd!
"autocmd BufRead *.tex Serverorig
"autocmd BufRead *.ltx Serverorig
"autocmd BufWritePost *.tex Serverorig
"autocmd BufWritePost *.ltx Serverorig
"augroup END

filetype plugin indent on
syntax enable

let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk_engines = {
    \ '_': '-lualatex',
\}
let g:tex_comment_nospell = 1
let g:vimtex_quickfix_mode = 0
"let g:vimtex_compiler_progname = expand('~/venvs/nvim/bin/nvr')
let g:vimtex_latexmk_build_dir = './build'
let g:vimtex_compiler_progname = 'nvr'
" Use qpdfview for PDF preview
let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_view_general_options = '--unique @pdf\#src:@tex:@line:@col'

" Remap double click for latex
autocmd FileType tex nnoremap <silent> <2-LeftMouse> :VimtexView<CR>
" Set the custom fold expression
autocmd Filetype tex setlocal nofoldenable
]])
