{inputs, ...}: {
  imports = [];
  perSystem = {
    self',
    lib,
    system,
    config,
    pkgs,
    ...
  }: {
    checks = {
      pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          cabal-fmt.enable = true;
          hlint.enable = true;
          alejandra.enable = true;
          statix.enable = true;
        };
      };
    };
  };
}
