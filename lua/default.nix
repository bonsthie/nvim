{
  pkgs,
}:
pkgs.stdenv.mkDerivation {
  name = "nvim-config";
  src = ../.;
  installPhase = ''
    mkdir -p $out/config/nvim
    cp -r * $out/config/nvim/
  '';
}
