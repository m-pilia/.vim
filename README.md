# My Vim/Neovim configuration
[![Checks](https://github.com/m-pilia/.vim/workflows/Checks/badge.svg)](https://github.com/m-pilia/.vim/actions/workflows/checks.yml)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/m-pilia/.vim/blob/master/LICENSE)

This repository hosts my Vim configuration. All the code here should be
compatible with Neovim 0.11.

The `vimrc` and the scripts in `ftplugin` and `after` provide options,
autocommands, variables, and command definitions. The files in `autoload`
define some auxiliary functions used to implement custom commands.

# Dependencies

Neovim 0.11 with python (`pip install neovim`).

Vim compatibility is no longer provided for most plugins. For the last fully
compatible version see the `vim-compatible` branch.

On Windows/WSL, having [win32yank.exe](https://github.com/equalsraf/win32yank)
in the Windows PATH makes clipboard support work out of the box in neovim.

Copyq can be used as a clipboard provider with the following configuration:
```viml
let g:clipboard = {
\   'name': 'copyq',
\   'copy': {
\       '+': ['bash', '-c', 'copyq add - && copyq select 0'],
\   },
\   'paste': {
\       '+': ['copyq', 'clipboard'],
\       '*': ['copyq', 'selection'],
\   },
\   'cache_enabled': 1,
\ }
```

External dependencies (example packages for Arch Linux):
```sh
sudo pacman -S \
    clang \
    fd \
    gdb \
    lua-language-server \
    nodejs \
    proselint \
    pyright \
    python-pylint \
    python-pynvim \
    python-rope \
    qt6-languageserver \
    ripgrep \
    rust-analyzer \
    shellcheck \
    texlive-most \
    vint \
    yarn \

yay -S \
    bibclean \
    cmake-lint \
    diagnostic-languageserver \
    gitlint \
    vim-language-server \

```

# Caveat emptor

* The configuration is tested on terminal Neovim on Linux. I have no idea
  whether this works on Windows, MacOS, or on GUI applications.
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
