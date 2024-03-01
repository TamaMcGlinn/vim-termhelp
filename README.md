## TermHelp

TermHelp takes a text prompt and turns it into a command. For example, `:TermHelp find command to search three levels deep for Makefile`
will insert this:

```
$ find . -maxdepth 3 -name "Makefile"
```

![happy man on retro poster with the slogan "Thinking now optional"](https://i.imgur.com/JgAdujk.png)

You can also select a failed command and ask for help - with this visual selection active:

```
$ find . type f -iname Makefile
find: ‘type’: No such file or directory
find: ‘f’: No such file or directory
```

doing `:Chat terminal_correction` will output a fixed command.

## Examples

[TODO insert some gifs]

## Installation

### Using vim-plug

Add the following line to your init.vim or init.lua file within the plug call block:

```vim
Plug 'TamaMcGlinn/nvim-termhelp'
```

Then, run :PlugInstall in NeoVim to install the plugin.

### Using lazy.nvim

In your init.lua, add the following snippet:

```lua
require('lazy').setup({
  {'TamaMcGlinn/nvim-termhelp'}
})
```

### Using Pathogen

First, navigate to your Pathogen bundle directory, usually ~/.config/nvim/bundle. Then, clone the repository:

```bash
cd ~/.config/nvim/bundle
git clone https://github.com/TamaMcGlinn/nvim-termhelp.git
```

Pathogen should load the plugin automatically the next time you start NeoVim.

### Using dein.vim

Add the following to your init.vim or init.lua in the dein block:

```vim
call dein#add('TamaMcGlinn/nvim-termhelp')
```

Or, if you're using Lua:

```lua
require'dein'.setup({
  {'TamaMcGlinn/nvim-termhelp'}
})
```

### Using packer.nvim

In your init.lua, add:

```lua
use {'TamaMcGlinn/nvim-termhelp'}
```

### Other Plugin Managers

If you are using a different plugin manager, please send me a PR adding the instructions for this plugin; refer to its documentation for instructions on adding plugins. The general approach involves adding the plugin's git repository URL (https://github.com/TamaMcGlinn/nvim-termhelp) to your plugin manager's configuration file or command.

## Configuration

I can recommend these mappings for your vimrc:

```vim
```

or in lua:

```lua
```
