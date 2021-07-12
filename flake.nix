{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/21.05;

  outputs = { self, nixpkgs }: 
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);

    in
      {
        devShell = forAllSystems (system: 

          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
            pkgs.mkShell {
              buildInputs = 
              [
                # python environment
                (
                  pkgs.python38.withPackages (p: [
                    p.markdown
                  ])
                )

              ];
            }
        );
      };
}
