# Neovim: the plugins and tree-sitter grammars are installed here, the Lua
# configuration lives in ./nvim/init.lua.
{ pkgs, ... }:

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
    extraPackages = [ pkgs.xclip ];

    plugins = [
      # Monokai colorscheme, the "classic" filter is VS Code's Monokai palette
      pkgs.vimPlugins.monokai-pro-nvim
      # Git gutter
      pkgs.vimPlugins.gitsigns-nvim
      # Symbol outline, built on tree-sitter
      pkgs.vimPlugins.aerial-nvim
      # Grammars are prebuilt by Nix instead of being compiled by :TSInstall.
      # Neovim already bundles c, lua, vim, vimdoc, query and markdown.
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
        p.bash
        p.python
        p.yaml
        p.json
        p.toml
        p.nix
        p.gitcommit
        p.git_rebase
        p.diff
        p.regex
      ]))
    ];

    initLua = builtins.readFile ./nvim/init.lua;
  };
}
