<!-- @format -->

# Anton's dotfiles

These are my dotfiles for zsh, i3, neovim, and kitty. All stored using the GNU stow applet.

To install these dotfiles and use them as your own, simply install GNU stow:

```bash
$ sudo pacman -S stow
```

clone this repository to your home directory:

```bash
$ git clone --depth=1 https://github.com/antonw51/dotfiles ~/dotfiles
```

then use the `stow` command:

```bash
$ stow ~/dotfiles
```

## Oh-my-zsh

The zsh config present here relies on oh-my-zsh, you can install that with curl:

```bash
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Then install the dependencies:

- zsh-syntax-highlighting:

```bash
$ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

- zsh-completion:

```bash
$ git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
```
