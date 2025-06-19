{
  description = "Holistics Nix workshop packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          # Uncomment to allow unfree packages
          # config.allowUnfree = true;
        };
      in
      {
        packages = {
          default = pkgs.buildEnv {
            name = "default";
            paths = with pkgs; [
              hello
            ];
          };

          example1 = pkgs.buildEnv {
            name = "example1";
            paths = with pkgs; [
              hello
              cowsay
            ];
          };
          
          # You can also define package subsets if desired
          # Install with `nix profile intall .#minimal`
          dev-tools = pkgs.buildEnv {
            name = "dev-tools";
            paths = with pkgs; [ 
              git neovim ripgrep
            ];
          };
        };
      }
    );
}
