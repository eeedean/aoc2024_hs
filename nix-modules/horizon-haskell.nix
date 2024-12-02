{inputs, ...}: {
  imports = [];
  perSystem = {
    pkgs,
    system,
    ...
  }:
    with pkgs.haskell.lib.compose; let
      myOverlay = final: prev: {
        aoc2024 = dontCheck (final.callCabal2nix "aoc2024" ./.. {});
      };

      legacyPackages = inputs.horizon-platform.legacyPackages.${system}.extend myOverlay;
      devtool-pkgs = inputs.horizon-devtools.legacyPackages.${system};
    in {
      devShells.horizon-haskell = legacyPackages.aoc2024.env.overrideAttrs (attrs: {
        buildInputs =
          attrs.buildInputs
          ++ [
            legacyPackages.cabal-install
            devtool-pkgs.haskell-language-server
          ];
      });

      packages.default = legacyPackages.aoc2024;
    };
}
