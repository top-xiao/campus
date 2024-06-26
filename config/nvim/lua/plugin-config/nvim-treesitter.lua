local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  vim.notify("nvim-treesitter is not found!")
  return
end

treesitter.setup({
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  ensure_installed = { "vim", "lua", "cpp", "latex"},
  -- 启用代码高亮模块
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
    indent = {
      enable = true,
  },
})

-- 开启 Folding 模块
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.opt.foldlevel = 1
