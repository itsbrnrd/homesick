{ config, pkgs, ... }:

{ boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Berlin";

  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
     curl
     vim
     git
     coreutils
     python3
     stow
     gnupg
     ranger
     neofetch
  ];

  programs.zsh.enable = true;
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  environment.variables.EDITOR = "vim";

  system.stateVersion = "19.03";
}