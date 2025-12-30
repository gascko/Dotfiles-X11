![](screenshot.png)

# Installation

> [!NOTE]
> Setup installed with [Debian Netinstaller](https://www.debian.org/CD/netinst/)

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

## Packages

```
xargs sudo apt -y install < ~/Dotfiles/packages
```

## Dotfiles

```
git clone https://github.com/gascko/Dotfiles.git ~/
```
```
cp ~/Dotfiles/.* ~/
```

## Pinning

```
echo "deb http://deb.debian.org/debian testing main contrib non-free" | sudo tee -a /etc/apt/sources.list
```
```
sudo cp ~/Dotfiles/preferences /etc/apt/preferences
```
```
sudo apt update
```

> [!NOTE]
> Check Release Name of **Stable** and **Testing** [Debian Release](https://www.debian.org/releases/) 

```
xargs sudo apt -y install -t forky < ~/Dotfiles/pinning
```

## Network

```
managed=true
```

> /etc/NetworkManager/NetworkManager.conf

## Neovim

```
mkdir -p ~/.local/share/nvim/site/pack/deps/start
```
```
git clone https://github.com/nvim-mini/mini.deps ~/.local/share/nvim/site/pack/deps/start/mini.deps
```
cp init.lua ~/.config/nvim/init.lua
```

## Suckless

```
mkdir .config/suckless
```
```
git clone https://git.suckless.org/dmenu ~/.config/suckless/dmenu
```
```
git clone https://git.suckless.org/dwm ~/.config/suckless/dwm
```
```
git clone https://git.suckless.org/slock ~/.config/suckless/slock
```
```
cp ~/Dotfiles/dwm.c ~/.config/suckless/dwm/
```
```
cp ~/Dotfiles/config_dwm.h ~/.config/suckless/dwm/config.h
```
```
cp -r ~/Dotfiles/scripts/ ~/.config/suckless/dwm/
```
```
cp ~/Dotfiles/config_dmenu.h ~/.config/suckless/dmenu/config.h
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

## Grub

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
