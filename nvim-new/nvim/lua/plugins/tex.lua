return {
  "lervag/vimtex",
  lazy = false, -- 写论文时需要它始终加载
  init = function()
    -- 1. 设置 PDF 查看器 (根据系统选择 zathura / Skim / SumatraPDF)
    vim.g.vimtex_view_method = "zathura" 

    -- 2. 设置自动编译引擎
    vim.g.vimtex_compiler_method = "latexmk"

    -- 3. 可选：配置编译器参数（例如支持 shell-escape 以便在 LaTeX 中使用 minted 插入代码）
    vim.g.vimtex_compiler_latexmk = {
      options = {
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }
  end
}
