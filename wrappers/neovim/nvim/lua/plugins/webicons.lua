return {
  "nvim-web-devicons",
  auto_enable = true,
  event = "DeferredUIEnter",
  after = function()
    require("nvim-web-devicons").setup({})
  end,
}
