# TermHelp - the help you always knew you needed

TermHelp takes a text prompt and turns it into a command. For example, `:TermHelp find command to search three levels deep for Makefile`
will insert this in the current terminal window:

```bash
$ find . -maxdepth 3 -name "Makefile"
```

### Sidenote

This plugin assumes you have a terminal open inside of NeoVim, which you can do by default with `:term`.
I suggest using [vim-termhere](https://github.com/TamaMcGlinn/vim-termhere) so you can have an easy mapping for opening split terminals,
and so the suggested terminal-buffer-only mappings below work.

## Usage

Aside from `:TermHelp [instructions]`, you can also select a failed command and ask for help - with this visual selection active:

```bash
$ find . type f -iname Makefile
find: ‘type’: No such file or directory
find: ‘f’: No such file or directory
```

Doing `:Chat terminal_correction` will output the fixed command. You can also specify addition instructions at the end of this,
e.g. `:Chat terminal_correction search for the CMake defining file instead` gives:

```bash
find . -type f -iname CMakeLists.txt
```

## Examples

!["Animated gif of terminal where user types in wrong find command and then corrects it with Chat terminal_correction twice"](https://i.imgur.com/zkuC0o3.gif)

Note the typo 'zstsd' - it knows we mean zstd:

!["Animated gif of terminal where user generates a complicated tar command from a text prompt"](https://i.imgur.com/eWvawLx.gif)

![happy man on retro poster with the slogan "Thinking now optional"](https://i.imgur.com/JgAdujk.png)

## Installation

You need [CodeGPT.nvim](https://github.com/dpayne/CodeGPT.nvim), to be loaded after nvim-termhelp.

### Using vim-plug

Add the following line to your init.vim or init.lua file within the plug call block:

```vim
Plug 'TamaMcGlinn/nvim-termhelp'
Plug 'dpayne/CodeGPT.nvim'
```

Then, run :PlugInstall in NeoVim to install the plugin.

### Using lazy.nvim

In your init.lua, add the following snippet:

```lua
require("lazy").setup({
    -- Load 'nvim-termhelp' first
    { "TamaMcGlinn/nvim-termhelp" },
    -- Then load 'CodeGPT.nvim'
    {
        "dpayne/CodeGPT.nvim",
        config = function()
            -- Configuration for CodeGPT.nvim if needed
            -- For example, you might want to set some default options or key mappings for CodeGPT
            require('codegpt').setup({
                -- your configuration here
            })
        end,
        -- This ensures CodeGPT.nvim loads after nvim-termhelp has been loaded
        after = "nvim-termhelp",
    },
})
```

### Using Pathogen

First, navigate to your Pathogen bundle directory, usually ~/.config/nvim/bundle. Then, clone the repository:

```bash
cd ~/.config/nvim/bundle
git clone https://github.com/TamaMcGlinn/nvim-termhelp.git 01-nvim-termhelp
git clone https://github.com/dpayne/CodeGPT.nvim.git 02-CodeGPT.nvim
```

Pathogen should load the plugin automatically the next time you start NeoVim.

### Using dein.vim

Add the following to your init.vim or init.lua in the dein block:

```vim
call dein#add('TamaMcGlinn/nvim-termhelp')
call dein#add('dpayne/CodeGPT.nvim', {'depends': 'nvim-termhelp'})
```

### Using packer.nvim

In your init.lua, add:

```lua
use { 'TamaMcGlinn/nvim-termhelp', }
use {
    'dpayne/CodeGPT.nvim',
    after = 'nvim-termhelp', -- Ensure CodeGPT.nvim loads after nvim-termhelp
    config = function()
      -- Configuration for CodeGPT.nvim here
      require('codegpt').setup({
        -- your configuration here
      })
    end
}
```

### Other Plugin Managers

If you are using a different plugin manager, please send me a PR adding the instructions for this plugin; refer to its documentation for instructions on adding plugins. The general approach involves adding the plugin's git repository URL (https://github.com/TamaMcGlinn/nvim-termhelp) to your plugin manager's configuration file or command.

## Configuration

I can recommend these mappings for your vimrc:

```vim
augroup termhelp
    autocmd FileType terminal nnoremap <buffer> <Leader>n :TermHelp 
    autocmd FileType terminal vnoremap <buffer> <Leader>n :Chat terminal_correction
    autocmd FileType terminal vnoremap <buffer> <Leader>nn :Chat terminal_correction<CR>
augroup END
```

or in lua:

```lua
vim.api.nvim_command([[
augroup termhelp
    autocmd FileType terminal nnoremap <buffer> <Leader>n :TermHelp<CR>
    autocmd FileType terminal vnoremap <buffer> <Leader>n :Chat terminal_correction<CR>
    autocmd FileType terminal vnoremap <buffer> <Leader>nn :Chat terminal_correction<CR>
augroup END
]])
```

Note that the terminal filetype doesn't work by default without using
[vim-termhere](https://github.com/TamaMcGlinn/vim-termhere), because Justin thinks the empty string is a more sensible default
for terminal buffers. See [https://github.com/neovim/neovim/issues/4465](https://github.com/neovim/neovim/issues/4465).

You can just use regular nnoremap to define it in all buffers:

```vim
nnoremap <Leader>n :TermHelp 
vnoremap <Leader>n :Chat terminal_correction 
vnoremap <Leader>nn :Chat terminal_correction<CR>
```

### Stop worrying already

You should absolutely not set `g:termhelp_learn_to_stop_worrying = v:true`. This automatically runs the command generated,
so you don't have time to check if the resulting command bricks your machine.
Next, definitely don't run `:TermHelp delete all files on the machine`.

!["Koala destroying buildings with sudo rm rf /"](https://i.imgur.com/ncTWXEm.gif)

Have fun good luck DON'T PANIC!
