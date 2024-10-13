{
  description = "nix euphemeral environment for kuber";

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
      kind
      docker
      kubectl
      helmfile
      (pkgs.wrapHelm pkgs.kubernetes-helm { plugins = [ pkgs.kubernetes-helmPlugins.helm-diff ]; })
      k9s
      jqp
      helm-ls
      yaml-language-server
      kubectx
      argocd
];
    shellHook = ''
            
            # Switch to Zsh shell
            if [ -f ~/.zshrc ]; then
              zsh
            fi

            # Start Docker daemon in the background if it's not already running
            if ! pgrep -x dockerd > /dev/null; then
              echo "Starting Docker daemon..."
              sudo $(command -v dockerd)
            fi
          '';
    };
  };
}


