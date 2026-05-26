-- 加载基础设置
require("config.options")

-- 自动下载并初始化 lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 核心：让 lazy 自动扫描 lua/plugins 文件夹下的所有 lua 文件
require("lazy").setup("plugins")
