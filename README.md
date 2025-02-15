# Neovim Installation on macOS

## Prerequisites

Ensure you have [Homebrew](https://brew.sh/) installed on your Mac. If not, install it using:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Installation Process

### 1. Install via Homebrew (Recommended)

To install Neovim using Homebrew, run:

```
brew install neovim
```

### 2. Install Neovim editor

```
git clone https://github.com/bhnprksh222/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

### 3. Open Neovim in terminal

```
nvim
```
