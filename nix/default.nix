{
  lib ? pkgs.lib,
  pkgs,
}:
let
  rc = import ../lua { inherit pkgs; };
  extrapkgs = with pkgs; [
    clang-tools
    ripgrep
    lua-language-server
  ];
in
pkgs.wrapNeovim pkgs.neovim-unwrapped {
  extraMakeWrapperArgs = builtins.concatStringsSep " " (
    lib.optional (extrapkgs != [ ]) ''--prefix PATH : ${lib.makeBinPath extrapkgs}''
  );

  configure = {
    viAlias = true;
    vimAlias = true;
    extraWrapperArgs = ''--set XDG_CONFIG_HOME ${rc}/config'';
    customRC = ''
      let $XDG_CONFIG_HOME="${rc}/config"
      set runtimepath^=${rc}/config/nvim
      source ${rc}/config/nvim/init.lua
    '';
  };
}
