{ pkgs ? import <nixpkgs> { inherit system; }, system ? __currentSystem }:

let
  silver = { darwin, stdenv, rustPlatform, openssl, pkgconfig, libiconv }:

    rustPlatform.buildRustPackage rec {
      pname = "silver";
      version = "1.2.0";
      src = ./.;

      buildInputs = [ pkgconfig openssl libiconv ]
        ++ (stdenv.lib.optional stdenv.isDarwin
          darwin.apple_sdk.frameworks.Security);

      cargoSha256 =
        "sha256:0chdy38nl4yi20klraml9v1jpn1r10aicbyqjpi7q99kmvx06vnq";

      meta = with stdenv.lib; {
        homepage = "https://github.com/reujab/silver";
        description =
          "A cross-shell customizable powerline-like prompt with icons";
        license = licenses.unlicense;
        platforms = platforms.all;
      };
    };
in pkgs.callPackage silver { }
