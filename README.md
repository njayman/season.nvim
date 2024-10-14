# season.nvim

## Table of content

- [season.nvim](#seasonnvim)
  - [Features](#features)
  - [To-do](#to-do)
  - [Installation](#installation)
    - [Using lazy.nvim](#using-lazynvim)
    - [Using Vim-Plug](#using-vim-plug)
  - [Setup](#setup)
  - [Configuration Options](#configuration-options)
  - [Usage](#usage)
    - [Save a Session](#save-a-session)
    - [Load a Session](#load-a-session)
  - [Key Bindings](#key-bindings)
  - [Session File Location](#session-file-location)
  - [Troubleshooting](#troubleshooting)
  - [Contributions](#contributions)
  - [License](#license)
  - [Acknowledgements](#acknowledgements)

A lightweight Neovim plugin to manage session based on current working directory.

## Features

- Save sessions and load sessions

## To-do

- list sessions

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    'njayman/season.nvim',
    opts = {
        show_notifications = true, -- Enable or disable notifications (default: true)
    }
    config = function()
        require('season')
    end
}
```

### Using Vim-Plug

```vim
Plug 'njayman/season.nvim'
```

## Setup

After installing the plugin, you need to set it up. Add the following configuration in your init.lua (or init.vim):

```lua
require('season').setup({
  show_notifications = true,  -- Enable or disable session messages (default: true)
})
``````

## Configuration Options

- show_notifications (boolean): Set to true to enable notifications when saving/loading sessions. Set to false to disable them. The default value is true.

## Usage

### Save a Session

To save your current session, call the following function in Neovim:

```lua
:lua require('season').save_session()
```

### Load a Session

To load a previously saved session, use:

```lua
:lua require('season').load_session()
```

## Key Bindings

You can create your own keybindings in your init.lua or init.vim file. For example:

```lua
vim.keymap.set('n','<leader>ss', function() require('season').save_session() end, { desc = "Save Session" })

vim.keymap.set('n', '<leader>sl', function() require('season').load_session() end, { desc = "Load Session" })
```

Feel free to customize the key bindings as per your preference.

## Session File Location

Session files are stored in the following directory:

```sh
~/.local/share/nvim/season_sessions/
```

Each session file is named using the hash of the current working directory, making it unique.

## Troubleshooting

If a session does not load or save correctly, ensure that you have write permissions to the session directory. Verify that Neovim has access to the correct directories by checking the output of :echo stdpath('data').

## Contributions

Contributions are welcome! If you find a bug or want to add a feature, feel free to open an issue or submit a pull request.

## License

This plugin is licensed under the MIT License. See the LICENSE file for more details.

## Acknowledgements

Thanks to all the contributors of Neovim and its plugins.
