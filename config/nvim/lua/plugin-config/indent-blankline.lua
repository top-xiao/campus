local ok, ibl = pcall(require, "ibl")
if not ok then
  vim.notify("没有找到 indent-blankline (ibl)")
  return
  end

  ibl.setup({
    indent = {
      char = "▏",
    },

    scope = {
      enabled = true,
      show_start = true,
      show_end = false,
      injected_languages = true,

      highlight = { "Function", "Label" },

      include = {
        node_type = {
          ["*"] = {
            "class",
            "function",
            "method",
            "element",
            "if_statement",
            "while_statement",
            "for_statement",
            "object",
            "table",
            "block",
            "arguments",
          },
        },
      },
    },

    whitespace = {
      remove_blankline_trail = false,
    },

    exclude = {
      filetypes = {
        "dashboard",
        "packer",
        "terminal",
        "help",
        "log",
        "markdown",
        "TelescopePrompt",
        "lsp-installer",
        "lspinfo",
        "toggleterm",
      },
    },
  })
