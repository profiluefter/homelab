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
          kubectx

          fluxcd
          sops
          age

          talosctl
          talhelper.packages.x86_64-linux.default

          terraform

		  # the terraform sops provider seems to not support unlocking the GPG key
          (writeShellScriptBin "unlock-gpg" "gpg --sign -o /dev/null <(echo 'test')")
        ];

        shellHook = ''
          if [[ ! -f kubeconfig ]]; then
            echo "Please execute from project root" >&2
            exit 1
          fi
          export KUBECONFIG=$(pwd)/kubeconfig
          export TALOSCONFIG=$(pwd)/talos/clusterconfig/talosconfig
        '';
      };

      formatter.x86_64-linux = pkgs.nixpkgs-fmt;
    };
}
