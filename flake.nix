{
  description = "My own Neovim flake";
<<<<<<< HEAD
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };
    neovim = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, neovim }:
    let
      overlayFlakeInputs = prev: final: {
        neovim = neovim.packages.x86_64-linux.neovim;
      };

      overlayMyNeovim = prev: final: {
        myNeovim = import ./nix/config.nix {
          pkgs = final;
        };
      };

      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ overlayFlakeInputs overlayMyNeovim ];
      };

    in {
      packages.x86_64-linux.default = pkgs.myNeovim;
      apps.x86_64-linux.default = {
        type = "app";
        program = "${pkgs.myNeovim}/bin/nvim";
=======

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, neovim }:
    let
      overlayNeovim = prev: final: {
        neovim = neovim.packages.x86_64-linux.neovim;
      };

      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ overlayNeovim ];
      };

      nvimConfig = pkgs.stdenv.mkDerivation {
        name = "nvim-config";
        src = ./.;
        installPhase = ''
          mkdir -p $out/config/nvim
          cp -r * $out/config/nvim/
        '';
      };

      myNeovim = pkgs.wrapNeovim pkgs.neovim {
        configure = {
          viAlias = true;
          vimAlias = true;
          extraPackages = with pkgs; [
            ripgrep
            clangd
            lua-language-server
          ];
          extraWrapperArgs = ''--set XDG_CONFIG_HOME ${nvimConfig}/config'';
          customRC = ''
            let $XDG_CONFIG_HOME="${nvimConfig}/config"
            set runtimepath^=${nvimConfig}/config/nvim
            source ${nvimConfig}/config/nvim/init.lua
          '';
        };
      };
    in {
      packages.x86_64-linux.default = myNeovim;
      packages.x86_64-linux.nvimConfig = nvimConfig;
      apps.x86_64-linux.default = {
        type = "app";
        program = "${myNeovim}/bin/nvim";
>>>>>>> refs/remotes/origin/beta
      };
    };
}
