return {
  "ultimate-autopair.nvim",
  event = "InsertEnter",
  auto_enable = true,
  after = function()
    local ua = require("ultimate-autopair")
    local config = {
      fastwarp = { nocursormove = false },
      pair_cmap = false,
      ua.extend_default({
        {
          "$",
          "$",
          suround = true,
          dosuround = true,
          newline = true,
          space = true,
          cmap = false,
          ft = { "typst", "tex", "latex" },
        },
        space2 = { enable = true },
        tabout = { enable = true },
        close = { enable = true },
      }),
    }
    ua.init(config)
  end,
}
