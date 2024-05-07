# Configuration is Derived from "rust-overlay" README
# "Use in devShell for nix develop"
#
# Reference:
# https://github.com/oxalica/rust-overlay
#
# Added Packages
# - rust-analyzer
# - bat
# - marksman
{
  description = "A Rust Flake for Kubernetes Operator-RS Project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url  = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem(system: 
      let
        overlays = [( import rust-overlay )];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            openssl
            pkg-config
            eza
            fd
            bat
            marksman
            rust-analyzer
            rust-bin.stable.latest.default
          ];
        };
      }
    );
}
