# Neovim: only the editor and the tools it calls are installed here. The plugins
# are managed by vim.pack, the Lua configuration lives in ./nvim/init.lua and is
# linked to ~/.config/nvim.
{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    # Not needed by any of the plugins
    withPython3 = false;
    withRuby = false;

    # Clipboard through xclip (XWayland) instead of wl-clipboard: GNOME has no
    # data-control protocol, so every wl-copy / wl-paste call maps a window and
    # takes the keyboard focus, and takes ~100 ms instead of ~10 ms.
    waylandSupport = false;
    extraPackages = [
      pkgs.xclip
      # nvim-treesitter compiles the parsers with it
      pkgs.tree-sitter
    ];

    # ~/.config/nvim is linked below, so don't generate an init.lua there
    sideloadInitLua = true;
  };

  # Link the checkout instead of copying it to the Nix store
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/setup/dotfiles/nix-home-manager/nvim";
}
