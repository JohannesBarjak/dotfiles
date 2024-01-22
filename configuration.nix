# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable flakes.
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
        experimental-features = nix-command flakes
    '';
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable zram.
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    priority = 100;
    memoryPercent = 100;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 200;
    "vm.page-cluster" = 1;
  };

  # Enable opengl.
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  #Enable bluetooth.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.johannes = {
    isNormalUser = true;
    description = "Johannes";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [];
    shell = pkgs.nushellFull;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc bat

    hyprpaper
    swaylock-effects swayidle
    wl-clipboard

    loupe
    lean4
    wineWowPackages.waylandFull bottles
    cinnamon.nemo-with-extensions
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.

  # Enable dconf.
  programs.dconf.enable = true;

  # Add hyprland.
  programs.hyprland.enable = true;
  programs.waybar.enable = true;
  programs.light.enable = true;

  # Add Fira Code fonts.
  fonts.packages = with pkgs; [
    ( nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  programs.firefox.enable = true;

  # List services that you want to enable:

  # Gvfs provides trash and remote fs support
  services.gvfs.enable = true;

  # Define login manager.
  services.greetd = {
    enable = true;

    settings.default_session = {
      # Run hyprland in a dbus session so that xdg-mime works correctly.
      command = "${pkgs.greetd.greetd}/bin/agreety --cmd \"dbus-run-session Hyprland &> /dev/null\"";
    };
  };

  # Enable auto-cpufreq.
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "auto";
    };

    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  # Enable pipewire.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Enable dbus and upower.
  services.dbus.enable = true;
  services.upower.enable = true;

  # Add swaylock to pam.
  security.pam.services.swaylock = {};

  # Enable flatpak.
  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
