{ pkgs, ... }: {
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
    packages = [];
    shell = pkgs.nushellFull;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable gnome.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = [ pkgs.gnome.gnome-software ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wl-clipboard
    lean4

    ppsspp-sdl-wayland pcsx2
    bsnes-hd mgba melonDS
    dosbox-x _86Box

    keepassxc
    openvpn
  ];

  environment.sessionVariables = {
    TERMINAL = "alacritty";
    EDITOR = "hx";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.

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

  # List services that you want to enable:

  # Power management.
  services.thermald.enable = true;
  services.ananicy.enable = true;

  # Enable upower and polkit.
  services.upower.enable = true;
  security.polkit.enable = true;

  # Enable flatpak.
  services.flatpak.enable = true;

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
