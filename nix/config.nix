{ pkgs }:
pkgs.wrapNeovim pkgs.neovim {
	configure = {
# here will come your custom configuration
	};
}
