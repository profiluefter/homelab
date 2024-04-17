{
  inputs.nixpkgs.url = "nixpkgs";

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [ kubectl argocd sops terraform ];

        shellHook = ''
          if [[ ! -f kubeconfig ]]; then
            echo "Please execute from project root" >&2
            exit 1
          fi
          export KUBECONFIG=$(pwd)/kubeconfig
        '';
      };

      formatter.x86_64-linux = pkgs.nixpkgs-fmt;
    };
}
