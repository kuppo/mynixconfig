vim.opt_local.formatoptions:remove({ "t", "c" })

vim.keymap.set(
  "n",
  "<localleader>tm",
  ":lua require('dap-python').test_method()<CR>",
  { buffer = true, desc = "Test method" }
)
vim.keymap.set(
  "n",
  "<localleader>tc",
  ":lua require('dap-python').test_class()<CR>",
  { buffer = true, desc = "Test class" }
)
vim.keymap.set(
  "v",
  "<localleader>tt",
  "<ESC>:lua require('dap-python').debug_selection()<CR>",
  { buffer = true, desc = "Test selected" }
)
