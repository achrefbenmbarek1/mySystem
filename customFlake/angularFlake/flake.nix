{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
  system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
  {

    devShells.x86_64-linux.default = pkgs.mkShell  {
      buildInputs = with pkgs; [ 
      nodePackages."@angular/cli" 
      nodePackages.typescript 
      nodePackages.npm 
      nodejs_22
      ];
    };
  };

}
