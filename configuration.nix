# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./modules/pcloud.nix
#      ./modules/sylix.nix
	inputs.hardware.nixosModules.common-cpu-intel
    ];

  systemd.services.zfs-mount.enable = false;
  networking.hostId = "8c98794c";
#  boot.loader.systemd-boot.enable = true;
#  boot.loader.efi.canTouchEfiVariables = true;
   boot.tmp.cleanOnBoot = true;
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "nodev";
  boot.kernelParams = [ "video=HDMI-A-1:2560x1440@60" "video=eDP-1:1920x1080"];
  boot.initrd.availableKernelModules = [ "i915" ];
  
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  nixpkgs.config.allowUnfree = true;
  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  system.autoUpgrade = {
	enable = true;
	dates = "daily";
	allowReboot = false;
	};

  nix = {
	optimise.automatic = true;
	settings = {
		auto-optimise-store = true;
		experimental-features = [ "nix-command" "flakes" ];
		fallback = true;
		warn-dirty = false;
		nix-path = config.nix.nixPath;
		};
	gc = {
		automatic = true;
		dates = "daily";
		options = "--delete-older-than 2d";
		};
	};

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  services = {
  	zfs.autoScrub.enable = true;
	displayManager.gdm.enable = true;
	desktopManager.gnome.enable = true;
	printing.enable = true;
	pipewire = {
	    enable = true;
	    pulse.enable = true;
	  };
	  openssh.enable = true;
};
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";



  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

users = {
	mutableUsers = true;
	defaultUserShell = pkgs.fish;
 	users.deman = {
    		isNormalUser = true;
    		extraGroups = [ "wheel" "networkmanager" "audio" "video" ]; # Enable ‘sudo’ for the user.
		};
  };

environment = {
	variables.EDITOR = "nvim";
	systemPackages = with pkgs; [
    	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    	git
	unzip
    	wget
	pciutils
	neovim
	nil
	ghostty
  ];
};

programs = {
	fish.enable = true;
	firefox.enable = true;
	dconf.enable = true;
#	ssh.startAgent = true;
	mtr.enable = true;
 	gnupg.agent = {
    		enable = true;
    		enableSSHSupport = true;
  		};
};


  fonts.packages = with pkgs; [
    noto-fonts
    font-awesome
#    nerd-fonts.m
    nerd-fonts.jetbrains-mono
  ];


  system.stateVersion = "25.05"; # Did you read the comment?

}

