{pkgs}: let
  gnumake = pkgs.writeShellScriptBin "make" ''exec nix develop --command ${pkgs.gnumake}/bin/make -C $(${pkgs.git}/bin/git rev-parse --show-toplevel) "$@"'';
in
  pkgs.mkShell {
    packages =
      [
        gnumake
      ]
      ++ (with pkgs; [
        fd
        nixfmt
        alejandra
        nodejs_25
        tailwindcss-language-server
      ])
      ++ (with pkgs.nodePackages_latest; [
        pnpm
      ]);
  }
