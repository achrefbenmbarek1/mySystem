{
  description = "nix euphemeral environment for nvim config";

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
      lua-language-server
      luajitPackages.luacheck
      stylua
];
    };
  };
}
