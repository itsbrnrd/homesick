# Homesick
[![https://nixos.org/nixos/](https://img.shields.io/badge/nixos-19.03-blueviolet.svg)](https://nixos.org/nixos/)

_/ˈhoʊm.sɪk/_
1. Experiencing a longing for one's home during a period of absence from it.
2. Collection of dot files, configuration files and homebrewed scripts/tools to make every machine feel like _home_.

## Requirements
- [NixOS](https://nixos.org/nixos/)
- [GNU Stow](https://www.gnu.org/software/stow/)

## Installation

### [Download](https://nixos.org/nixos/download.html) and install NixOS
1. Connect to internet
```
wpa_supplicant -B -i interface -c <(wpa_passphrase 'SSID' 'key')
```

2. Partition disk
```
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart primary 512MiB -12GiB
parted /dev/sda -- mkpart primary linux-swap -12GiB 100%
parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
parted /dev/sda -- set 3 boot on
```
3. Format and mount
```
mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda3

mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/sda2
```

4. Get and install the nixos config
```
sudo stow nixos -t /etc/nixos
```

5. and then
```
nixos-install
reboot
```

### Install dotfiles
Clone the repository. Don't forget to pull the submodules with
```
git submodule update --init --recursive
```

and then
```
stow extra git i3 polybar rofi vscode xorg zsh
sudo stow slim -t /
```

## Features
1. Easy install
2. Click on the wifi module in polybar. Alternatively, you can use `nmtui`
in a shell to find and connect to a wifi.
3. Screenshots: press Super+Print Screen to capture the whole screen,
Super+Ctrl+Print Screen to capture the whole screen and put it in the clipboard
and Super+Shift+Print Screen to capture an area of the screen.

## TODO
- [ ] Encryption of /
- [ ] Bluetooth and audio support
- [ ] Fix Slimlock customization
- [ ] Allow font size change in urxvt
- [ ] Write installation steps
