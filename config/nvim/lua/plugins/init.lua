return {
  --tokyonight
	"folke/tokyonight.nvim",
  --vimtex
	"lervag/vimtex",
  --telescope
	{"nvim-telescope/telescope.nvim",
		dependencies = {"nvim-lua/plenary.nvim"}
	},
  "LinArcX/telescope-env.nvim",
  --treesitter
  	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  --bufferline
  	{ "akinsho/bufferline.nvim", 
		dependencies = {"kyazdani42/nvim-web-devicons", "moll/vim-bbye"}
 	 },
  --lspconfig
  	"neovim/nvim-lspconfig",
  --ultisnips
 	 "SirVer/ultisnips",
    "honza/vim-snippets",
  --tex-conceal
 	 "KeitaNakamura/tex-conceal.vim",
  --

}

