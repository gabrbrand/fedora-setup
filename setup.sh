#!/bin/bash

#Optimize DNF Config
echo "fastestmirror=True
max_parallel_downloads=10
defaultyes=True" | sudo tee -a /etc/dnf/dnf.conf

#Install Updates
sudo dnf -q -y update

#Remove Cheese (rpm)
sudo dnf -q -y remove cheese

#Remove Connections (rpm)
sudo dnf -q -y remove gnome-connections

#Remove Fedora Media Writer (rpm)
sudo dnf -q -y remove mediawriter

#Remove Maps (rpm)
sudo dnf -q -y remove gnome-maps

#Remove Photos (rpm)
sudo dnf -q -y remove gnome-photos

#Remove Rhythmbox (rpm)
sudo dnf -q -y remove rhythmbox

#Remove Tour (rpm)
sudo dnf -q -y remove gnome-tour

#Remove Videos (rpm)
sudo dnf -q -y remove totem

#Add Flathub remote
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#Git Configuration
git config --global user.name "Gabriel Brand"
git config --global user.email gabr.brand@gmail.com

#Install Anki
cd ~
wget -P ~/Downloads https://github.com/ankitects/anki/releases/download/2.1.50/anki-2.1.50-linux-qt6.tar.zst
sudo dnf -q -y install zstd
tar xaf ~/Downloads/anki-2.1.50-linux-qt6.tar.zst
cd ~/anki-2.1.50-linux-qt6
sudo ./install.sh
cd ~
rm -r ~/anki-2.1.50-linux-qt6
rm ~/Downloads/anki-2.1.50-linux-qt6.tar.zst

#Install BlueJ (flatpak)
flatpak --noninteractive -y install flathub org.bluej.BlueJ

#Install Google Chrome (rpm)
sudo dnf -q -y install google-chrome-stable

#Install Clapper (flatpak)
flatpak --noninteractive -y install flathub com.github.rafostar.Clapper

#Install Extension Manager (flatpak)
flatpak --noninteractive -y install flathub com.mattjakeman.ExtensionManager

#Install Foliate (rpm)
sudo dnf -q -y install foliate

#Install Furtherance (flatpak)
flatpak --noninteractive -y install flathub com.lakoliu.Furtherance

#Install Geary (rpm)
sudo dnf -q -y install geary

#Install GNU Image Manipulation Program (rpm)
sudo dnf -q -y install gimp

#Install KeePassXC (rpm)
sudo dnf -q -y install keepassxc

#Install Marktext (flatpak)
flatpak --noninteractive -y install flathub com.github.marktext.marktext

#Install Poedit (flatpak)
flatpak --noninteractive -y install flathub net.poedit.Poedit

#Install Spotify (flatpak)
flatpak --noninteractive -y install flathub com.spotify.Client

#Install Thunderbird (flatpak)
flatpak --noninteractive -y install flathub org.mozilla.Thunderbird

#Install Tutanota (AppImage)
mkdir ~/.Applications
wget -P ~/.Applications https://mail.tutanota.com/desktop/tutanota-desktop-linux.AppImage

#Install Tweaks (rpm)
sudo dnf -q -y install gnome-tweaks
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.interface clock-show-weekday true

#Install Ulauncher (rpm)
sudo dnf -q -y install ulauncher

#Install Visual Studio Code (rpm)
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf -q -y install code

#Install Adwaita Darkish Ulauncher
mkdir -p ~/.config/ulauncher/user-themes
cd ~/.config/ulauncher/user-themes
git clone https://github.com/shepda/ulauncher-adwaita-darkish.git
cd ~

#Install adw-gtk3
sudo dnf -q -y install ninja-build meson sassc
git clone https://github.com/lassekongo83/adw-gtk3.git
cd ~/adw-gtk3
meson build
sudo ninja -C build install
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
flatpak --noninteractive -y install org.gtk.Gtk3theme.adw-gtk3-dark
cd ~
sudo rm -r ~/adw-gtk3

#Install Papirus icon theme
wget -qO- https://git.io/papirus-icon-theme-install | sh
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark

#Install bpytop (rpm)
sudo dnf -q -y install bpytop

#Install cronie (rpm)
sudo dnf -q -y install cronie

#Install lazygit (rpm)
sudo dnf copr enable atim/lazygit -y
sudo dnf -q -y install lazygit

#Install neofetch (rpm)
sudo dnf -q -y install neofetch

#Install zsh (rpm)
sudo dnf -q -y install zsh
sudo dnf -q -y install util-linux-user
chsh -s $(which zsh)

#Install Oh My Zsh!
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

#Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#Update .zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"\
DEFAULT_USER=$USER/' ~/.zshrc
sed -i 's/plugins=(git)/plugins=(zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

#Add aliases
echo "
#git
alias clone=\"git clone\"
alias push=\"git push\"
alias pull=\"git pull\"
alias commit=\"git commit -m\"
alias add=\"git add --all\"

alias open=\"xdg-open\"
alias shutdown=\"sudo shutdown -h now\"" >> ~/.zshrc

sudo dnf alias add in=install
sudo dnf alias add rm=remove
sudo dnf alias add if=info
sudo dnf alias add se=search

#Set keyboard shortcuts
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Dateien'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'nautilus'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>D'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Firefox'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'firefox'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Super>F'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name 'Terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding '<Control><Alt>T'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ name 'Thunderbird'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ command 'flatpak run org.mozilla.Thunderbird'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ binding '<Super>T'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ name 'Ulauncher'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ command 'ulauncher-toggle'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ binding '<Control>space'

#Install Printer Driver
mkdir ~/Downloads/linux-brprinter
wget -P ~/Downloads/linux-brprinter https://download.brother.com/welcome/dlf006893/linux-brprinter-installer-2.2.3-1.gz
cd ~/Downloads/linux-brprinter
gunzip linux-brprinter-installer-*.*.*-*.gz
sudo bash linux-brprinter-installer-*.*.*-* MFC-9142CDN
cd ~
sudo rm -r ~/Downloads/linux-brprinter
