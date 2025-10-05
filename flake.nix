{
  description = "Rob's personal website";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        projectName = "website-astro";
        version = "0.1.0";

      in
      {
        packages.default = pkgs.buildNpmPackage {
          pname = projectName;
          inherit version;
          src = ./.;

          npmDepsHash = "sha256-FJta/3otgip4gcoUyhX3UVCWrX54E8ntHqEk8mhobPU=";

          installPhase = ''
            runHook preInstall
            mkdir -p $out
            cp -r dist/* $out/
            runHook postInstall
          '';
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs
          ];
        };
      });
}
