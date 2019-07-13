# My vim configuration

This repository hosts my vim configuration. All the code here should be
compatible with vim 8.1+ and neovim 0.4+.

The `vimrc` and the scripts in `ftplugin` and `after` provide options,
autocommands, variables, and command definitions. The files in `autoload`
define some auxiliary functions used to implement custom commands.

# Dependencies

Vim or neovim:
  + Vim 8.1+ with `+jobs`, `+python3`, `+timers`, or
  + neovim 0.4+ with python (`pip install neovim`).

External dependencies (example packages for Arch Linux):
```sh
sudo pacman -S \
    bandit \
    bash-language-server \
    clang \
    fd \
    flake8 \
    gdb \
    julia \
    mypy \
    nodejs \
    proselint \
    python-language-server \
    python-pycodestyle \
    python-pylint \
    r \
    ripgrep \
    screen \
    screen \
    texlive-most \
    yarn \

yay -S \
    ccls \
    groovy-language-server \
    haskell-ide-engine \
    ruby-mdl \
```

# Install

Plugins are handled as submodules. After cloning, initialise them with
```sh
git submodule update --init --recursive
```

The only plugin with a compiled component is [coc.nvim](https://github.com/neoclide/coc.nvim).
After cloning, `cd` to `bundle/coc.nvim` and run
```sh
yarn install --frozen-lockfile
```

# Caveat emptor

* The configuration is tested on terminal vim/neovim on Linux. I have no idea
  whether this works on Windows, MacOS, or on GUI applications like `gvim`.
* Plugins are handled as git submodules.
* The runtime path for plugins is handled with [pathogen](https://github.com/tpope/vim-pathogen).
  I am aware of vim 8.0+ built-in package manager, but Pathogen has some handy
  features that I commonly use, hence I am sticking to it.
* Vim 8 has a nice native terminal integration, but I also use
  [screen](https://github.com/ervandew/screen) because it provides some simple
  and handy helpers for terminal multiplexing.
* Language server features are provided by
  [coc.nvim](https://github.com/neoclide/coc.nvim). While this plugin works
  both with vim and neovim, it works significantly better with neovim.
* The configuration for coc.nvim is defined in the `vimrc` file with the
  `g:coc_user_config`, instead of using the `coc-settings.json` files, because
  I prefer the configuration to be scriptable.
* I use [ALE](https://github.com/w0rp/ale) for linting. While ALE features
  partially overlap with coc.nvim, the latter does not support most of ALE
  linters. Warnings and errors from the language server are collected by
  coc.nvim and passed to ALE for display.
* This configuration does not include any debug integration plugin. Vim 8.0+
  already provides a nice built-in gdb integration (`:help terminal-debug`).
  While I would like a handier integration and support for other debuggers, I
  have not found any that satisfies my needs, so when I need something more
  than `:Termdebug`, I usually perform debugging using external tools, outside
  vim.
* This configuration provides settings and plugins for a lot of languages and,
  to the eyes of a minimalist, it may look a bit excessive. The reason for
  having this amount of variety is due to the fact that I use vim for most of
  my programming activity, I work with different programming languages, and I
  like to have good integrations for all the languages I work with.
* This configuration is for my personal use. Therefore, differently than all my
  other repositories on GitHub, I do not accept contributions here. The issue
  tracker is disabled, and pull requests will be closed and locked
  automatically.

# License

The content of this repository is available under the MIT license.
