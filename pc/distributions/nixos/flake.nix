{
  description = "Flake NixOS Configuration - Blueskies";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs"; # follow the nixpkgs input to avoid having multiple versions of nixpkgs (i.e. avoids duplicating the same dependency (like nixpkgs) across multiple inputs)
    };
    nvf.url = "github:notashelf/nvf";
    sysc-greet = {
      url = "github:Nomadcxx/sysc-greet";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae.url = "github:vicinaehq/vicinae";
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nur, home-manager, nvf, sysc-greet, niri, vicinae, stylix, ... }: {
    packages."x86_64-linux".my-neovim = 
      (nvf.lib.neovimConfiguration {
	pkgs = nixpkgs.legacyPackages."x86_64-linux";
	modules = [ ./nvf-configuration.nix ];
      })
      .neovim;

    nixosConfigurations.blueskies = nixpkgs.lib.nixosSystem {
      # Parse in all inputs we have declared in this flake to all submodules(configuration.nix, etc.)
      # Useful for us, as we want all inputs to be the same (e.g. this will make the version/commit of nixpkgs be the same over all modules and submodules we import)
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
	nur.modules.nixos.default

	#nvf.nixosModules.default
        ({pkgs, ...}: {
          environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.my-neovim];
        })
	
	sysc-greet.nixosModules.default
	stylix.nixosModules.stylix
	home-manager.nixosModules.home-manager
	{
	  home-manager = {
            useGlobalPkgs = true;
	    useUserPackages = true;
	    extraSpecialArgs = { inherit inputs; };
	    users.mendiss = ./home.nix;
	    sharedModules = [
	      niri.homeModules.niri
	      niri.homeModules.stylix
	      vicinae.homeManagerModules.default
	    ];
	  };
	}
      ];
    };
  };
}
