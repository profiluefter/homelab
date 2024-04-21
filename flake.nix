{
  inputs.nixpkgs.url = "nixpkgs";
  inputs.talhelper.url = "github:budimanjojo/talhelper";

  outputs = { self, nixpkgs, talhelper }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          kubectl
          fluxcd
          sops
          terraform
          talosctl
          talhelper.packages.x86_64-linux.default
        ];

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
