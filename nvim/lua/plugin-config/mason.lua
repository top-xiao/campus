local status, mason = pcall(require, "mason")
if not status then
  vim.notify("mason is not found!")
  return
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
