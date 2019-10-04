# My vim configuration
[![Travis CI Build Status](https://travis-ci.org/m-pilia/.vim.svg?branch=master)](https://travis-ci.org/m-pilia/.vim)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/m-pilia/.vim/blob/master/LICENSE)

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
    languagetool \
    mypy \
    nodejs \
    proselint \
    python-language-server \
    python-pycodestyle \
    python-pylint \
    r \
    ripgrep \
    screen \
    texlive-most \
    vint \
    yarn \

yay -S \
    bibclean \
    ccls \
    cmake-lint \
    gitlint \
    groovy-language-server \
    haskell-ide-engine \
    pyls-mypy \
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
  I am aware of vim 8.0+ built-in package manager, but pathogen has some handy
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
* If you are new to vim, my advice is to not blindly clone and use this as
  your configuration. Many things here work for me but may not work very well
  for you. Many others are likely beyond your current knowledge. The best way
  to go is to build your own configuration from scratch. Using someone else's
  configuration as a starting point is likely going to be suboptimal. You are
  welcome to take inspiration or re-use pieces of code from here, but as a rule
  of thumb you should never put something in your configuration if you do not
  know exactly what it does and how it works.

# License

The content of this repository is available under the MIT license.
