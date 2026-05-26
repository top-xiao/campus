local opt = vim.opt

opt.number = true          -- 显示绝对行号（当前行）
opt.relativenumber = true  -- 显示相对行号（其他行，方便多行跳转）
opt.shiftwidth = 2         -- 缩进两空格
opt.tabstop = 2
opt.expandtab = true       -- 将 tab 转换为空格
opt.spell = false           -- 开启拼写检查
opt.spelllang = { "en_us" }

-- 设置快捷键前缀
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
