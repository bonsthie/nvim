{
  pkgs,
  lib,
  stdenv,
  # Set by the overlay to ensure we use a compatible version of `wrapNeovimUnstable`
  pkgs-wrapNeovim ? pkgs,
}:
{
    nvimRtp = stdenv.mkDerivation {
      name = "nvim-rtp";
      src = nvimRtpSrc;

      buildPhase = ''
        mkdir -p $out/nvim
        mkdir -p $out/lua
        rm init.lua
      '';

      installPhase = ''
        cp -r lua $out/lua
        rm -r lua
        # Copy nvim/after only if it exists
        if [ -d "after" ]; then
            cp -r after $out/after
            rm -r after
        fi
        # Copy rest of nvim/ subdirectories only if they exist
        if [ ! -z "$(ls -A)" ]; then
            cp -r -- * $out/
        fi
      '';
    };
}
