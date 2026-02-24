-------------------------------------------------
-- Leader
-------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-------------------------------------------------
-- 加载基础配置
-------------------------------------------------
require("basic")
require("keybindings")
require("colorscheme")
require("autocmd")

-------------------------------------------------
-- lazy.nvim 自动安装
-------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-------------------------------------------------
-- 启动插件
-------------------------------------------------
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- 自动加载 lua/plugins 下所有文件
  },
  defaults = {
    lazy = false,
  },
  checker = {
    enabled = true,
  },
})

