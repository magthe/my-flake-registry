{
  # nixpkgs and flake-ustils come from the registry

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      with nixpkgs.legacyPackages.${system};
      let hsPkgs = haskell.packages.ghc984;
      in {
        devShells.default =
          hsPkgs.shellFor { packages = p: [ p.haskell-language-server ]; };
      });

  nixConfig = {
    flake-registry =
      "https://raw.githubusercontent.com/magthe/my-flake-registry/main/flake-registry.json";
    extra-substituters = [ "https://magthe-dev.cachix.org" ];
    extra-trusted-public-keys = [
      "magthe-dev.cachix.org-1:mFSHoML7X60LmeIf+vvmuG6uBHdufg8kcUkcfSV3yHc="
    ];
  };
}
