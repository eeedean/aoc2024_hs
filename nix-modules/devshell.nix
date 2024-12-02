{inputs, ...}: {
  perSystem = {
    config,
    pkgs,
    system,
    ...
  }: {
    devShells.default = pkgs.mkShell (
      let
        pkgs-unstable = inputs.nixos-unstable.legacyPackages."${system}";
      in {
        name = "haskell-shell";
        inputsFrom = [
          config.devShells.horizon-haskell
          config.treefmt.build.devShell
        ];
        buildInput = [
          pkgs.stylish-haskell
        ];
        shellHook = ''
          ${config.checks.pre-commit-check.shellHook}
        '';
      }
    );
  };
}
