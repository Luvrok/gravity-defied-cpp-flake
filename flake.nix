{
  description = "Gravity Defied CPP packaged with Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    gravity-defied-src = {
      url = "github:rgimad/gravity_defied_cpp/91bd283959b96a7ea07e1c4c0040460334c85458";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, gravity-defied-src }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.callPackage ./pkgs/default.nix {
            src = gravity-defied-src;
          };
        });

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/gravity-defied-cpp";
        };
      });
    };
}
