# My Vim configuration
[![Travis CI Build Status](https://travis-ci.org/m-pilia/.vim.svg?branch=master)](https://travis-ci.org/m-pilia/.vim)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/m-pilia/.vim/blob/master/LICENSE)

This repository hosts my Vim configuration. All the code here should be
compatible with Vim 8.1+ and Neovim 0.4+.

The `vimrc` and the scripts in `ftplugin` and `after` provide options,
autocommands, variables, and command definitions. The files in `autoload`
define some auxiliary functions used to implement custom commands.

# Dependencies

Vim or Neovim:
  + Vim 8.1+ with `+jobs`, `+python3`, `+timers`, `+textprop`, or
  + Neovim 0.5+ with python (`pip install neovim`).

External dependencies (example packages for Arch Linux):
```sh
sudo pacman -S \
    bandit \
    bash-language-server \
    ccls \
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
    python-pynvim \
    python-rope \
    r \
    ripgrep \
    texlab \
    texlive-most \
    vint \
    xclip \
    yarn \

yay -S \
    bibclean \
    cmake-language-server \
    cmake-lint \
    gitlint \
    groovy-language-server-git \
    haskell-ide-engine \
    pyls-mypy \
    ruby-mdl \
    shellcheck-static \

```

On Windows/WSL, having [win32yank.exe](https://github.com/equalsraf/win32yank)
in the Windows PATH makes clipboard support work out of the box in neovim.

# Install

Plugins are handled as submodules. After cloning, initialise them with
```sh
git submodule update --init --recursive
```

# Caveat emptor

* The configuration is tested on terminal Vim/Neovim on Linux. I have no idea
  whether this works on Windows, MacOS, or on GUI applications like `gvim`.
* Plugins are handled as git submodules.
* The runtime path for plugins is handled with [pathogen](https://github.com/tpope/vim-pathogen).
  I am aware of Vim 8.0+ built-in package manager, but pathogen has some handy
  features that I commonly use, hence I am sticking to it.
* Language server features are provided by
  [coc.nvim](https://github.com/neoclide/coc.nvim). While this plugin works
  both with Vim and Neovim, it works significantly better with Neovim.
* The configuration for coc.nvim is defined in the `vimrc` file with the
  `g:coc_user_config`, instead of using the `coc-settings.json` files, because
  I prefer the configuration to be scriptable.
* This configuration does not include any debug integration plugin. Vim 8.0+
  already provides a nice built-in gdb integration (`:help terminal-debug`).
  While I would like a handier integration and support for other debuggers, I
  have not found any that satisfies my needs, so when I need anything more
  than `:Termdebug`, I usually perform debugging using external tools, outside
  Vim.
* This configuration is for my personal use. Therefore, differently than all my
  other repositories on GitHub, I do not accept contributions here. The issue
  tracker is disabled, and pull requests will be closed and locked
  automatically.
* The `master` branch contains "stable" commits, i.e. pieces of configuration
  that, after some battle testing, I find to be satisfactory enough. The
  `develop` branch contains "experimental" commits that I want to try more
  extensively in my daily usage of Vim before merging them to master. Note that
  the commits in the `develop` branch that are not already merged to `master`
  may be amended, in case their code turns out to be faulty, since keeping a
  clean history is a top priority for this repository. The history of the
  `master` branch, on the other hand, is never rewritten.
* If you are new to Vim, my advice is to not blindly clone and use this as
  your configuration. Many things here work for me but may not work very well
  for you. Many others are likely beyond your current knowledge. The best way
  to go is to build your own configuration from scratch. Using someone else's
  configuration as a starting point is likely going to be suboptimal. You are
  welcome to take inspiration or re-use pieces of code from here, but as a rule
  of thumb you should never put something in your configuration if you do not
  know exactly what it does and how it works.

# License

The content of this repository is available under the MIT license.
