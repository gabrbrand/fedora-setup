# Automatic Fedora setup

[Creating and using a live installation image](https://docs.fedoraproject.org/en-US/quick-docs/creating-and-using-a-live-installation-image/index.html "Open 'Creating and using a live installation image' on Fedora Documentation")

## About

This script

- optimizes DNF config.

- removes:
  
  - Cheese (rpm)
  
  - Connections (rpm)
  
  - Fedora Media Writer (rpm)
  
  - Maps (rpm)
  
  - Photos (rpm)
  
  - Rhthmbox (rpm)
  
  - Tour (rpm)
  
  - Videos (rpm)

- adds Flathub remote.

- configures git.

- installs:
  
  - Anki
  
  - BlueJ (flatpak)
  
  - Google Chrome (rpm)
  
  - Clapper (flatpak)
  
  - Extension Manager (flatpak)
  
  - Foliate (rpm)
  
  - Geary (rpm)
  
  - GNU Image Manipulation Program (rpm)
  
  - KeePassXC (rpm)
  
  - Marktext (flatpak)
  
  - Poedit (flatpak)
  
  - Spotify (flatpak)
  
  - Thunderbird (flatpak)
  
  - Tutanota (AppImage)
  
  - Tweaks  (rpm)
  
  - Ulauncher (rpm)
  
  - Visual Studio Code (rpm)
  
  - Adwaita Darkish Ulauncher
  
  - adw-gtk3
  
  - Papirus icon theme
  
  - bpytop (rpm)
  
  - cronie (rpm)
  
  - lazygit (rpm)
  
  - neofetch (rpm)
  
  - zsh (rpm)
  
  - Oh My Zsh!
  
  - zsh-autosuggestions
  
  - zsh-syntax-highlighting
  
  - Printer Driver (MFC-9142CDN)

## Usage

Clone repository:

```bash
git clone https://github.com/gabrbrand/fedora-setup.git
```

Move into `fedora-setup`:

```bash
cd fedora-setup
```

Execute script:

```bash
bash setup.sh
```
