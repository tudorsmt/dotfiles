# Nix home-manager

After installing nix home manager, link home.nix to

```bash
~/.config/home-manager/home.nix
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
