#!/usr/bin/env bash

# ANSI Shadow
echo ""
echo ""
echo "  ██████╗██╗   ██╗███████╗████████╗ ██████╗ ███╗   ███╗    ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗"
echo "  ██╔════╝██║   ██║██╔════╝╚══██╔══╝██╔═══██╗████╗ ████║    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝"
echo "  ██║     ██║   ██║███████╗   ██║   ██║   ██║██╔████╔██║    ███████╗██║     ██████╔╝██║██████╔╝   ██║   "
echo "  ██║     ██║   ██║╚════██║   ██║   ██║   ██║██║╚██╔╝██║    ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   "
echo "  ╚██████╗╚██████╔╝███████║   ██║   ╚██████╔╝██║ ╚═╝ ██║    ███████║╚██████╗██║  ██║██║██║        ██║   "
echo "   ╚═════╝ ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   "
echo ""
echo ""


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
    "gradle"
    "maven"
    "npm"

    # system
    "tmux"
    "tldr"
    "unzip"
    "ark"
    "wget"
    "htop"
    "neofetch"
    "sudo"
    "zsh"
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

    # network
    "networkmanager"
    "nm-connection-editor"
    "network-manager-applet"

    # sound
    "pipewire"
    "pavucontrol"

    #"gnome-control-center"

    # clipboard manage
    "gpaste"
    "cliphist"

    # terminal
    "gnome-terminal"
    "kitty"

    ## window manager
    # login manager
    "gdm"
    # file system
    "nemo"
    # hyprland
    "hyprland"
    "waybar"
    "mako"
    "rofi"
    "ranger"

    # programs
    "firefox"
    "gimp"
    "libreoffice-still"
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

# Überprüfen, ob homebrew installiert ist
if ! command -v brew &> /dev/null; then
    # Installiere Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Aktualisiere Homebrew und füge das Homebrew-Repository hinzu
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Installiere einige Pakete mit yay
yay_pakete=(
    "google-chrome"
    "grimblast-git"
    "joplin-desktop"

    # programming
    "intellij-idea-ultimate-edition"
    "pycharm-professional"
    "webstorm"
    "python-pyfuse3"
    "visual-studio-code-bin"

    # waybar
    "wlogout" # https://github.com/ArtsyMacaw/wlogout
    "workstyle-git" # https://github.com/pierrechevalier83/workstyle
)

# Homebrew-Pakete
brew_pakete=(
    "gcc"
    "joplin-cli" 
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

for paket in "${brew_pakete[@]}"; do
    if ! brew list | grep -qx "$paket"; then
        brew install "$paket"
        # Überprüfe den Exit-Status von brew
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
        abc="$abc$paket, "    
    done 
    # Entferne das letzte Komma und Leerzeichen
    abc=${abc%, }
    echo "________"
    echo $abc
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
