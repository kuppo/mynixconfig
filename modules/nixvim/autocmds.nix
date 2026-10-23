{ ... }:
{
  flake.nixosModules.nixvimAutocmds =
    {
      ...
    }:
    {
      autoGroups = {
        userConfig = {
          clear = true;
        };
      };
      autoCmd = [
        {
          event = "TextYankPost";
          group = "userConfig";
          callback = {
            __raw = ''
              function()
                vim.hl.on_yank()
              end
            '';
          };
          desc = "Highlight text after yank";
        }
        {
          event = "VimResized";
          group = "userConfig";
          callback = {
            __raw = ''
              function()
                 vim.cmd("tabdo wincmd =")
              end
            '';
          };
          desc = "Auto-resize splits when window is resized";
        }
        {
          event = "BufWritePre";
          group = "userConfig";
          callback = {
            __raw = ''
              function()
                local dir = vim.fn.expand("<afile>:p:h")
                  if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, "p") end
              end
            '';
            desc = "Create missing parant directories when saving";
          };
        }
      ];
    };
}
