{
  description = "Dev shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nur.url = "github:nix-community/NUR";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nur, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = import nixpkgs { inherit system; overlays = [ nur.overlay ];};
        nurpkgs = pkgs.nur.repos.eggflaw; 
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            lune
            nurpkgs.wally
          ];
        };
      }
    );
  }
