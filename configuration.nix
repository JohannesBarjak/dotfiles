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

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.memtest86.enable = true;

  boot.kernelParams = [ "quiet" "loglevel=3" ];

  boot.initrd.systemd.enable = true;

  boot.plymouth = {
    enable = true;

    theme = "cross_hud";
    themePackages = with pkgs; [ (adi1090x-plymouth-themes.override { selected_themes = [ "cross_hud" ]; }) ];
  };

  fileSystems."/".options = [ "compress-force=lzo" "noatime" ];

  # Enable opengl.
  hardware.opengl = {
    enable = true;

    driSupport = true;
    driSupport32Bit = true;
  };

  #Enable bluetooth.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;

  hardware.enableAllFirmware = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wl-clipboard glib
    lean4

    ppsspp-sdl-wayland pcsx2
    bsnes-hd mgba melonDS
    dosbox-x _86Box

    keepassxc
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

    fontconfig.enable = true;
  };

  # List services that you want to enable:

  # Power management.
  services.ananicy.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;
  services.journald.extraConfig = "SystemMaxUse=50M";

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
