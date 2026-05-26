-- 自动安装 Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 使用 Lazy.nvim 安装你目录中的插件
require("lazy").setup({
  -- 【UI 界面】
  "glepnir/dashboard-nvim",                -- dashboard.lua
  "nvim-lualine/lualine.nvim",              -- lualine.lua
  "akinsho/bufferline.nvim",               -- bufferline.lua
  "nvim-tree/nvim-tree.lua",               -- nvim-tree.lua
  "lukas-reineke/indent-blankline.nvim",   -- indent-blankline.lua
  "nvim-tree/nvim-web-devicons",           -- 图标支持

  -- 【功能组件】
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- nvim-treesitter.lua
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } }, -- telescope.lua
  "ahmedkhalf/project.nvim",               -- project.lua

  -- 【LSP 相关】
  "neovim/nvim-lspconfig",                 -- lsp.lua & lsp/setup.lua
  "williamboman/mason.nvim",               -- 自动管理 LSP 服务端
  "williamboman/mason-lspconfig.nvim",

  -- 【补全系统 (nvim-cmp)】
  "hrsh7th/nvim-cmp",                      -- config/nvim-cmp.lua
  "hrsh7th/cmp-nvim-lsp",                  -- lsp/cmp.lua
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "onsails/lspkind.nvim",                  -- lsp/ui.lua (通常用于补全图标)
  "L3MON4D3/LuaSnip",             -- 代码片段引擎
  "saadparwaiz1/cmp_luasnip",     -- 桥接 luasnip 和 nvim-cmp

  -- 【LaTeX 支持】
  "lervag/vimtex",                         -- vimtex.lua
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    -- 确保依赖项也已安装
    dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    -- 告诉 Lazy.nvim 去加载外部配置
    config = function()
      require("plugin-config.luasnip-latex-snippets")
    end,
  },
  -- 【配色方案】
  -- 确保这里的插件名与你 colorscheme.lua 里的设置一致
  "folke/tokyonight.nvim", 
})
