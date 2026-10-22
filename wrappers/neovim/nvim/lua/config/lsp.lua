-- configure diagnostic
-- no underline and show float window on jump, and only jump warn and above
vim.diagnostic.config({
  jump = { on_jump = vim.diagnostic.open_float },
  severity_sort = true,
  update_in_insert = true,
})

-- enable lsp
for _, lsp in ipairs(vim.g.enabled_lsps) do
  vim.lsp.enable(lsp)
end

-- add bindings for all client

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { desc = desc, buffer = ev.buf, silent = true })
    end
    map("grci", vim.lsp.buf.incoming_calls, "Incoming calls")
    map("grco", vim.lsp.buf.outgoing_calls, "Incoming calls")
    map("grf", vim.lsp.buf.format, "Formate with lsp")
    map("grS", vim.lsp.buf.workspace_symbol, "List workspace symbols")
    map("grs", vim.lsp.buf.document_symbol, "List all symbols")
    map("grd", vim.lsp.buf.definition, "Goto definition")
    map("grD", vim.lsp.buf.declaration, "Goto declaration")
    map("gre", vim.lsp.buf.workspace_diagnostics, "Workspace diagnostics")
    map("grk", ":lsp restart<cr>", "Restart LSP")
    map("grl", function()
      vim.cmd("tabnew " .. vim.lsp.log.get_filename())
    end, "LSP log")

    vim.api.nvim_buf_create_user_command(0, "LspLog", function()
      vim.cmd("tabnew " .. vim.lsp.log.get_filename())
    end, {})
    vim.api.nvim_buf_create_user_command(0, "LspRestart", function()
      vim.cmd("lsp restart")
    end, {})
    vim.api.nvim_buf_create_user_command(0, "LspInfo", ":checkhealth vim.lsp", {})
  end,
})
