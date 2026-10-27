{
  self,
  inputs,
  ...
}:
{
  flake.wrappers.codelldb =
    {
      pkgs,
      wlib,
      config,
      lib,
      ...
    }:
    {
      imports = [ wlib.modules.default ];
      config = {
        package = lib.mkDefault pkgs.vscode-extensions.vadimcn.vscode-lldb;
        exePath = "share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
        binName = "codelldb";
        addFlag = [
          [
            "--liblldb"
            "${config.package}/share/vscode/extensions/vadimcn.vscode-lldb/lldb/lib/liblldb.so"
          ]
        ];
      };
    };
}
