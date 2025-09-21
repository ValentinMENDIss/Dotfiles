{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
	# CLI-Management Utilites
	vim
	git
	wget
	neofetch
	iftop
	btop
	speedtest-cli
	podman-compose
	yazi
  ];
}
