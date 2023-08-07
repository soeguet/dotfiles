#!/usr/bin/env bash

# Aktualisiere die Paketdatenbank
sudo pacman -Syu --noconfirm

# Liste für fehlgeschlagene Installationen
fehlgeschlagene_pakete=()
uebersprungene_pakete=()

# Installiere einige Pakete mit pacman
pacman_pakete=(

  # editor
  "vim"
  "nano"
  "neovim"

  # programming
  "git"
  "lazygit"
  #"code"
  "docker"
  "jdk17-openjdk"
  "rust"
  "npm"
  
  # system
  "tmux"
  "unzip"
  "wget"
  "htop" 
  "neofetch"
  "sudo"
  "exa"
  "ripgrep"
  "fd"
  "fzf"
  "blueberry"
  "blueman"
  "gst-plugin-pipewire"
  "intel-ucode"
  "iwd"
  "mupdf"
  "networkmanager"
  "pipewire-alsa"

  # terminal
  "gnome-terminal"
  "kitty"

  ## window manager
  # login manager
  "ly"
  # file system
  "nemo"
  # hyprland
  "hyprland"
  "waybar"
  "mako"
  "rofi"

  # programs
  "firefox"
  "gimp"
  )

for paket in "${pacman_pakete[@]}"; do
    if ! pacman -Qq | grep -qx "$paket"; then
        sudo pacman -S "$paket" --noconfirm
        # Überprüfe den Exit-Status von pacman
        if [ $? -ne 0 ]; then
            fehlgeschlagene_pakete+=("$paket")
        fi
    else
        uebersprungene_pakete+=("$paket")
    fi
done

# Überprüfe, ob yay installiert ist
if ! command -v yay &> /dev/null; then
    # Installiere yay (dies ist ein einfaches Beispiel und kann je nach Ihren Anforderungen variieren)
    sudo pacman -S git --noconfirm
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# Installiere einige Pakete mit yay
yay_pakete=(
  "google-chrome"
  "intellij-idea-ultimate-edition"
  "joplin"
  "joplin-desktop"
  "oh-my-zsh-git"
  "pycharm-professional"
  "python-pyfuse3"
  "ranger-git"
  "visual-studio-code-bin"
)

for paket in "${yay_pakete[@]}"; do
    if ! pacman -Qq | grep -qx "$paket"; then
        yay -S "$paket" --noconfirm
        # Überprüfe den Exit-Status von yay
        if [ $? -ne 0 ]; then
            fehlgeschlagene_pakete+=("$paket")
        fi
    else
        uebersprungene_pakete+=("$paket")
    fi
done

# Am Ende ausgeben, welche Pakete nicht installiert oder übersprungen wurden
if [ ${#uebersprungene_pakete[@]} -ne 0 ]; then
    echo "________"
    echo "Folgende Pakete wurden übersprungen (bereits installiert):"
    for paket in "${uebersprungene_pakete[@]}"; do
        echo "- $paket"
    done
    echo "________"
    echo " "
fi

if [ ${#fehlgeschlagene_pakete[@]} -ne 0 ]; then
    echo "~~~~~~~~"
    echo "Folgende Pakete konnten nicht installiert werden:"
    for paket in "${fehlgeschlagene_pakete[@]}"; do
        echo "- $paket"
    done
else
    echo "~~~~~~~~~"
    echo "Alle Pakete wurden erfolgreich installiert."
    echo "~~~~~~~~~"
fi

