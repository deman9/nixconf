# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      ./modules/pcloud.nix
     ./modules/sylix.nix
	inputs.hardware.nixosModules.common-cpu-intel
    ];

  systemd.services.zfs-mount.enable = false;
  boot = {
  	loader.systemd-boot.enable = true;
	tmp.cleanOnBoot = true;
	kernelParams = [ "quiet" "video=HDMI-A-1:2560x1440@60" "video=eDP-1:1920x1080"];
	initrd.availableKernelModules = [ "i915" ];
	initrd.systemd.enable = true;
	plymouth.enable = true;
	};

  networking = {
	hostId = "8c98794c";
	hostName = "nixos"; # Define your hostname.
	networkmanager.enable = true;  # Easiest to use and most distros use this by default.
	};



  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Europe/Warsaw";

  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [ vaapiIntel intel-media-driver ];
  hardware = {
#  	printers = true;
	bluetooth.enable = true;
	};
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
  security.pam.services.swaylock = {};
  security.rtkit.enable = true;

  services = {
	xserver.enable = true;
  	zfs.autoScrub.enable = true;
#	displayManager.gdm.enable = true;
#	desktopManager.gnome.enable = true;
	gnome.gnome-keyring.enable =true;
	blueman.enable=true;

	printing.enable = true;
	avahi = {
	    enable = true;
	    nssmdns4 = true;
	    openFirewall = true;
	    };
	pipewire = {
	    enable = true;
	    pulse.enable = true;
	    alsa.enable = true;
	    alsa.support32Bit = true;
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
	pavucontrol
	pciutils
	neovim
	nil
	ghostty
  ];
};
  # gnome remove packages
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-text-editor
  ]) ++ (with pkgs; [
    cheese # webcam tool
    gnome-contacts
    gnome-clocks
    gnome-music
    gnome-maps
    epiphany # web browser
    geary # email reader
    gnome-characters
    gnome-weather
    simple-scan
    totem # video player
  ]);
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
	niri.enable = true;
};


  fonts.packages = with pkgs; [
    noto-fonts
    font-awesome
#    nerd-fonts.m
    nerd-fonts.jetbrains-mono
  ];


  system.stateVersion = "25.05"; # Did you read the comment?

}

