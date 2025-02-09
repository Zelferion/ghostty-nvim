# Ghostty.nvim

A Neovim colorscheme plugin that automatically syncs with your Ghostty terminal theme.

It sucks without treesitter

## About

This plugin reads your Ghostty theme configuration ("in /usr/share/ghostty/themes/") and applies it to Neovim's syntax highlighting, ensuring your editor's colors match your terminal theme perfectly.

Normal bg = "NONE" so it will match terminal bg even if you specified it separatly.
Normal fg applies from theme.

## Features

- 🔄 Automatically reads and applies your current Ghostty theme
- 🎨 Supports both basic Vim syntax highlighting and Treesitter
- ⚡ Quick theme reloading with a keymap
- 🛠️ Configurable options

## Requirements

- Neovim >= 0.8.0
- Ghostty terminal emulator
- (Optional) nvim-treesitter for enhanced syntax highlighting

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "yourusername/ghostty-nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter", -- optional
    },
    config = function()
        require("ghostty-nvim").setup({
            enabled = true,
            treesitter = true,
            reload_keymap = "<leader>tr"
        })
    end,
}
