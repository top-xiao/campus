local packer = require("packer")
packer.startup({
  function(use)
  -- Packer 可以管理自己本身
    use ("wbthomason/packer.nvim")
  -- 你的插件列表...
  
  --vimtex
    use ("lervag/vimtex")

  --tokyonight
    use ("folke/tokyonight.nvim")

  --nvim-tree
    use ({ 
      "nvim-tree/nvim-tree.lua",
      requires = "nvim-tree/nvim-web-devicons"
    })
  --bufferline
    use ({
      "akinsho/bufferline.nvim", 
      requires = {"kyazdani42/nvim-web-devicons", "moll/vim-bbye"}
    })
  --lualine
    use({
      "nvim-lualine/lualine.nvim", 
      requires =  "kyazdani42/nvim-web-devicons"
    })
    use("arkav/lualine-lsp-progress")
  --telescope
    use({
      "nvim-telescope/telescope.nvim",
      requires = {"nvim-lua/plenary.nvim"}
    })
    use("LinArcX/telescope-env.nvim")
  --dashboard
    use({
      "glepnir/dashboard-nvim",
      requires = {"nvim-tree/nvim-web-devicons"}
    })
    use("ahmedkhalf/project.nvim")
  --treesitter
    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
  --completion
    use("hrsh7th/nvim-cmp")
    use("SirVer/ultisnips") --snippet engine
    use({
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline"
    })

    use("honza/vim-snippets")
    use("KeitaNakamura/tex-conceal.vim")
    --indent-blankline
    use("lukas-reineke/indent-blankline.nvim")
  --mason
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")
  --lspkind
    use("onsails/lspkind-nvim")
    use("tami5/lspsaga.nvim")
  end,
  config = {

    git = {
        clone_timeout = 6000,
    },
  },
})





--autoinstall
pcall(
  vim.cmd,
  [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]]
)
