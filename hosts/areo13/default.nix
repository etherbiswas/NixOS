{ config, pkgs, ... }:

{
	imports = [
   ../../modules/amd/default.nix # Default to amd
   # ../../modules/intel/default.nix # Uncomment for intel graphics
	];
}
