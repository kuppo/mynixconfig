{ ... }:
{
  flake.nixosModules.nixvimPluginDap =
    {
      pkgs,
      lib,
      nixosConfig,
      ...
    }:
    let
      myDev = nixosConfig.myoptions.dev;
    in
    lib.mkIf (myDev.enable && myDev.dap) {
      plugins = {
        dap = {
          enable = true;
          adapters = {
            executables = {
              codelldb = lib.mkIf (myDev.languages.c || myDev.languages.rust || myDev.languages.zig) {
                command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
              };
            };
          };
          configurations = rec {
            c = cpp;
            cpp = [
              {
                name = "Choose executable ...";
                type = "codelldb";
                request = "launch";
                program = {
                  __raw = ''
                    function()
                      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end
                  '';
                };
                cwd = "\${workspaceFolder}";
                stopOnEntry = false;
              }
              {
                name = "Launch executable";
                type = "codelldb";
                request = "launch";
                program = {
                  __raw = ''
                    function()
                      return vim.fn.getcwd() .. "/build/debug/bin/debug-executable"
                    end
                  '';
                };
                cwd = "\${workspaceFolder}";
                stopOnEntry = false;
              }
              {
                name = "Launch tests ...";
                type = "codelldb";
                request = "launch";
                program = {
                  __raw = ''
                    function()
                      return vim.fn.input("Path to test: ", vim.fn.getcwd() .. "/build/tests/", "file")
                    end
                  '';
                };
                cwd = "\${workspaceFolder}";
                stopOnEntry = false;
              }
            ];
          };
          luaConfig.post = ''
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


            -- chain other plugins
            -- TODO: not working, it doesn't load the plugin
            pcall(require, "dapui")
            pcall(require, "dap-disasm")
            pcall(require, "dap-view")
            pcall(require, "dap-python")
          '';
          lazyLoad = {
            enable = true;
            settings = {
              cmd = [
                "DapContinue"
                "DapDisconnect"
                "DapNew"
                "DapTerminate"
                "DapRestartFrame"
                "DapStepInto"
                "DapStepOut"
                "DapStepOver"
                "DapPause"
                "DapEval"
                "DapToggleRepl"
                "DapClearBreakpoints"
                "DapToggleBreakpoint"
                "DapSetLogLevel"
                "DapShowLog"
              ];
              keys = [
                {
                  __unkeyed-1 = "<leader>dd";
                  __unkeyed-2 = ":DapContinue<cr>";
                  desc = "Dap Continue";
                  silent = true;
                }
                {
                  __unkeyed-1 = "<Leader>dn";
                  __unkeyed-2 = ":DapNew<cr>";
                  desc = "New session";
                  silent = true;
                }
                {
                  __unkeyed-1 = "<Leader>db";
                  __unkeyed-2 = ":DapToggleBreakpoint<cr>";
                  desc = "Toggle breakpoint";
                  silent = true;
                }
                {
                  __unkeyed-1 = "<Leader>dB";
                  __unkeyed-2 = {
                    __raw = ''
                      function()
                        require("dap").set_breakpoint(vim.fn.input("Condition: "))
                      end
                    '';
                  };
                  desc = "Conditional breakpoint";
                }
                {
                  __unkeyed-1 = "<Leader>dp";
                  __unkeyed-2 = {
                    __raw = ''
                      function()
                        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
                      end
                    '';
                  };
                  desc = "breakpoint with message: ";
                }
              ];
            };
          };
        };
        dap-virtual-text = {
          enable = true;
          lazyLoad = {
            enable = true;
            settings = {
              lazy = true;
            };
          };
        };
        dap-ui = {
          enable = true;
          luaConfig.post = ''
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
          '';
          settings = {
            # element_mappings = {
            #   scopes = {
            #     watch = "w";
            #   };
            # };
            controls = {
              icons = {
                disconnect = "";
                pause = "";
                play = " F5";
                run_last = " F6";
                step_back = " F9";
                step_into = " F11";
                step_out = " F12";
                step_over = " F10";
                terminate = " F7";
              };
            };
            layouts = [
              {
                elements = [
                  {
                    id = "scopes";
                    size = 0.25;
                  }
                  {
                    id = "breakpoints";
                    size = 0.25;
                  }
                  {
                    id = "stacks";
                    size = 0.25;
                  }
                  {
                    id = "watches";
                    size = 0.25;
                  }
                ];
                position = "right";
                size = 40;
              }
              {
                elements = [
                  {
                    id = "repl";
                    size = 0.3;
                  }
                  {
                    id = "console";
                    size = 0.2;
                  }
                  {
                    id = "disassembly";
                    size = 0.5;
                  }
                ];
                position = "bottom";
                size = 10;
              }
            ];
          };
          lazyLoad = {
            enable = true;
            settings = {
              lazy = true;
            };
          };
        };
        dap-view = {
          enable = false;
          luaConfig.post = ''
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
          '';
          settings = {
            winbar = {
              sections = [
                "watches"
                "scopes"
                "exceptions"
                "breakpoints"
                "threads"
                "repl"
                "sessions"
                "console"
                "disassembly"
              ];
              controls = {
                enabled = true;
              };
            };
            virtual_text = {
              enabled = true;
            };
            auto_toggle = true;
            icons = {
              step_into = " F11";
              step_out = " F12";
              step_over = " F10";
              collapsed = "󰅂 ";
              disabled = "";
              disconnect = "";
              enabled = "";
              expanded = "󰅀 ";
              filter = "󰈲";
              negate = " ";
              pause = "";
              play = " F5";
              run_last = " F6";
              step_back = " F9";
              terminate = " F7";
            };
          };
          lazyLoad = {
            enable = true;
            settings = {
              lazy = true;
            };
          };
        };
        dap-disasm = {
          enable = true;
          settings = {
            dapview_register = true;
            dapui_register = true;
          };
          lazyLoad = {
            enable = true;
            settings = {
              lazy = true;
            };
          };
        };
      };
    };
}
