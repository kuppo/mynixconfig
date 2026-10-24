local bufnr = vim.api.nvim_get_current_buf()

vim.api.nvim_create_autocmd("LspAttach", {
  buffer = bufnr,
  once = true,
  callback = function()
    vim.keymap.set("n", "<leader>ca", function()
      vim.cmd.RustLsp("codeAction")
    end, {
      desc = "Rust code action",
      silent = true,
      buffer = bufnr,
    })
    vim.keymap.set("n", "K", function()
      vim.cmd.RustLsp({ "hover", "actions" })
    end, { silent = true, buffer = bufnr })

    vim.keymap.set(
      "n",
      "<leader>dd",
      "<cmd>RustLsp debuggables<cr>",
      { silent = true, buffer = bufnr, desc = "Rust debuggables" }
    )
  end,
})
