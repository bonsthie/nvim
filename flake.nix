{
  description = "oui neovim config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = inputs@{nixpkgs, flake-utils, ...}:
  let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
	forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
		pkgs = import nixpkgs { inherit system; };
	});
	in {
		packages = forEachSupportedSystem ({ pkgs }: rec {
			default = nvim;
			nvim = import ./nix/mkNvim.nix
		});	
	}
}
