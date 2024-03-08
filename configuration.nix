# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./system
    ];

  # Enable flakes.
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  nix.optimise.automatic = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  boot.kernelParams = [ "quiet" "loglevel=3" "nowatchdog" ];

  boot.extraModprobeConfig = ''
    blacklist iTCO_wdt
    blacklist sp5100_tco
  '';

  boot.initrd.systemd.enable = true;

  boot.plymouth = {
    enable = true;

    theme = "cross_hud";
    themePackages = with pkgs; [ (adi1090x-plymouth-themes.override { selected_themes = [ "cross_hud" ]; }) ];
  };

  fileSystems."/".options = [ "compress-force=zstd:2" "autodefrag" "noatime" ];

  # Enable opengl.
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  hardware.opengl.extraPackages = with pkgs; [ intel-media-driver ];

  #Enable bluetooth.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;

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
  services.xserver.xkb = {
    layout = "us";
    variant = "";
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
    wl-clipboard

    loupe
    lean4
    wineWowPackages.waylandFull bottles
    gnome.nautilus
    valent

    ppsspp-sdl-wayland pcsx2
    bsnes-hd mgba melonDS
    dosbox-x _86Box

    keepassxc
    pavucontrol helvum
    openvpn

    celluloid
  ];

  environment.sessionVariables = {
    TERMINAL = "alacritty";
    EDITOR = "hx";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.

  # Enable dconf.
  programs.dconf.enable = true;

  # Enable hyprland here for system integration.
  programs.hyprland.enable = true;
  programs.waybar.enable = true;

  # Configure fonts.
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      ( nerdfonts.override { fonts = [ "FiraCode" "Cousine" ]; })
    ];

    fontconfig = {
      enable = true;
      subpixel.rgba = "rgb";
    };
  };

  programs.evince.enable = true;

  # List services that you want to enable:

  # Add udev rules for backlight control.
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
  '';

  # Gvfs provides trash and remote fs support
  services.gvfs.enable = true;

  # Enable sushi for nautilus.
  services.gnome.sushi.enable = true;

  # Power management.
  services.tlp.enable = true;
  services.thermald.enable = true;
  services.ananicy.enable = true;

  # Enable pipewire.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Enable dbus, upower and polkit.
  services.dbus.enable = true;
  services.upower.enable = true;
  security.polkit.enable = true;

  # Allow unlocking with swaylock in pam.
  security.pam.services.swaylock = {};

  # Enable flatpak.
  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Add VirtualBox.
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "johannes" ];

  systemd.services.NetworkManager-wait-online.enable = false;
  services.journald.extraConfig = "SystemMaxUse=50M";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable ports for kde connect.
  networking.firewall.allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
  networking.firewall.allowedUDPPortRanges = [{ from = 1714; to = 1764; }];

  # Add vpn.
  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
