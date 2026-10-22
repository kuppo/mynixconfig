return {
  "blink.cmp",
  auto_enable = true,
  -- event = { "InsertEnter", "CmdlineEnter" },
  event = "DeferredUIEnter",
  dep_of = "orgmode",
  after = function()
    local blink = require("blink.cmp")
    blink.setup({
      sources = {
        default = { "snippets", "lsp", "buffer", "path" },
        per_filetype = {
          org = { "orgmode" },
        },
        providers = {
          orgmode = {
            name = "Orgmode",
            module = "orgmode.org.autocompletion.blink",
            fallbacks = { "buffer" },
          },
        },
      },
      keymap = {
        preset = "super-tab",
        ["<Up>"] = {
          "select_prev",
          "fallback",
        },
        ["<Down>"] = {
          "select_next",
          "fallback",
        },
        ["<c-d>"] = {
          "scroll_documentation_down",
          "fallback",
        },
        ["<c-u>"] = {
          "scroll_documentation_up",
          "fallback",
        },
        ["<C-k>"] = {
          -- "show",
          "select_prev",
          "fallback_to_mappings",
        },
        ["<C-j>"] = {
          -- "show",
          "select_next",
          "fallback_to_mappings",
        },
        ["<C-p>"] = false,
        ["<C-n>"] = false,
        ["<C-b>"] = false,
        ["<C-f>"] = false,
      },
      snippets = { preset = nixInfo.installed("luasnip") and "luasnip" or "default" },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = { "exact", "score", "sort_text" },
      },
      completion = {
        documentation = { auto_show = true },
        keyword = { range = "full" },
        ghost_text = { enabled = true },
        -- list = { selection = { preselect = false } },
      },
      signature = { enabled = true },
      cmdline = {
        keymap = {
          preset = "inherit",
        },
        -- sources = { "omni", "cmdline" },
        completion = {
          -- list = { selection = { preselect = false } },
          menu = { auto_show = true },
        },
      },
    })
  end,
}
