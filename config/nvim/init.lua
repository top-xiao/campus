local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--require--lists---

--keybindings
require("keybindings")
--lazy-plugins
require("lazy").setup("plugins",opt)
--foundation
require("basic")
--colorscheme
require("colorscheme")
--autocmd
require("autocmd")
--Vimtex
require("plugin-config.vimtex")
--tex-conceal
require("plugin-config.tex-conceal")
--telescope
require("plugin-config.telescope")
--treesitter
require("plugin-config.nvim-treesitter")
--ultisnips
require("plugin-config.ultisnips")

