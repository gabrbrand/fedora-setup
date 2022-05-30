#!/bin/bash

#Optimize DNF Config
echo "fastestmirror=True
max_parallel_downloads=10
defaultyes=True" | sudo tee -a /etc/dnf/dnf.conf

#Install Updates
sudo dnf -y update

#Enable the RPM Fusion repositories
sudo dnf -y install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#Install plugins for playing movies and music
sudo dnf -y install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf -y install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia

#Add Flathub remote
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#Remove Cheese (rpm)
sudo dnf -y remove cheese

#Remove Connections (rpm)
sudo dnf -y remove gnome-connections

#Remove Maps (rpm)
sudo dnf -y remove gnome-maps

#Remove Photos (rpm)
sudo dnf -y remove gnome-photos

#Remove Rhythmbox (rpm)
sudo dnf -y remove rhythmbox

#Remove Tour (rpm)
sudo dnf -y remove gnome-tour

#Remove Videos (rpm)
sudo dnf -y remove totem

#Remove Background Logo and GNOME Classic
sudo dnf -y remove gnome-shell-extension-background-logo
sudo dnf -y remove gnome-classic-session

#Install Amberol (flatpak)
flatpak -y install flathub io.bassi.Amberol

#Install Anki
wget https://github.com/ankitects/anki/releases/download/2.1.52/anki-2.1.52-linux-qt6.tar.zst
cd ~
tar xaf ~/anki-2.1.52-linux-qt6.tar.zst
cd ~/anki-2.1.52-linux-qt6
sudo ./install.sh
cd ~
rm -r ~/anki-2.1.52-linux-qt6
rm ~/anki-2.1.52-linux-qt6.tar.zst

#Install BlueJ (flatpak)
flatpak -y install flathub org.bluej.BlueJ

#Install Clapper (flatpak)
flatpak -y install flathub com.github.rafostar.Clapper

#Install Extension Manager (flatpak)
flatpak -y install flathub com.mattjakeman.ExtensionManager

#Install Feeds (flatpak)
flatpak -y install flathub org.gabmus.gfeeds

#Install Foliate (rpm)
sudo dnf -y install foliate

#Install Furtherance (flatpak)
flatpak -y install flathub com.lakoliu.Furtherance

#Install Geary (rpm)
sudo dnf -y install geary

#Git Configuration
git config --global user.name "Gabriel Brand"
git config --global user.email gabr.brand@gmail.com

#Install GitHub CLI (rpm)
sudo dnf install 'dnf-command(config-manager)'
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf -y install gh
#gh auth login

#Set GitHub CLI aliases
gh alias set rv 'repo view'
gh alias set il 'issue list'
gh alias set iv 'issue view'
gh alias set pl 'pr list'
gh alias set pv 'pr view'

#Install GNU Image Manipulation Program (rpm)
sudo dnf -y install gimp

#Install KeePassXC (rpm)
sudo dnf -y install keepassxc

#Install Marktext (flatpak)
flatpak -y install flathub com.github.marktext.marktext

#Install Poedit (flatpak)
flatpak -y install flathub net.poedit.Poedit

#Install Spotify (flatpak)
flatpak -y install flathub com.spotify.Client

#Install Thunderbird (flatpak)
flatpak -y install flathub org.mozilla.Thunderbird

#Install Tutanota (AppImage)
mkdir ~/.Applications
wget -P ~/.Applications https://mail.tutanota.com/desktop/tutanota-desktop-linux.AppImage
cd ~/.Applications
chmod +x tutanota-desktop-linux.AppImage
cd ~

#Install Tweaks (rpm)
sudo dnf -y install gnome-tweaks
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.interface clock-show-weekday true

#Install Ulauncher (rpm)
sudo dnf -y install ulauncher

#Install Adwaita Dark Ulauncher
mkdir -p ~/.config/ulauncher/user-themes
cd ~/.config/ulauncher/user-themes
git clone https://github.com/gabrbrand/adwaita-dark-ulauncher.git
cd ~

#Download dotfiles
cd ~/fedora-setup/
git clone https://github.com/gabrbrand/dotfiles.git
cd ~

#Configure Ulauncher settings
cp ~/fedora-setup/dotfiles/ulauncher/settings.json ~/.config/ulauncher/settings.json

#Add Ulauncher extensions
cp ~/fedora-setup/dotfiles/ulauncher/extensions.json ~/.config/ulauncher/extensions.json

#Install Visual Studio Code (rpm)
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf -y install code

#Install Printer and Scanner Drivers (MFC-9142CDN)
mkdir ~/linux-brprinter
wget -P ~/linux-brprinter https://download.brother.com/welcome/dlf006893/linux-brprinter-installer-2.2.3-1.gz
cd ~/linux-brprinter
gunzip linux-brprinter-installer-*.*.*-*.gz
sudo bash linux-brprinter-installer-*.*.*-* MFC-9142CDN
cd ~
sudo rm -r ~/linux-brprinter

#Install adw-gtk3
sudo wget -P /usr/share/themes/ https://github.com/lassekongo83/adw-gtk3/releases/download/v1.9/adw-gtk3v1-9.tar.xz
cd /usr/share/themes/
sudo tar xaf adw-gtk3v1-9.tar.xz
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
sudo rm adw-gtk3v1-9.tar.xz
cd ~

#Install Firefox GNOME theme
curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash

#Install Papirus icon theme
wget -qO- https://git.io/papirus-icon-theme-install | sh
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark

#Install Papirus Folders
wget -qO- https://git.io/papirus-folders-install | sh
papirus-folders -C adwaita

#Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

#Install bat
cargo install --locked bat

#Install bpytop (rpm)
sudo dnf -y install bpytop

#Install cowsay
sudo dnf -y install cowsay

#Install cronie (rpm)
sudo dnf -y install cronie

#Add crontab
echo "
55 21 * * * gabriel notify-send \"Power Off\" \"The system will power off automatically in 5 minutes.\"

00 22 * * * root /usr/sbin/shutdown -h now" | sudo tee -a /etc/crontab

#Install fortune-mod
sudo dnf -y install fortune-mod

#Install lazygit (rpm)
sudo dnf copr enable atim/lazygit -y
sudo dnf -y install lazygit

#Install lolcat
sudo dnf -y install lolcat

#Install lsd
cargo install lsd

#Install neofetch (rpm)
sudo dnf -y install neofetch

#Install zsh (rpm)
sudo dnf -y install zsh
sudo dnf -y install util-linux-user
chsh -s $(which zsh)

#Install Oh My Zsh!
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

#Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#Install MesloLGS NF
mkdir -p ~/.local/share/fonts
wget -P ~/.local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
fc-cache -f -v

#Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

#Add .p10k.zsh
cp ~/fedora-setup/dotfiles/.p10k.zsh ~/.p10k.zsh

#Update .zshrc
cp ~/fedora-setup/dotfiles/.zshrc ~/.zshrc

#Add dnf aliases
sudo dnf alias add in=install
sudo dnf alias add rm=remove
sudo dnf alias add if=info
sudo dnf alias add se=search

#Change Hostname
sudo hostnamectl set-hostname "notebook-gabriel"

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

#Remove 'fedora-setup'-folder
sudo rm -r ~/fedora-setup/

#Remove unused folders
rmdir ~/Desktop/ ~/Public/ ~/Templates/
