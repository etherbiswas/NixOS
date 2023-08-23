{ config, pkgs, ... }:

{
	imports = [
    ../../modules/amd/default.nix # Default to amd graphics
    # ../../modules/intel/default.nix # Default to intel graphics
    # ../../modules/podman/default.nix # Enable Podman
    # ../../modules/neo4j/default.nix # Enable Neo4j
	];
}
