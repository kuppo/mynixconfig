return {
  "luasnip",
  auto_enable = true,
  event = { "DeferredUIEnter" },
  after = function()
    local ls = require("luasnip")
    ls.setup({
      link_children = true,
      link_roots = true,
      keep_roots = true,
      update_events = { "TextChanged", "TextChangedI" },
      enable_autosnippets = true,

      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.choice_active() then ls.change_choice(1) end
      end, { silent = true }),
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.choice_active() then ls.change_choice(1) end
      end, { silent = true }),
    })
    require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets" })
  end,
}
