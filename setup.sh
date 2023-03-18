#  _____        _                   ____       _
# |  ___|__  __| | ___  _ __ __ _  / ___|  ___| |_ _   _ _ __
# | |_ / _ \/ _` |/ _ \| '__/ _` | \___ \ / _ \ __| | | | '_ \
# |  _|  __/ (_| | (_) | | | (_| |  ___) |  __/ |_| |_| | |_) |
# |_|  \___|\__,_|\___/|_|  \__,_| |____/ \___|\__|\__,_| .__/
#                                                       |_|
# A setup script for Fedora (38)
# https://github.com/gabrbrand/fedora-setup
# -> 7 Things You MUST DO After Installing Fedora 36 - TechHut (https://youtu.be/RrRpXs2pkzg)
#
#   ____ ____
#  / ___| __ )    Gabriel Brand
# | |  _|  _ \    https://github.com/gabrbrand
# | |_| | |_) |
#  \____|____/

#!/bin/bash

sudo dnf -y install lolcat &>> ~/setup.log

printf "\n [1/35] Optimize DNF Config...\n" | lolcat
echo "fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True" | sudo tee -a /etc/dnf/dnf.conf &>> ~/setup.log

printf " [2/35] Install Updates...\n" | lolcat
sudo dnf -y upgrade &>> ~/setup.log

printf " [3/35] Enable the RPM Fusion repositories...\n" | lolcat
sudo dnf -y install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm &>> ~/setup.log
sudo dnf -y install \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm &>> ~/setup.log

printf " [4/35] Install plugins for playing movies and music...\n" | lolcat
sudo dnf -y install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel &>> ~/setup.log
sudo dnf -y install lame\* --exclude=lame-devel &>> ~/setup.log
sudo dnf -y group upgrade --with-optional Multimedia &>> ~/setup.log

printf " [5/35] Change Hostname...\n" | lolcat
sudo hostnamectl set-hostname 'desktop-gabriel' &>> ~/setup.log

printf " [6/35] Remove unused applications...\n" | lolcat
sudo dnf -y remove cheese gnome-connections gnome-maps gnome-photos gnome-tour rhythmbox totem &>> ~/setup.log

printf " [7/35] Remove unused GNOME Shell Extensions...\n" | lolcat
sudo dnf -y remove gnome-classic-session gnome-shell-extension-background-logo &>> ~/setup.log

printf " [8/35] Add Flathub remote...\n" | lolcat
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo &>> ~/setup.log

printf " [9/35] Enable Flathub remote...\n" | lolcat
flatpak remote-modify --enable flathub &>> ~/setup.log

printf " [10/35] Install flatpak applications...\n" | lolcat
flatpak -y install flathub app.drey.Dialect com.github.marktext.marktext com.github.rafostar.Clapper com.github.unrud.VideoDownloader com.lakoliu.Furtherance com.mattjakeman.ExtensionManager com.spotify.Client io.bassi.Amberol io.github.realmazharhussain.GdmSettings me.dusansimic.DynamicWallpaper net.poedit.Poedit org.bluej.BlueJ org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark org.mozilla.Thunderbird &>> ~/setup.log

printf " [11/35] Enable adw-gtk3 copr repo...\n" | lolcat
sudo dnf -y copr enable nickavem/adw-gtk3 &>> ~/setup.log

printf " [12/35] Add GitHub CLI repo...\n" | lolcat
sudo dnf install 'dnf-command(config-manager)' &>> ~/setup.log
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo &>> ~/setup.log

printf " [13/35] Install Third Party Repositories...\n" | lolcat
sudo dnf -y install fedora-workstation-repositories &>> ~/setup.log

printf " [14/35] Enable the Google Chrome repo...\n" | lolcat
sudo dnf -y config-manager --set-enabled google-chrome &>> ~/setup.log

printf " [15/35] Enable lazygit copr repo...\n" | lolcat
sudo dnf -y copr enable atim/lazygit &>> ~/setup.log

printf " [16/35] Install rpm applications...\n" | lolcat
sudo dnf -y install adw-gtk3 bat gh gimp gnome-tweaks google-chrome-stable grub-customizer keepassxc lazygit lsd neofetch plymouth-plugin-script util-linux-user vim zsh zstd &>> ~/setup.log

printf " [17/35] Install Anki...\n" | lolcat
ANKI_VERSION=$(curl --silent "https://api.github.com/repos/ankitects/anki/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
wget -P ~ https://github.com/ankitects/anki/releases/download/$ANKI_VERSION/anki-$ANKI_VERSION-linux-qt6.tar.zst &>> ~/setup.log
tar xaf ~/anki-$ANKI_VERSION-linux-qt6.tar.zst &>> ~/setup.log
cd ~/anki-$ANKI_VERSION-linux-qt6
sudo ./install.sh &>> ~/setup.log
cd ~
rm -rf ~/anki-$ANKI_VERSION-linux-qt6
rm ~/anki-$ANKI_VERSION-linux-qt6.tar.zst

printf " [18/35] Install chezmoi...\n" | lolcat
CHEZMOI_GITHUB_RELEASE_VERSION=$(curl --silent "https://api.github.com/repos/twpayne/chezmoi/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
CHEZMOI_VERSION=$(echo $CHEZMOI_GITHUB_RELEASE_VERSION | sed 's/v//')
wget -P ~ https://github.com/twpayne/chezmoi/releases/download/$CHEZMOI_GITHUB_RELEASE_VERSION/chezmoi-$CHEZMOI_VERSION-x86_64.rpm &>> ~/setup.log
sudo rpm -ivh ~/chezmoi-$CHEZMOI_VERSION-x86_64.rpm &>> ~/setup.log
rm ~/chezmoi-$CHEZMOI_VERSION-x86_64.rpm

printf " [19/35] Install Printer and Scanner Drivers (MFC-9142CDN)...\n" | lolcat
mkdir ~/linux-brprinter
wget -P ~/linux-brprinter https://download.brother.com/welcome/dlf006893/linux-brprinter-installer-2.2.3-1.gz &>> ~/setup.log
cd ~/linux-brprinter
gunzip linux-brprinter-installer-2.2.3-1.gz &>> ~/setup.log
sudo bash linux-brprinter-installer-2.2.3-1 MFC-9142CDN
cd ~
rm -rf ~/linux-brprinter

printf " [20/35] Install Tutanota...\n" | lolcat
mkdir ~/.Applications
wget -P ~/.Applications https://mail.tutanota.com/desktop/tutanota-desktop-linux.AppImage &>> ~/setup.log
chmod +x ~/.Applications/tutanota-desktop-linux.AppImage

printf " [21/35] Set Plymouth Theme...\n" | lolcat
cd ~
git clone https://github.com/adi1090x/plymouth-themes.git &>> ~/setup.log
sudo cp -r ~/plymouth-themes/pack_3/hud_space/ /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R hud_space
rm -rf ~/plymouth-themes

printf " [22/35] Install Fluent icon theme...\n" | lolcat
cd ~
git clone https://github.com/vinceliuice/Fluent-icon-theme.git &>> ~/setup.log
cd ~/Fluent-icon-theme
./install.sh -r &>> ~/setup.log
cd ~
rm -rf ~/Fluent-icon-theme

printf " [23/35] Download background...\n" | lolcat
cd ~/.config
wget -O background https://unsplash.com/photos/W3kxCizLWvo/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjc5MTY4NzMy&force=true &>> ~/setup.log
cd ~

printf " [24/35] Center new windows, set themes + background...\n" | lolcat
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Fluent-dark'
gsettings set org.gnome.desktop.background picture-uri file:///home/gabriel/.config/background
gsettings set org.gnome.desktop.background picture-uri-dark file:///home/gabriel/.config/background

printf " [25/35] Add dnf aliases...\n" | lolcat
sudo dnf alias add in=install &>> ~/setup.log
sudo dnf alias add rm=remove &>> ~/setup.log
sudo dnf alias add if=info &>> ~/setup.log
sudo dnf alias add se=search &>> ~/setup.log

printf " [26/35] Show Password Asterisks in Terminal...\n" | lolcat
sudo sed -i 's/Defaults    env_reset/Defaults    env_reset,pwfeedback/' /etc/sudoers

printf " [27/35] Git Configuration...\n" | lolcat
git config --global user.name 'Gabriel Brand'
git config --global user.email gabr.brand@gmail.com
git config --global init.defaultBranch main

printf " [28/35] Change shell to zsh...\n" | lolcat
chsh -s $(which zsh)

printf " [29/35] Install Oh My Zsh!...\n" | lolcat
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

printf " [30/35] Install zsh-autosuggestions...\n" | lolcat
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &>> ~/setup.log

printf " [31/35] Install zsh-syntax-highlighting...\n" | lolcat
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &>> ~/setup.log

printf " [32/35] Install MesloLGS NF...\n" | lolcat
mkdir -p ~/.local/share/fonts
wget -P ~/.local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf &>> ~/setup.log
fc-cache -f -v &>> ~/setup.log

printf " [33/35] Install Powerlevel10k...\n" | lolcat
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k &>> ~/setup.log

printf " [34/35] Apply dotfiles...\n" | lolcat
GITHUB_USERNAME='gabrbrand'
chezmoi init --apply $GITHUB_USERNAME &>> ~/setup.log

printf " [35/35] Set keyboard shortcuts...\n" | lolcat
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Control><Alt>T'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Dateien'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'nautilus'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Super>E'

printf "\n Complete!\n\n" | lolcat

for s in {60..1}
do
    echo -ne " The system will restart automatically in $s seconds! \r" | lolcat
    sleep 1
done
echo -ne " The system restarts now!                           \n\n" | lolcat
reboot
