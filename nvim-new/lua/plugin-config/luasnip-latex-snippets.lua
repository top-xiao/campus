-- ~/.config/nvim/lua/plugin-config/luasnip-latex-snippets.lua

local status_latex, latex_snippets = pcall(require, "luasnip-latex-snippets")
local status_luasnip, luasnip = pcall(require, "luasnip")

if not (status_latex and status_luasnip) then
  return
end

-- 配置 latex-snippets
latex_snippets.setup({
  use_treesitter = true,
  -- 你可以在这里添加更多插件支持的自定义选项
})

-- 配置 LuaSnip 核心
luasnip.config.setup({
  -- 必须开启自动补全片段，否则数学公式的自动触发（如 mk 触发 $...$）不会生效
  enable_autosnippets = true,
})

-- 可选：如果你想手动加载一些自定义的 Snippets 文件
-- require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets/" })
