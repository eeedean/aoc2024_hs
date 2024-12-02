{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];
  perSystem = {
    self',
    lib,
    config,
    pkgs,
    ...
  }: {
    formatter = pkgs.alejandra;
    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        alejandra.enable = true;
        cabal-fmt.enable = true;
        stylish-haskell.enable = true;
      };
    };
  };
}
