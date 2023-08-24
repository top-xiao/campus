--Foundation
require("basic")

--key mapping
require("keybindings")

--autocmd
require("autocmd")

--Packer Plugin
require("plugins")

--Colour Scheme
require("colorscheme")

--Plugin Setting
require("plugin-config.nvim-tree")

--Vimtex
require("plugin-config.vimtex")

--tex-conceal
require("plugin-config.tex-conceal")

--bufferline
require("plugin-config.bufferline")

--lualine
require("plugin-config.lualine")

--telescope
require("plugin-config.telescope")

--dashboard
require("plugin-config.dashboard")

--indent
require("plugin-config.indent-blankline")

--project
require("plugin-config.project")

--treesitter
require("plugin-config.nvim-treesitter")

require("plugin-config.ultisnips")
--lsp
require("lsp.setup")
require("lsp.cmp")
require("lsp.ui")
