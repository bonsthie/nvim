{
  description = "bonsthie nvim config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      neovim,
    }:
    let
      overlayNeovim = prev: final: {
        neovim = neovim.packages.x86_64-linux.neovim;
      };

      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ overlayNeovim ];
      };

      myNeovim = import ./nix { inherit pkgs; };

    in
    {
      packages.x86_64-linux.default = myNeovim;

      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          myNeovim
        ];
      };
    };
}
