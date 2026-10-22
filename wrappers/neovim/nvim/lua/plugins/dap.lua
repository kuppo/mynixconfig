return {
  {
    "nvim-dap",
    auto_enable = true,
    cmd = {
      "DapContinue",
      "DapDisconnect",
      "DapNew",
      "DapTerminate",
      "DapRestartFrame",
      "DapStepInto",
      "DapStepOut",
      "DapStepOver",
      "DapPause",
      "DapEval",
      "DapToggleRepl",
      "DapClearBreakpoints",
      "DapToggleBreakpoint",
      "DapSetLogLevel",
      "DapShowLog",
    },
    keys = {
      {
        "<leader>dd",
        ":DapContinue<cr>",
        desc = "Dap Continue",
        silent = true,
      },
      {
        "<Leader>dn",
        ":DapNew<cr>",
        desc = "New session",
        silent = true,
      },
      {
        "<Leader>db",
        ":DapToggleBreakpoint<cr>",
        desc = "Toggle breakpoint",
        silent = true,
      },
      {
        "<Leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Condition: "))
        end,
        desc = "Conditional breakpoint",
      },
      {
        "<Leader>dp",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end,
        desc = "breakpoint with message: ",
      },
    },

    after = function()
      -- keymaps
      vim.keymap.set(
        "n",
        "<F5>",
        ":DapContinue<cr>",
        { desc = "Start/Continue", silent = true, buffer = true }
      )
      vim.keymap.set(
        "n",
        "<F6>",
        ":DapRestartFrame<cr>",
        { desc = "Restart", silent = true, buffer = true }
      )
      vim.keymap.set(
        "n",
        "<F7>",
        ":DapTerminate<cr>",
        { desc = "Terminate", silent = true, buffer = true }
      )
      vim.keymap.set(
        "n",
        "<F9>",
        ":DapStepBack<cr>",
        { desc = "Step back", silent = true, buffer = true }
      )
      vim.keymap.set(
        "n",
        "<F10>",
        ":DapStepOver<cr>",
        { desc = "Step over", silent = true, buffer = true }
      )
      vim.keymap.set(
        "n",
        "<F11>",
        ":DapStepInto<cr>",
        { desc = "Step into", silent = true, buffer = true }
      )
      vim.keymap.set(
        "n",
        "<F12>",
        ":DapStepOut<cr>",
        { desc = "Step out", silent = true, buffer = true }
      )
      vim.keymap.set(
        "n",
        "<leader>de",
        ":DapEval<cr>",
        { desc = "Eval", silent = true, buffer = true }
      )
      vim.keymap.set(
        "n",
        "<Leader>dr",
        ":DapToggleRepl<cr>",
        { desc = "Toggle REPL", silent = true }
      )
      vim.keymap.set("n", "<Leader>dl", function()
        require("dap").run_last()
      end, { desc = "Run last" })
      vim.keymap.set("n", "<Leader>dq", ":DapTerminate<cr>", {
        desc = "Dap terminate",
        silent = true,
        buffer = true,
      })
      vim.keymap.set("n", "<Leader>dC", ":DapClearBreakpoints<cr>", {
        desc = "Clear all breakpoints",
        silent = true,
        buffer = true,
      })
      vim.keymap.set("n", "<Leader>dh", function()
        require("dap.ui.widgets").hover()
      end, { desc = "Hover", buffer = true })
      vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
        require("dap.ui.widgets").preview()
      end, {
        desc = "Preview widget",
        buffer = true,
      })
      vim.keymap.set("n", "<Leader>df", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
      end, {
        desc = "Center frame",
        buffer = true,
      })
      vim.keymap.set("n", "<Leader>ds", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end, {
        desc = "Center widget",
        buffer = true,
      })

      local dap = require("dap")
      local vscode_lldb_path = nixInfo(nil, "info", "vscode-lldb-path")

      -- lldb-dap
      dap.adapters = {
        lldb = {
          type = "executable",
          command = vim.fn.exepath("lldb-dap"),
        },
        codelldb = {
          type = "executable",
          command = vscode_lldb_path
            .. "/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb",
          detached = (vim.fn.has("win32") or vim.fn.has("win64")) == 0,
        },
      }

      dap.configurations.cpp = {
        {
          name = "Choose executable ...",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
        {
          name = "Launch executable",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.getcwd() .. "/build/debug/bin/debug-executable"
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
        {
          name = "Launch tests ...",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to test: ", vim.fn.getcwd() .. "/build/tests/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
      dap.configurations.c = dap.configurations.cpp
    end,
  },
  {
    "dap-virtual-text",
    -- auto_enable = false,
    enabled = false,
    on_plugin = "nvim-dap",
    -- lazy = true,
    after = function()
      require("nvim-dap-virtual-text").setup({})
    end,
  },
  {
    "nvim-dap-ui",
    auto_enable = true,
    on_plugin = "nvim-dap",
    after = function() end,
  },
  {
    "dap-view",
    -- auto_enable = true,
    enabled = false,
    on_plugin = "nvim-dap",
    after = function() end,
  },
  {
    "nvim-dap-disasm",
    auto_enable = true,
    -- ft = { "c", "cpp", "rust", "zig" },
    -- lazy = true,
    on_plugin = { "dap-view", "nvim-dap-ui" },
    before = function()
      local dap_ok, dap = pcall(require, "dap")
      local dapui_ok, dapui = pcall(require, "dapui")
      local dapview_ok, dapview = pcall(require, "dap-view")

      -- dap
      if dap_ok then
        dap.listeners.before.attach.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
          dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
          dapui.close()
        end
      end

      -- dap-ui
      if dapui_ok then
        vim.keymap.set("n", "<leader>dv", function()
          dapui.toggle()
        end, {
          buffer = true,
          desc = "Dap UI Toggle",
        })
        vim.keymap.set("n", "<leader>dw", function()
          dapui.elements.watches.add()
        end, {
          buffer = true,
          desc = "Add expression to Watch",
        })
        vim.keymap.set("n", "<leader>dK", function()
          dapui.eval()
        end, {
          buffer = true,
          desc = "Hover eval",
        })
        dapui.setup({
          element_mappings = {
            scopes = {
              watch = "w",
            },
          },
          controls = {
            icons = {
              disconnect = "",
              pause = "",
              play = " F5",
              run_last = " F6",
              step_back = " F9",
              step_into = " F11",
              step_out = " F12",
              step_over = " F10",
              terminate = " F7",
            },
          },
          layouts = {
            {
              elements = {
                {
                  id = "scopes",
                  size = 0.25,
                },
                {
                  id = "breakpoints",
                  size = 0.25,
                },
                {
                  id = "stacks",
                  size = 0.25,
                },
                {
                  id = "watches",
                  size = 0.25,
                },
              },
              position = "right",
              size = 40,
            },
            {
              elements = {
                {
                  id = "repl",
                  size = 0.3,
                },
                {
                  id = "console",
                  size = 0.2,
                },
                {
                  id = "disassembly",
                  size = 0.5,
                },
              },
              position = "bottom",
              size = 10,
            },
          },
        })
      end

      -- dap-view
      if dapview_ok then
        vim.keymap.set("n", "<leader>dv", ":DapViewToggle<cr>", {
          buffer = true,
          desc = "Dap View Toggle",
        })
        vim.keymap.set("n", "<leader>dw", function()
          require("dap-view").add_expr()
        end, {
          buffer = true,
          desc = "Add expression to Watch",
        })
        vim.keymap.set("n", "<leader>dt", ":DapViewVirtualTextToggle<cr>", {
          buffer = true,
          desc = "Dap Virtual text toggle",
        })
        vim.keymap.set("n", "<leader>dK", ":DapViewHover<cr>", {
          buffer = true,
          desc = "Dap View Hover",
        })
        dapview.setup({
          winbar = {
            sections = {
              "watches",
              "scopes",
              "exceptions",
              "breakpoints",
              "threads",
              "repl",
              "sessions",
              "console",
              "disassembly",
            },
            controls = {
              enabled = true,
            },
          },
          virtual_text = {
            enabled = true,
          },
          auto_toggle = true,
          icons = {
            step_into = " F11",
            step_out = " F12",
            step_over = " F10",
            collapsed = "󰅂 ",
            disabled = "",
            disconnect = "",
            enabled = "",
            expanded = "󰅀 ",
            filter = "󰈲",
            negate = " ",
            pause = "",
            play = " F5",
            run_last = " F6",
            step_back = " F9",
            terminate = " F7",
          },
        })
      end
    end,
    after = function()
      require("dap-disasm").setup({
        dapview_register = true,
        dapui_register = true,
      })
    end,
  },
  {
    "nvim-dap-python",
    auto_enable = true,
    on_plugin = "nvim-dap",
    ft = "python",
    after = function()
      local dpy = require("dap-python")
      dpy.setup("uv")
      dpy.test_runner = "pytest"
    end,
  },
}
