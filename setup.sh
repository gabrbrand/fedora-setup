#  _____        _                   ____       _
# |  ___|__  __| | ___  _ __ __ _  / ___|  ___| |_ _   _ _ __
# | |_ / _ \/ _` |/ _ \| '__/ _` | \___ \ / _ \ __| | | | '_ \
# |  _|  __/ (_| | (_) | | | (_| |  ___) |  __/ |_| |_| | |_) |
# |_|  \___|\__,_|\___/|_|  \__,_| |____/ \___|\__|\__,_| .__/
#                                                       |_|
# A setup script for Fedora (37)
# https://github.com/gabrbrand/fedora-setup
#
#   ____ ____
#  / ___| __ )    Gabriel Brand
# | |  _|  _ \    https://github.com/gabrbrand
# | |_| | |_) |
#  \____|____/

#!/bin/bash

# Optimize DNF Config
echo 'fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True' | sudo tee -a /etc/dnf/dnf.conf

# Install Updates
sudo dnf -y upgrade

# Enable the RPM Fusion repositories
sudo dnf -y install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Install plugins for playing movies and music
sudo dnf -y install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf -y install lame\* --exclude=lame-devel
sudo dnf -y group upgrade --with-optional Multimedia

# Change Hostname
sudo hostnamectl set-hostname 'desktop-gabriel'

# Remove unused applications
sudo dnf -y remove cheese gnome-connections gnome-maps gnome-photos gnome-tour rhythmbox totem

# Remove unused GNOME Shell Extensions
sudo dnf -y remove gnome-classic-session gnome-shell-extension-background-logo

# Add Flathub remote
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Enable Flathub remote
flatpak remote-modify --enable flathub

# Install flatpak applications
flatpak -y install flathub app.drey.Dialect com.github.marktext.marktext com.github.rafostar.Clapper com.github.unrud.VideoDownloader com.lakoliu.Furtherance com.mattjakeman.ExtensionManager com.spotify.Client io.bassi.Amberol io.github.realmazharhussain.GdmSettings me.dusansimic.DynamicWallpaper net.poedit.Poedit org.bluej.BlueJ org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark org.mozilla.Thunderbird

# Enable adw-gtk3 copr repo
sudo dnf -y copr enable nickavem/adw-gtk3

# Add GitHub CLI repo
sudo dnf install 'dnf-command(config-manager)'
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo

# Install Third Party Repositories
sudo dnf -y install fedora-workstation-repositories

# Enable the Google Chrome repo
sudo dnf -y config-manager --set-enabled google-chrome

# Enable lazygit copr repo
sudo dnf -y copr enable atim/lazygit

# Install rpm applications
sudo dnf -y install adw-gtk3 bat gh gimp gnome-tweaks google-chrome-stable grub-customizer keepassxc lazygit lsd neofetch plymouth-plugin-script vim zsh

# Install Anki
ANKI_VERSION=$(curl --silent "https://api.github.com/repos/ankitects/anki/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
wget -P ~ https://github.com/ankitects/anki/releases/download/$ANKI_VERSION/anki-$ANKI_VERSION-linux-qt6.tar.zst
tar xaf ~/anki-$ANKI_VERSION-linux-qt6.tar.zst
cd ~/anki-$ANKI_VERSION-linux-qt6
sudo ./install.sh
cd ~
rm -rf ~/anki-$ANKI_VERSION-linux-qt6
rm ~/anki-$ANKI_VERSION-linux-qt6.tar.zst

# Install chezmoi
CHEZMOI_GITHUB_RELEASE_VERSION=$(curl --silent "https://api.github.com/repos/twpayne/chezmoi/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
CHEZMOI_VERSION=$(echo $CHEZMOI_GITHUB_RELEASE_VERSION | sed 's/v//')
wget -P ~ https://github.com/twpayne/chezmoi/releases/download/$CHEZMOI_GITHUB_RELEASE_VERSION/chezmoi-$CHEZMOI_VERSION-x86_64.rpm
sudo rpm -ivh ~/chezmoi-$CHEZMOI_VERSION-x86_64.rpm
rm ~/chezmoi-$CHEZMOI_VERSION-x86_64.rpm

# Install Printer and Scanner Drivers (MFC-9142CDN)
mkdir ~/linux-brprinter
wget -P ~/linux-brprinter https://download.brother.com/welcome/dlf006893/linux-brprinter-installer-2.2.3-1.gz
cd ~/linux-brprinter
gunzip linux-brprinter-installer-2.2.3-1.gz
sudo bash linux-brprinter-installer-2.2.3-1 MFC-9142CDN
cd ~
rm -rf ~/linux-brprinter

# Install Tutanota
mkdir ~/.Applications
wget -P ~/.Applications https://mail.tutanota.com/desktop/tutanota-desktop-linux.AppImage
chmod +x ~/.Applications/tutanota-desktop-linux.AppImage

# Add dnf aliases
sudo dnf alias add in=install
sudo dnf alias add rm=remove
sudo dnf alias add if=info
sudo dnf alias add se=search

# Show Password Asterisks in Terminal
sudo sed -i 's/Defaults    env_reset/Defaults    env_reset,pwfeedback/' /etc/sudoers

# Set Plymouth Theme
cd ~
git clone https://github.com/adi1090x/plymouth-themes.git
sudo cp -r ~/plymouth-themes/pack_3/hud_space/ /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R hud_space
rm -rf ~/plymouth-themes

# Git Configuration
git config --global user.name 'Gabriel Brand'
git config --global user.email gabr.brand@gmail.com
git config --global init.defaultBranch main

# Download background
cd ~/.config
wget -O background https://unsplash.com/photos/WMPmZN_1VE8/download\?ixid\=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjc2MTM5MTUw\&force\=true
cd ~

# Install Fluent icon theme
cd ~
git clone https://github.com/vinceliuice/Fluent-icon-theme.git
cd ~/Fluent-icon-theme
./install.sh -r
cd ~
rm -rf ~/Colloid-icon-theme

# Center new windows, set themes + background
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Fluent-dark'
gsettings set org.gnome.desktop.background picture-uri file:///home/gabriel/.config/background
gsettings set org.gnome.desktop.background picture-uri-dark file:///home/gabriel/.config/background

# Change shell to zsh
chsh -s $(which zsh)

# Install Oh My Zsh!
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install MesloLGS NF
mkdir -p ~/.local/share/fonts
wget -P ~/.local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
fc-cache -f -v

# Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Apply dotfiles
GITHUB_USERNAME='gabrbrand'
chezmoi init --apply $GITHUB_USERNAME

# Set keyboard shortcuts
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Dateien'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'nautilus'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>E'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Control><Alt>T'
