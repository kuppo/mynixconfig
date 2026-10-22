return {
  "fzf-lua",
  auto_enable = true,
  event = "DeferredUIEnter",
  dep_of = "project",
  after = function(_)
    require("fzf-lua").setup({
      files = {
        path_shorten = true,
        absolute_path = true,
      },
    })
    local map = vim.keymap.set
    map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
    map("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Find recent files" })
    map("n", "<leader>bb", "<cmd>FzfLua buffers<cr>", { desc = "Buffers" })
    map("n", "<leader>ss", "<cmd>FzfLua live_grep<cr>", { desc = "Search text" })
    map("n", "<leader>sk", "<cmd>FzfLua keymaps<cr>", { desc = "Search keymap" })
    map("n", "<leader>sh", "<cmd>FzfLua helptags<cr>", { desc = "Search help" })
    map("n", "<leader>sm", "<cmd>FzfLua manpages<cr>", { desc = "Search man" })
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function()
        map(
          "n",
          "<leader>cr",
          "<cmd>FzfLua lsp_references<cr>",
          { desc = "References", buffer = true }
        )
        map("n", "<leader>cn", function()
          vim.lsp.buf.rename()
        end, { desc = "Rename", buffer = true })
        map(
          "n",
          "<leader>cd",
          "<cmd>FzfLua lsp_definitions<cr>",
          { desc = "Definitions", buffer = true }
        )
        map(
          "n",
          "<leader>cD",
          "<cmd>FzfLua lsp_declarations<cr>",
          { desc = "Declarations", buffer = true }
        )
        map(
          "n",
          "<leader>ctt",
          "<cmd>FzfLua lsp_typedefs<cr>",
          { desc = "Type Definitions", buffer = true }
        )
        map(
          "n",
          "<leader>ctu",
          "<cmd>FzfLua lsp_type_super<cr>",
          { desc = "Super type", buffer = true }
        )
        map(
          "n",
          "<leader>ctd",
          "<cmd>FzfLua lsp_type_sub<cr>",
          { desc = "Sub type", buffer = true }
        )
        map(
          "n",
          "<leader>ci",
          "<cmd>FzfLua lsp_implementations<cr>",
          { desc = "Implementations", buffer = true }
        )
        map(
          "n",
          "<leader>cs",
          "<cmd>FzfLua lsp_document_symbols<cr>",
          { desc = "Document symbols", buffer = true }
        )
        map(
          "n",
          "<leader>cS",
          "<cmd>FzfLua lsp_workspace_symbols<cr>",
          { desc = "Document symbols", buffer = true }
        )
        map(
          "n",
          "<leader>cci",
          "<cmd>FzfLua lsp_incoming_calls<cr>",
          { desc = "Incoming calls", buffer = true }
        )
        map(
          "n",
          "<leader>cco",
          "<cmd>FzfLua lsp_outcoming_calls<cr>",
          { desc = "Outcoming calls", buffer = true }
        )
        map(
          "n",
          "<leader>ca",
          "<cmd>FzfLua lsp_code_actions<cr>",
          { desc = "Code actions", buffer = true }
        )
        map(
          "n",
          "<leader>cf",
          "<cmd>FzfLua lsp_finder<cr>",
          { desc = "Find LSP locations", buffer = true }
        )
        map(
          "n",
          "<leader>cf",
          "<cmd>FzfLua lsp_finder<cr>",
          { desc = "Find LSP locations", buffer = true }
        )
        map(
          "n",
          "<leader>ce",
          "<cmd>FzfLua diagnostics_document<cr>",
          { desc = "Document Diagnostics", buffer = true }
        )
        map(
          "n",
          "<leader>cE",
          "<cmd>FzfLua diagnostics_workspace<cr>",
          { desc = "Workspace Diagnostics", buffer = true }
        )
      end,
    })
  end,
}
