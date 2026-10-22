vim.keymap.set(
  "n",
  "<localleader>tp",
  ":LspTinymiststartDefaultPreview<cr>",
  { silent = true, desc = "Start typst preview", buffer = true }
)
