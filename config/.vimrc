call plug#begin()
" The default plugin directory will be as follows:
" " - Vim (Linux/macOS): '~/.vim/plugged'
" " - Vim (Windows): '~/vimfiles/plugged'
" " - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" " You can specify a custom plugin directory by passing it as the argument
" " - e.g. call plug#begin('~/.vim/plugged')
" " - Avoid using standard Vim directory names like 'plugin'
"
" " Make sure you use single quotes
"

 Plug 'lervag/vimtex'
 let g:tex_flavor='latex'
 let g:vimtex_view_method='zathura'
 let g:vimtex_quickfix_mode=0
 let g:latex_latexmk_enabled = 1
 let g:livepreview_engine = 'pdflatex'
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

 Plug 'honza/vim-snippets'
 Plug 'sirver/ultisnips'
 let g:UltiSnipsExpandTrigger = '<tab>'
 let g:UltiSnipsJumpForwardTrigger = '<tab>'
 let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
 Plug 'KeitaNakamura/tex-conceal.vim'
 set conceallevel=1
 let g:tex_conceal='abdmg'
 hi Conceal ctermbg=none
 let g:vimtex_fold_enabled =1

 call plug#end()
