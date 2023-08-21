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

--bufferline
require("plugin-config.bufferline")

--lualine
require("plugin-config.lualine")

--telescope
require("plugin-config.telescope")

--dashboard
require("plugin-config.dashboard")

--project
require("plugin-config.project")

--treesitter
require("plugin-config.nvim-treesitter")

--indent_blankline
require("plugin-config.indent-blankline")

--ultisnips
require("plugin-config.ultisnips")

--tex-conceal
require("plugin-config.tex-conceal")

require("plugin-config.mason")

require("lsp.setup")
require("lsp.cmp")
