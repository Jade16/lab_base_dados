{
  description = "Para realizar a conexão com o Servidor do PostgreSQL via linha de comando";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          #openconnect
          postgresql  
          #pgadmin4 
      ];
      shellHook = ''
        echo "É necessário conectando à VPN USP"
        echo "Para isso, execute: ./scripts/conectar-vpn.sh" 
        echo "Para conectar no servidor, execute o seguinte comando com devidos dados:"
        echo "psql -h host -p port -U username -d database"
      '';
      };
    });
}
