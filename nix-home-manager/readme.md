# Nix home-manager

After installing nix home manager, link home.nix to

```bash
~/.config/home-manager/home.nix
```

## Cleaning up the cache

<https://nixos.wiki/wiki/Cleaning_the_nix_store>

Listing home manager generations:

```sh
home-manager generations

# Clean up older than 30 days
home-manager expire-generations "-30 days"
```


Cleaning up Nix Package Manager generations
```bash

# remove garbage older than 30 days
nix-collect-garbage --delete-older-than 30d

# Brutally clean up everything
nix-store --gc
```


## Manage Gnome settings with Home Manager

Reference:
<https://heywoodlh.io/nixos-gnome-settings-and-keyboard-shortcuts>

## NixGL

In order to run graphical UIs, NixGL can help:

<https://github.com/nix-community/nixGL>

``` bash
nix-channel --add https://github.com/nix-community/nixGL/archive/main.tar.gz nixgl && nix-channel --update

nix-env -iA nixgl.auto.nixGLDefault
```
