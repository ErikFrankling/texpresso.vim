{
  description = "texpresso.vim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    {
      overlays.default = (final: prev: {
        vimPlugins = prev.vimPlugins //
        {
          texpresso-vim = prev.vimPlugins.texpresso-vim.overrideAttrs (old: {
            version = "1.0.0";
            src = ./.;
          });
        };
      });
    } //
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.texpresso-vim = pkgs.vimUtils.buildVimPlugin {
          pname = "texpresso-vim";
          # version = "2024-12-25";
          version = "1.0.0";
          src = ./.;
          # meta.homepage = "https://github.com/let-def/texpresso.vim/";
          # meta.hydraPlatforms = [ ];
        };
        packages.default = self.packages.${system}.texpresso-vim;
      }
    );
}
