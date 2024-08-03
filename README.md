# 👀 eyeliner.nvim

Move faster with unique `f`/`F` indicators for each word on the line. Like [quick-scope](https://github.com/unblevable/quick-scope), but in Lua.

<!-- ![demo](https://user-images.githubusercontent.com/40512164/181354222-b4487f22-e947-468a-8739-653074e2c012.gif) -->

https://user-images.githubusercontent.com/40512164/178066018-0d3fa234-a5b5-4a41-a340-430e8c4c2739.mov

The orange letters indicate the unique letter in the word that you can jump to with `f`/`F` right away.
Blue letters indicate that there is no unique letter in the word, but you can get to it with `f`/`F` and then a repeat with `;`.


## 📦 Installation
Requirement: Neovim >= 0.7.0

Using [vim-plug](https://github.com/junegunn/vim-plug):
```vim
Plug 'jinh0/eyeliner.nvim'
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):
```lua
use 'jinh0/eyeliner.nvim'
```

## ⚙️ Configuration

Default values (in lazy.nvim):
```lua
{
  'jinh0/eyeliner.nvim',
  config = function()
    require'eyeliner'.setup {
      -- show highlights only after keypress
      highlight_on_key = true,

      -- dim all other characters if set to true (recommended!)
      dim = false,             

      -- set the maximum number of characters eyeliner.nvim will check from
      -- your current cursor position; this is useful if you are dealing with
      -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
      max_length = 9999        

      -- filetypes for which eyeliner should be disabled;
      -- e.g., to disable on help files:
      -- disable_filetypes = {"help"}
      disable_filetypes = {},

      -- buftypes for which eyeliner should be disabled
      -- e.g., disable_buftypes = {"nofile"}
      disable_buftypes = {},
    }
  end
}
```

## ✨ Show highlights only after keypress
If you prefer to have eyeliner's highlights shown only after you press `f`/`F`/`t`/`T`, set `highlight_on_key` to `true` in the setup function.

In Lua:
```lua
use {
  'jinh0/eyeliner.nvim',
  config = function()
    require'eyeliner'.setup {
      highlight_on_key = true
    }
  end
}
```

<details>
<summary>Demo</summary>

https://user-images.githubusercontent.com/40512164/180614964-c1a63671-7fa8-438d-ad4f-c90079adf098.mov

</details>

### Highlight + Dim

When using `highlight_on_key`, you may want to dim the rest of the characters since they are unimportant. You can do this with the `dim` option:

```lua
require'eyeliner'.setup {
  highlight_on_key = true, -- this must be set to true for dimming to work!
  dim = true,
}
```

https://user-images.githubusercontent.com/40512164/211218941-ac7df0b6-67ea-4aa2-af9a-110ef9e3091f.mov


## 🖌 Customize highlight colors
You can customize the highlight colors and styles with the `EyelinerPrimary` and `EyelinerSecondary` highlight groups.

For instance, if you wanted to make eyeliner.nvim more subtle by only using bold and underline, with no color,

In Vimscript:
```vim
highlight EyelinerPrimary gui=underline,bold
highlight EyelinerSecondary gui=underline
```

In Lua:
```lua
vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bold = true, underline = true })
vim.api.nvim_set_hl(0, 'EyelinerSecondary', { underline = true })
```

If you want to set a custom color:

In Vimscript:
```vim
highlight EyelinerPrimary guifg=#000000 gui=underline,bold
highlight EyelinerSecondary guifg=#ffffff gui=underline
```

In Lua:
```lua
vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg='#000000', bold = true, underline = true })
vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg='#ffffff', underline = true })
```

### Update highlights when the colorscheme is changed
In Vimscript:
```vim
autocmd ColorScheme * :highlight EyelinerPrimary ...
```
In Lua:
```lua
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bold = true, underline = true })
  end,
})
```

## Commands
Enable/disable/toggle:
```
:EyelinerEnable
:EyelinerDisable
:EyelinerToggle
```

## Troubleshooting

- To disable eyeliner.nvim on the [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua) plugin, you need to add `nofile` as a disabled buftype to your configuration, i.e., `disable_buftypes = {"nofile"}` and `NvimTree` as a disabled filetype, i.e., `disable_filetypes = {"NvimTree"}`.

