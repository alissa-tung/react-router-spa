{
  lib,
  stdenv,
  nodejs_25,
  pnpm,
  fetchPnpmDeps,
  pnpmConfigHook,
}: let
  pname = "web-app";
in
  stdenv.mkDerivation (finalAttrs: {
    inherit pname;
    version = "0.0.0";

    src = lib.cleanSource ./..;

    pnpmWorkspaces = [pname];

    pnpmDeps = fetchPnpmDeps {
      inherit
        (finalAttrs)
        pname
        version
        src
        pnpmWorkspaces
        ;
      fetcherVersion = 3;
      hash = "sha256-BRcMmvVYILOs59O86nnfWqtQHHHFSVVL7jGQ20+WTkk=";
    };

    nativeBuildInputs = [
      pnpmConfigHook
      pnpm
      nodejs_25
    ];

    buildPhase = ''
      pnpm --filter=${pname} run build
    '';

    installPhase = ''
      cp -r ./src/${pname}/build/client $out
    '';
  })
