{
  lib,
  stdenv,
  nodejs_25,
  pnpm,
  fetchPnpmDeps,
  pnpmConfigHook,
}: let
  pname = "web-app";
  pnpmWorkspacePrefix = "@monorepo";
in
  stdenv.mkDerivation (finalAttrs: {
    inherit pname;
    version = "0.0.0";

    src = lib.cleanSource ./..;

    pnpmWorkspaces = ["${pnpmWorkspacePrefix}/${pname}"];

    pnpmDeps = fetchPnpmDeps {
      inherit
        (finalAttrs)
        pname
        version
        src
        pnpmWorkspaces
        ;
      fetcherVersion = 3;
      hash = "sha256-35bLFFKuNcFWsgSGBqe9v2ZEsXHgqk19TnI0j477DIE=";
    };

    nativeBuildInputs = [
      pnpmConfigHook
      pnpm
      nodejs_25
    ];

    buildPhase = ''
      pnpm --filter=${pnpmWorkspacePrefix}/${pname} run build
    '';

    installPhase = ''
      cp -r ./src/${pname}/build/client $out
    '';
  })
