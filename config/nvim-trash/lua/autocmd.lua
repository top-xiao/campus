--python
vim.g.python3_host_prog = "/usr/bin/python3"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.g.tex_conceal = "abdmg"
    vim.cmd("hi Conceal ctermbg=none")
  end,
})

