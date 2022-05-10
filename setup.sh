#!/bin/bash

#Optimize DNF Config
echo "fastestmirror=True
max_parallel_downloads=10
defaultyes=True" | sudo tee -a /etc/dnf/dnf.conf

#Install Updates
sudo dnf -y update

#Remove Cheese (rpm)
sudo dnf -y remove cheese

#Remove Connections (rpm)
sudo dnf -y remove gnome-connections

#Remove Fedora Media Writer (rpm)
sudo dnf -y remove mediawriter

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

#Remove unused system extensions
cd /usr/share/gnome-shell/extensions
sudo rm -r apps-menu@gnome-shell-extensions.gcampax.github.com background-logo@fedorahosted.org places-menu@gnome-shell-extensions.gcampax.github.com window-list@gnome-shell-extensions.gcampax.github.com
cd ~

#Add Flathub remote
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#Git Configuration
git config --global user.name "Gabriel Brand"
git config --global user.email gabr.brand@gmail.com

#Install Amberol (flatpak)
flatpak -y install flathub io.bassi.Amberol

#Install Anki
wget -P ~/Downloads https://github.com/ankitects/anki/releases/download/2.1.51/anki-2.1.51-linux-qt6.tar.zst
cd ~
tar xaf ~/Downloads/anki-2.1.51-linux-qt6.tar.zst
cd ~/anki-2.1.51-linux-qt6
sudo ./install.sh
cd ~
rm -r ~/anki-2.1.51-linux-qt6
rm ~/Downloads/anki-2.1.51-linux-qt6.tar.zst

#Install BlueJ (flatpak)
flatpak -y install flathub org.bluej.BlueJ

#Install GitHub CLI (rpm)
sudo dnf install 'dnf-command(config-manager)'
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf -y install gh
gh auth login

#Set GitHub CLI aliases
gh alias set rv 'repo view'
gh alias set il 'issue list'
gh alias set iv 'issue view'
gh alias set pl 'pr list'
gh alias set pv 'pr view'

#Install Clapper (flatpak)
flatpak -y install flathub com.github.rafostar.Clapper

#Install Dynamic Wallpaper (flatpak)
flatpak -y install flathub me.dusansimic.DynamicWallpaper

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

#Configure Ulauncher settings
echo "{
    \"blacklisted-desktop-dirs\": \"/usr/share/locale:/usr/share/app-install:/usr/share/kservices5:/usr/share/fk5:/usr/share/kservicetypes5:/usr/share/applications/screensavers:/usr/share/kde4:/usr/share/mimelnk\",
    \"clear-previous-query\": true,
    \"disable-desktop-filters\": false,
    \"grab-mouse-pointer\": false,
    \"hotkey-show-app\": \"null\",
    \"render-on-screen\": \"default-monitor\",
    \"show-indicator-icon\": true,
    \"show-recent-apps\": \"0\",
    \"terminal-command\": \"\",
    \"theme-name\": \"adwaita-dark\"
}" > ~/.config/ulauncher/settings.json

#Add Ulauncher extensions
echo "{
    \"com.github.ulauncher.ulauncher-timer\": {
        \"id\": \"com.github.ulauncher.ulauncher-timer\",
        \"url\": \"https://github.com/Ulauncher/ulauncher-timer.git\",
        \"updated_at\": \"2022-04-13T10:58:16.049611\",
        \"last_commit\": \"4262fc24db08610d01ea311d2e12f22588c98886\",
        \"last_commit_time\": \"2020-11-03T07:21:30\"
    },
    \"com.github.manahter.ulauncher-translate\": {
        \"id\": \"com.github.manahter.ulauncher-translate\",
        \"url\": \"https://github.com/manahter/ulauncher-translate.git\",
        \"updated_at\": \"2022-04-13T10:58:34.262273\",
        \"last_commit\": \"f81d32c583c7e3542bdba655e991a56e6d9a2c28\",
        \"last_commit_time\": \"2021-04-09T18:12:40\"
    },
    \"com.github.ckrybus.ulauncher-journal\": {
        \"id\": \"com.github.ckrybus.ulauncher-journal\",
        \"url\": \"https://github.com/ckrybus/ulauncher-journal.git\",
        \"updated_at\": \"2022-04-13T10:59:31.255868\",
        \"last_commit\": \"c3fc03c6568bbba30ebef47a6f8d7321c3c9cdbb\",
        \"last_commit_time\": \"2020-05-17T18:23:23\"
    },
    \"com.github.ulauncher.ulauncher-emoji\": {
        \"id\": \"com.github.ulauncher.ulauncher-emoji\",
        \"url\": \"https://github.com/Ulauncher/ulauncher-emoji\",
        \"updated_at\": \"2022-04-13T18:51:26.718193\",
        \"last_commit\": \"4c6af50d1c9a24d5aad2c597634ff0c634972a5c\",
        \"last_commit_time\": \"2021-08-08T19:19:59\"
    },
    \"com.github.friday.ulauncher-clipboard\": {
        \"id\": \"com.github.friday.ulauncher-clipboard\",
        \"url\": \"https://github.com/friday/ulauncher-clipboard\",
        \"updated_at\": \"2022-04-13T18:53:25.409074\",
        \"last_commit\": \"9c8c0de1fd86504754300da8278fbc3db9b1a2b5\",
        \"last_commit_time\": \"2022-01-18T05:32:06\"
    },
    \"com.github.iboyperson.ulauncher-system\": {
        \"id\": \"com.github.iboyperson.ulauncher-system\",
        \"url\": \"https://github.com/iboyperson/ulauncher-system\",
        \"updated_at\": \"2022-04-13T18:59:06.905782\",
        \"last_commit\": \"667613bf7bb6b4affa4f2121b58589477cd89829\",
        \"last_commit_time\": \"2021-11-08T18:16:55\"
    }
}" > ~/.config/ulauncher/extensions.json

#Install Visual Studio Code (rpm)
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf -y install code

#Install Printer and Scanner Drivers (MFC-9142CDN)
mkdir ~/Downloads/linux-brprinter
wget -P ~/Downloads/linux-brprinter https://download.brother.com/welcome/dlf006893/linux-brprinter-installer-2.2.3-1.gz
cd ~/Downloads/linux-brprinter
gunzip linux-brprinter-installer-*.*.*-*.gz
sudo bash linux-brprinter-installer-*.*.*-* MFC-9142CDN
cd ~
sudo rm -r ~/Downloads/linux-brprinter

#Install adw-gtk3
sudo dnf -y install ninja-build meson sassc
git clone https://github.com/lassekongo83/adw-gtk3.git
cd ~/adw-gtk3
meson build
sudo ninja -C build install
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
flatpak -y install org.gtk.Gtk3theme.adw-gtk3-dark
cd ~
sudo rm -r ~/adw-gtk3

#Install Papirus icon theme
wget -qO- https://git.io/papirus-icon-theme-install | sh
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark

#Install Papirus Folders
wget -qO- https://git.io/papirus-folders-install | sh
papirus-folders -C adwaita

#Install bpytop (rpm)
sudo dnf -y install bpytop

#Install cronie (rpm)
sudo dnf -y install cronie

#Add crontab
echo "
55 21 * * * gabriel notify-send \"Ausschalten\" \"Das System schaltet sich automatisch in 5 Minuten ab.\"

00 22 * * * root /usr/sbin/shutdown -h now" | sudo tee -a /etc/crontab

#Install lazygit (rpm)
sudo dnf copr enable atim/lazygit -y
sudo dnf -y install lazygit

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

#Update .zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
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
