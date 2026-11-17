# Nix home-manager

After installing nix home manager, link home.nix to

```bash
~/.config/home-manager/home.nix
```

## Neovim

Set up by [neovim.nix](./neovim.nix), which is imported from `home.nix`:

- `neovim.nix` installs the plugins and the tree-sitter grammars.
- [nvim/init.lua](./nvim/init.lua) has the options, key maps and plugin setup. Home
  Manager writes it to `~/.config/nvim/init.lua`.

Both end up as read-only files in the Nix store, so apply a change with
`home-manager switch` and restart Neovim.

The leader key is `<Space>`. Yank, delete and paste use the system clipboard
(`clipboard=unnamedplus`) through xclip, see the note in `neovim.nix`.

| Plugin | What for | Keys |
| --- | --- | --- |
| monokai-pro.nvim | Monokai colors, tuned to match VS Code's Monokai | |
| gitsigns.nvim | Git gutter | `]c` / `[c` next / previous hunk, `<leader>hp` preview, `<leader>hs` stage, `<leader>hr` reset, `<leader>hb` blame line, `<leader>tb` inline blame |
| aerial.nvim | Symbol outline, built on tree-sitter | `<leader>o` toggle |
| nvim-treesitter | Syntax highlighting | |

The tree-sitter grammars are prebuilt by Nix, `:TSInstall` is not used. To highlight
another language add `p.<name>` to the `withPlugins` list in `neovim.nix`. Neovim
already bundles c, lua, vim, vimdoc, query and markdown.

The colorscheme tweaks are applied in `init.lua` rather than through the theme's
`override` option, because the theme caches its highlights in
`~/.cache/nvim/monokai-pro-classic.json` and does not notice changes to that option.

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
