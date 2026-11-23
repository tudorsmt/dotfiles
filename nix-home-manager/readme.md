# Nix home-manager

After installing nix home manager, link home.nix to

```bash
~/.config/home-manager/home.nix
```

## Neovim

Set up by [neovim.nix](./neovim.nix), which is imported from `home.nix`:

- `neovim.nix` installs Neovim and the tools it calls (xclip, tree-sitter) and links
  [nvim/](./nvim) to `~/.config/nvim`. The link points into this checkout, so a change
  applies after restarting Neovim, without `home-manager switch`.
- [nvim/init.lua](./nvim/init.lua) has the options, key maps and plugin setup.
- The plugins are installed by Neovim's own plugin manager, `vim.pack` (Neovim 0.12+),
  into `~/.local/share/nvim/site/pack/core/opt`. Their revisions are pinned in
  [nvim/nvim-pack-lock.json](./nvim/nvim-pack-lock.json), commit it together with the
  change. To update them run `:lua vim.pack.update()`, read the buffer, then `:write` to
  apply or `:quit` to discard.

The leader key is `<Space>`. Yank, delete and paste use the system clipboard
(`clipboard=unnamedplus`) through xclip, see the note in `neovim.nix`.

| Plugin | What for | Keys |
| --- | --- | --- |
| monokai-pro.nvim | Monokai colors, tuned to match VS Code's Monokai | |
| gitsigns.nvim | Git gutter | `]c` / `[c` next / previous hunk, `<leader>hp` preview, `<leader>hs` stage, `<leader>hr` reset, `<leader>hb` blame line, `<leader>tb` inline blame |
| aerial.nvim | Symbol outline, built on tree-sitter | `<leader>o` toggle |
| nvim-treesitter | Syntax highlighting | |

nvim-treesitter compiles the grammars on the first start, which needs `tree-sitter`, a C
compiler, `tar` and `curl`. To highlight another language add it to the `install()` call
in `init.lua`. Neovim already bundles c, lua, vim, vimdoc, query and markdown.

The colorscheme is loaded as `monokai-pro-classic`. The plain `monokai-pro` scheme resets
the filter to Pro (newer than v2.1.4), whatever `filter` says in `setup()`.

The colorscheme tweaks are applied in `init.lua` rather than through the theme's
`override` option, because the theme caches its highlights in
`~/.cache/nvim/monokai-pro-classic.json` and does not notice changes to that option.

Inside tmux, Home and End arrive as `ESC [ 1 ~` and `ESC [ 4 ~`, which the `tmux-256color`
terminfo entry set in [terminal/.tmux.conf](../terminal/.tmux.conf) describes. With
`TERM=xterm-256color` Neovim reads them as `<Find>` and `<Select>` and does nothing (Vim
doesn't), so `init.lua` maps those two keys to Home and End for panes that still report it.

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
