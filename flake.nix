{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = import ./pkgs/shell.nix {inherit pkgs;};
        packages = {
          web-app = pkgs.callPackage ./pkgs/web-app.nix {};
          web-app-image = pkgs.callPackage ./pkgs/web-app-image.nix {
            web-app = self.packages.${system}.web-app;
          };
        };
      }
    );
}
