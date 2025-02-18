{
	description = "bonsthie neovim config";
	inputs = { 
		nixpkgs = {
			url = "github:NixOS/nixpkgs";
		};
		neovim = {
			url = "github:nix-community/neovim-nightly-overlay";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	outputs = { self, nixpkgs, neovim }: {
		packages.x86_64-linux.default = neovim.packages.x86_64-linux.neovim;
		apps.x86_64-linux.default = {
			type = "app";
			program = "${neovim.packages.x86_64-linux.neovim}/bin/nvim";
		};
	};
}
