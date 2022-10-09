#  _____        _                   ____       _
# |  ___|__  __| | ___  _ __ __ _  / ___|  ___| |_ _   _ _ __
# | |_ / _ \/ _` |/ _ \| '__/ _` | \___ \ / _ \ __| | | | '_ \
# |  _|  __/ (_| | (_) | | | (_| |  ___) |  __/ |_| |_| | |_) |
# |_|  \___|\__,_|\___/|_|  \__,_| |____/ \___|\__|\__,_| .__/
#                                                       |_|
# A setup script for Fedora (36)
# https://github.com/gabrbrand/fedora-setup
#
#   ____ ____
#  / ___| __ )    Gabriel Brand
# | |  _|  _ \    https://github.com/gabrbrand
# | |_| | |_) |
#  \____|____/

#!/bin/bash

#Optimize DNF Config
echo "fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True" | sudo tee -a /etc/dnf/dnf.conf

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
sudo dnf -y group upgrade --with-optional Multimedia

#Change Hostname
sudo hostnamectl set-hostname "notebook-gabriel"

#Remove unused applications (Cheese, Connections, Maps, Photos, Rhythmbox, Tour, Videos)
sudo dnf -y remove cheese gnome-connections gnome-maps gnome-photos gnome-tour rhythmbox totem

#Remove unused GNOME Shell Extensions (Background Logo, GNOME Classic)
sudo dnf -y remove gnome-classic-session gnome-shell-extension-background-logo

#Add Flathub remote
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#Enable Flathub remote
flatpak remote-modify --enable flathub

#Install flatpak applications (adw-gtk3, adw-gtk3-dark, Amberol, BlueJ, Clapper, Dialect, Dynamic Wallpaper, Extension Manager, Feeds, Furtherance, Login Manager Settings, Marktext, Poedit, Spotify, Thunderbird, Video Downloader)
flatpak -y install flathub app.drey.Dialect com.github.marktext.marktext com.github.rafostar.Clapper com.github.unrud.VideoDownloader com.lakoliu.Furtherance com.mattjakeman.ExtensionManager com.spotify.Client io.bassi.Amberol io.github.realmazharhussain.GdmSettings me.dusansimic.DynamicWallpaper net.poedit.Poedit org.bluej.BlueJ org.gabmus.gfeeds org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark org.mozilla.Thunderbird

#Enable adw-gtk3 copr repo
sudo dnf -y copr enable nickavem/adw-gtk3

#Add GitHub CLI repo
sudo dnf install 'dnf-command(config-manager)'
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo

#Enable lazygit copr repo
sudo dnf -y copr enable atim/lazygit

#Add Visual Studio Code repo
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update

#Install rpm applications (adw-gtk3, bat, bpytop, cowsay, conky, cronie, duf, Foliate, fortune-mod, GIMP, GitHub CLI, KeePassXC, lazygit, lsd, neofetch, Node.js, plymouth-plugin-script, Tweaks, util-linux-user, vim, Visual Studio Code, zsh)
sudo dnf -y install adw-gtk3 bat bpytop code cowsay conky cronie duf foliate fortune-mod gh gimp gnome-tweaks keepassxc lazygit lsd neofetch nodejs plymouth-plugin-script util-linux-user vim zsh

#Install Anki
version=$(curl --silent "https://api.github.com/repos/ankitects/anki/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
wget -P ~ https://github.com/ankitects/anki/releases/download/$version/anki-$version-linux-qt6.tar.zst
tar xaf ~/anki-$version-linux-qt6.tar.zst
cd ~/anki-$version-linux-qt6
sudo ./install.sh
rm -rf ~/anki-$version-linux-qt6
rm ~/anki-$version-linux-qt6.tar.zst

#Git Configuration
git config --global user.name "Gabriel Brand"
git config --global user.email gabr.brand@gmail.com
git config --global init.defaultBranch main

#Set GitHub CLI aliases
gh alias set rv 'repo view'
gh alias set il 'issue list'
gh alias set iv 'issue view'
gh alias set pl 'pr list'
gh alias set pv 'pr view'

#Install Tutanota
mkdir ~/.Applications
wget -P ~/.Applications https://mail.tutanota.com/desktop/tutanota-desktop-linux.AppImage
chmod +x ~/.Applications/tutanota-desktop-linux.AppImage

#Center new windows, show weekday
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.desktop.interface clock-show-weekday true

#Install Printer and Scanner Drivers (MFC-9142CDN)
mkdir ~/linux-brprinter
wget -P ~/linux-brprinter https://download.brother.com/welcome/dlf006893/linux-brprinter-installer-2.2.3-1.gz
cd ~/linux-brprinter
gunzip linux-brprinter-installer-*.*.*-*.gz
sudo bash linux-brprinter-installer-*.*.*-* MFC-9142CDN
rm -rf ~/linux-brprinter

#Install Firefox GNOME theme
curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash

#Set Plymouth Theme
cd ~
git clone https://github.com/adi1090x/plymouth-themes.git
sudo cp -r ~/plymouth-themes/pack_4/red_loader/ /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R red_loader
rm -rf ~/plymouth-themes

#Add crontab
echo "
55 21 * * * gabriel notify-send \"Ausschalten\" \"Das System schaltet sich automatisch in 5 Minuten ab.\"

00 22 * * * root /usr/sbin/shutdown -h now" | sudo tee -a /etc/crontab

#Create config.conf
#mkdir -p ~/.config/neofetch/
#wget -P ~/.config/neofetch/ https://raw.githubusercontent.com/gabrbrand/dotfiles/main/neofetch/config.conf

#Change shell to zsh
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

#Update .zshrc
#curl https://raw.githubusercontent.com/gabrbrand/dotfiles/main/.zshrc > ~/.zshrc

#Create .p10k.zsh
#wget -P ~ https://raw.githubusercontent.com/gabrbrand/dotfiles/main/.p10k.zsh

#Add dnf aliases
sudo dnf alias add in=install
sudo dnf alias add rm=remove
sudo dnf alias add if=info
sudo dnf alias add se=search

#Set keyboard shortcuts
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/']"

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
