-- ~/.config/nvim/lua/autocmd.lua

vim.notify("autocmd.lua LOADED", vim.log.levels.INFO)

local group = vim.api.nvim_create_augroup("LatexServer", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "tex", "plaintex" },
  callback = function()
    -- Neovim 永远支持 serverstart，这个判断其实可省
    local server_name = "latex-nvim"

    local servers = vim.fn.serverlist()
    if not vim.tbl_contains(servers, server_name) then
      vim.notify("Starting LaTeX nvim server", vim.log.levels.INFO)
      vim.fn.serverstart(server_name)
    end
  end,
})

