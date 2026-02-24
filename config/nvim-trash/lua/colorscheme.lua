local colorscheme = "tokyonight"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)  --Define a variable "colorscheme"
--error hunting
if not status_ok then
  vim.notify("colorscheme" .. colorscheme .. "is not found!")
  return
end
