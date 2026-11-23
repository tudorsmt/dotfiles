-- Linked to ~/.config/nvim by Home Manager (see ../neovim.nix).
-- The plugins are installed by vim.pack, which keeps their revisions in
-- nvim-pack-lock.json next to this file.

vim.g.mapleader = " "

local opt = vim.opt
opt.number = true
opt.cursorline = true
opt.signcolumn = "yes" -- always reserve the gutter so git signs don't shift the text
opt.termguicolors = true
opt.ignorecase = true
opt.smartcase = true
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 5
opt.undofile = true
opt.clipboard = "unnamedplus" -- yank, delete and paste use the system clipboard
opt.autocomplete = true
-- Highlight columns at 80, 100, 120
-- Draw the border after the n-th column, so it matches VSCode behavior
opt.colorcolumn = { 81, 101, 121 }

-- Home and End inside tmux ---------------------------------------------------
-- tmux sends them as ESC [ 1 ~ and ESC [ 4 ~, but tmux.conf sets TERM to
-- xterm-256color, whose terminfo expects ESC O H and ESC O F. Neovim then reads
-- them as the VT220 keys <Find> and <Select> and does nothing; Vim doesn't have
-- this problem. Modified keys (<C-Home>, <S-End>...) arrive correctly.
local home_end_modes = { "n", "i", "x", "s", "o", "c", "t" }
vim.keymap.set(home_end_modes, "<Find>", "<Home>", { desc = "Home (tmux sends <Find>)" })
vim.keymap.set(home_end_modes, "<Select>", "<End>", { desc = "End (tmux sends <Select>)" })

-- Install plugins
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("user_pack_hooks", { clear = true }),
  callback = function(ev)
    local data = ev.data
    -- The parsers have to match the queries of the plugin revision
    if data.spec.name == "nvim-treesitter" and data.kind == "update" then
      if not data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  "https://github.com/loctvl842/monokai-pro.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/stevearc/aerial.nvim",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/RRethy/vim-illuminate",
  "https://github.com/Bekaboo/deadcolumn.nvim",
  "https://github.com/nvim-mini/mini.pairs",
  -- UI plugins
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim'
})

-- Colorscheme --------------------------------------------------------------
-- The "classic" filter of Monokai Pro is the original Monokai palette, which is
-- also what VS Code's Monokai theme is based on.
require("monokai-pro").setup({
  filter = "classic",
  -- VS Code's Monokai has upright comments and keywords
  styles = {
    comment = { italic = false },
    keyword = { italic = false },
  },
})

-- Values taken from VS Code's Monokai where the classic filter differs. They are
-- applied here instead of through the theme's `override` option, because the
-- theme caches its result on disk without noticing changes to that option.
local green, cyan, orange = "#a6e22e", "#66d9ef", "#fd971f"
local color_theme_tweaks = {
  Comment = { fg = "#88846f" },
  LineNr = { fg = "#90908a" },
  CursorLineNr = { fg = "#c2c2bf" },
  CursorLine = { bg = "#3e3d32" },
  -- Color column background
  ColorColumn = { bg = "#464741" },
  ["@punctuation.bracket"] = { fg = "#f8f8f2" },
  ["@function.builtin"] = { fg = cyan },
  ["@variable.builtin"] = { fg = orange }, -- self, this
  -- Markdown
  ["@markup.strong.markdown_inline"] = { fg = cyan },
  ["@markup.italic.markdown_inline"] = { fg = cyan },
  ["@markup.raw.markdown_inline"] = { fg = orange },
  ["@markup.list.markdown"] = { fg = green },
}
for level = 1, 6 do
  color_theme_tweaks["@markup.heading." .. level .. ".markdown"] = { fg = green, bold = true }
  color_theme_tweaks["@markup.heading." .. level .. ".marker.markdown"] = { fg = green, bold = true }
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("user_colorscheme_tweaks", { clear = true }),
  pattern = "monokai-pro",
  callback = function()
    for group, attrs in pairs(color_theme_tweaks) do
      local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
      vim.api.nvim_set_hl(0, group, vim.tbl_extend("force", hl, attrs))
    end
  end,
})

-- The same disk cache is not invalidated when the plugin is updated, so start
-- from a clean one. Rebuilding the theme costs nothing measurable.
pcall(function()
  require("monokai-pro.theme").clear_cache()
end)

-- Newer than v2.1.4, the plain `monokai-pro` scheme resets the filter to "pro"
-- and ignores the one above. Every filter has a scheme of its own.
vim.cmd.colorscheme("monokai-pro-classic")

-- Tree-sitter ----------------------------------------------------------------
-- nvim-treesitter compiles the parsers on the first start, then this is a no-op.
-- Neovim already bundles c, lua, vim, vimdoc, query and markdown.
require("nvim-treesitter").install({
  "bash", "python", "yaml", "json", "toml", "nix",
  "gitcommit", "git_rebase", "diff", "regex",
})

-- Highlight every filetype that has a parser.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
    end
  end,
})

-- Git gutter -----------------------------------------------------------------
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = require("gitsigns")

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- Keep the built-in behaviour of ]c / [c inside diff windows
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end, "Next git hunk")
    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gs.nav_hunk("prev")
      end
    end, "Previous git hunk")

    map("n", "<leader>hp", gs.preview_hunk, "Preview git hunk")
    map("n", "<leader>hs", gs.stage_hunk, "Stage git hunk")
    map("n", "<leader>hr", gs.reset_hunk, "Reset git hunk")
    map("v", "<leader>hs", function()
      gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Stage selected lines")
    map("v", "<leader>hr", function()
      gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Reset selected lines")
    map("n", "<leader>hb", function()
      gs.blame_line({ full = true })
    end, "Blame line")
    map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle inline blame")
    map({ "o", "x" }, "ih", gs.select_hunk, "Select git hunk")
  end,
})

-- Symbol outline -------------------------------------------------------------
-- Uses the tree-sitter parsers; classes, functions, headings, YAML mappings...
require("aerial").setup({
  nerd_font = true,
  show_guides = true,
})
vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>", { desc = "Symbol outline" })

-- Load the mini.pairs plugin
require('mini.pairs').setup()
-- Load statusline
require('lualine').setup()
