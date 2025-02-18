{
	description = "bonsthie neovim config";
	inputs = {
		nixpkgs = {
			url = "github:NixOS/nixpkgs/nixos-unstable";
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
		myNeovim = import ./nix/myNeovim.nix {
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
		};
	};
}
