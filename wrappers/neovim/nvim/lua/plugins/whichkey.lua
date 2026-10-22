return {
  "which-key.nvim",
  auto_enable = true,
  event = "DeferredUIEnter",
  dep_of = "orgmode",
  after = function()
    local wk = require("which-key")
    wk.setup({
      preset = "helix",
      delay = 0,
    })
    wk.add({
      {
        "<leader>b",
        group = "[B]uffer",
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      },
      { "<leader>F", group = "[F]ormat" },
      { "<leader>c", group = "[C]ode" },
      { "<leader>d", group = "[D]ebug" },
      { "<leader>f", group = "[F]ile/[F]ind" },
      { "<leader>g", group = "[G]it" },
      { "<leader>o", group = "[O]rg" },
      { "<leader>on", proxy = "<leader>n", group = "Org note" },
      { "<leader>ond", group = "Daily" },
      { "<leader>p", group = "[P]roject" },
      { "<leader>q", group = "[Q]uit" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>t", group = "[T]oggle/[T]erm" },
      { "<leader>u", group = "[U]I" },
      { "<leader>w", proxy = "<c-w>", group = "[W]indows" },
      { "grc", group = "code in/out" },
    })
  end,
}
