if nixInfo.installed("neorg") then
  vim.keymap.set(
    "n",
    "<leader>tO",
    "<cmd>Neorg toc<cr>",
    { buffer = true, desc = "Toggle TOC of org" }
  )
end
