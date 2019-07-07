{ config, pkgs, ... }:

{ services.xserver = {
      enable = true;
      layout = "us";

      libinput.enable = true;

      windowManager.i3.enable = true;

      desktopManager = {
          default = "none";
          xterm.enable = false;
      };

      videoDrivers = [ "mesa" ];

      displayManager.slim = {
        enable = true;

        theme = pkgs.fetchurl {
          url = "https://github.com/itsbrnrd/homesick/raw/master/slim/slim-theme.tar.gz";
          sha256 = "4f438b71070cbcd1f82714ece43649a1c40eca1f278d585bfa5e75aac8f9b82f";
        };
      };
  };

  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = pkgs:{
      polybar = pkgs.polybar.override { i3Support = true; };
    };
  };

  environment.systemPackages = with pkgs; [
     xclip xorg.xkill
     polybar
     rofi
     iw wirelesstools # required by rofi-wifi-menu
     rxvt_unicode
     feh
     scrot
     firefox
     vscode
     mpv youtube-dl
  ];

  fonts.fonts = with pkgs; [
    hack-font
    fira
    font-awesome_5
  ];

  sound.enable = true;
  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    # Run the following command to print keycodes
    # nix-shell -p actkbd --run "sudo actkbd -n -s -d /dev/input/event0"
    # or
    # sudo showkey -k
    bindings = [
      { keys = [ 224 ]; events = [ "key" "rep" ]; command = "/run/current-system/sw/bin/light -U 5"; }
      { keys = [ 225 ]; events = [ "key" "rep" ]; command = "/run/current-system/sw/bin/light -A 5"; }
      { keys = [ 113 ]; events = [ "key" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master toggle"; }
      { keys = [ 114 ]; events = [ "key" "rep" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master 5- unmute"; }
      { keys = [ 115 ]; events = [ "key" "rep" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master 5+ unmute"; }
      { keys = [ 190 ]; events = [ "key" ]; command = "${pkgs.alsaUtils}/bin/amixer set Capture toggle"; }
    ];
  };
}
