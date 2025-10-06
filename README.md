# Installation

 ## Sudo

> [!NOTE]
> Login as root

```
apt install sudo
```
```
usermod -aG sudo konrad
```
```
reboot
```

## Dotfiles

```
git clone https://github.com/gascko/Dotfiles.git ~/
```

## Packages

```
xargs sudo apt -y install < ~/Dotfiles/packages
```

 ## Network

```
managed=true
```

> /etc/NetworkManager/NetworkManager.conf

## Neovim

```
mkdir -p .config/nvim
```
```
git clone https://github.com/neovim/neovim ~/.config/nvim/
```
```
cd .config/nvim/neovim
```
```
make CMAKE_BUILD_TYPE=RelWithDebInfo
```
```
sudo make install
```
```
cp init.lua ~/.config/nvim/init.lua
```

### Plugins

```
mkdir -p ~/.config/nvim/pack/lspconfig/start/
```
```
mkdir -p ~/.config/nvim/pack/LuaSnip/start/
```
```
mkdir -p ~/.config/nvim/pack/cmp/start/
```
```
mkdir -p ~/.config/nvim/pack/cmp_luasnip/start/
```

```
git clone https://github.com/neovim/nvim-lspconfig  ~/.config/nvim/pack/lspconfig/start/
```
```
git clone https://github.com/L3MON4D3/LuaSnip.git ~/.config/nvim/pack/LuaSnip/start/
```
```
git clone https://github.com/hrsh7th/cmp-buffer.git ~/.config/nvim/pack/cmp/start/
```
```
git clone https://github.com/hrsh7th/cmp-cmdline.git ~/.config/nvim/pack/cmp/start/
```
```
git clone https://github.com/hrsh7th/cmp-nvim-lsp.git ~/.config/nvim/pack/cmp/start/
```
```
git clone https://github.com/hrsh7th/cmp-path.git ~/.config/nvim/pack/cmp/start/
```
```
git clone https://github.com/hrsh7th/nvim-cmp.git ~/.config/nvim/pack/cmp/start/
```
```
git clone https://github.com/saadparwaiz1/cmp_luasnip.git ~/.config/nvim/pack/cmp_luasnip/start/
```

## Zsh

```
chsh -s /usr/bin/zsh
```

## Suckless

```
mkdir .config/suckless
```
```
git clone https://git.suckless.org/dmenu ~/.config/suckless
```
```
git clone https://git.suckless.org/dwm ~/.config/suckless
```
```
git clone https://git.suckless.org/slock ~/.config/suckless
```
```
cp ~/Dotfiles/dwm.c ~/.config/suckless/dwm/
```
```
cp ~/Dotfiles/config.h ~/.config/suckless/dwm/
```
```
cp -r ~/Dotfiles/scripts/ ~/.config/suckless/dwm/
```

> [!NOTE]
> sudo make install for all

## Touchpad

```
sudo cp ~/Dotfiles/40-libinput.conf /etc/X11/xorg.conf.d/40-libinput.conf
```

## Firewall

```
sudo ufw enable
```
```
sudo ufw default deny incoming
```
```
sudo ufw default allow outgoing
```
```
sudo ufw allow DNS
```
```
sudo ufw allow CUPS
```

## GRUB

```
set GRUB_TIMEOUT=0
```

> /etc/default/grub

```
sudo update-grub2
```

## Tutanota

```
sudo wget https://app.tuta.com/desktop/tutanota-desktop-linux.AppImage -O /usr/bin/tutanota.AppImage
```
```
sudo chmod +x /usr/bin/tutanota.AppImage
```
