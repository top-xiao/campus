local status, mason = pcall(require, "mason")
if not status then
  vim.notify("mason is not found!")
  return
end
