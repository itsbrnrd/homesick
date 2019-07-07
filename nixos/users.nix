{ config, pkgs, ... }:

{ users.users.mb = with pkgs; {
    description = "Mathieu Bernard";
    isNormalUser = true;
    shell = zsh;
    uid = 1000;
    extraGroups = [ 
      "wheel" 
      "audio" "video"
      "networkmanager"
    ];
  };
}