return {
  "neo-tree",
  auto_enable = true,
  keys = {
    { "<leader>fe", desc = "Explorer" },
  },
  cmd = { "Neotree" },
  after = function()
    vim.keymap.set("n", "<leader>fe", ":Neotree toggle reveal_force_cwd<cr>", { desc = "Explorer" })
    vim.keymap.set("n", "<leader>fo", ":Neotree<cr>", { desc = "Focus explorer" })
    require("neo-tree").setup({
      -- close_if_last_window = true,
      source_selector = { winbar = true, statusline = false },
      window = {
        position = "right",
        width = 30,
        mappings = {
          ["C"] = "none",
          ["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
          ["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
          ["S"] = "none",
          ["s"] = "none",
          ["t"] = "none",
          ["<c-s>"] = "open_split",
          ["<c-v>"] = "open_vsplit",
          ["<c-t>"] = "open_tabnew",
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = {
          always_show = { ".gitignore" },
        },
        window = {
          mappings = {
            ["H"] = "none",
            ["<A-h>"] = "toggle_hidden",
          },
        },
      },
    })
  end,
}
