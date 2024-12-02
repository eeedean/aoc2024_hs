{
  description = "Advent of Code 2024";

  nixConfig = {
    extra-substituters = "https://horizon.cachix.org";
    extra-trusted-public-keys = "horizon.cachix.org-1:MeEEDRhRZTgv/FFGCv3479/dmJDfJ82G6kfUDxMSAw0=";
  };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/658e7223191d2598641d50ee4e898126768fe847";
    horizon-devtools.url = "git+https://gitlab.horizon-haskell.net/package-sets/horizon-devtools?ref=lts/ghc-9.6.x";
    horizon-platform.url = "git+https://gitlab.horizon-haskell.net/package-sets/horizon-platform?ref=lts/ghc-9.6.x";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    pre-commit-hooks,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-linux"
      ];
      imports = with builtins; map (fn: ./nix-modules/${fn}) (attrNames (readDir ./nix-modules));
    };
}
