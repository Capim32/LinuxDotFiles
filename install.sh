
# Encerra o script se algum comando falhar 
set -e

echo "
░██████╗░░█████╗░██████╗░███████╗██╗███████╗██╗░░░░░██████╗░    ██╗░░░░░░█████╗░███╗░░██╗██████╗░
██╔════╝░██╔══██╗██╔══██╗██╔════╝██║██╔════╝██║░░░░░██╔══██╗    ██║░░░░░██╔══██╗████╗░██║██╔══██╗
██║░░██╗░███████║██████╔╝█████╗░░██║█████╗░░██║░░░░░██║░░██║    ██║░░░░░███████║██╔██╗██║██║░░██║
██║░░╚██╗██╔══██║██╔══██╗██╔══╝░░██║██╔══╝░░██║░░░░░██║░░██║    ██║░░░░░██╔══██║██║╚████║██║░░██║
╚██████╔╝██║░░██║██║░░██║██║░░░░░██║███████╗███████╗██████╔╝    ███████╗██║░░██║██║░╚███║██████╔╝
░╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝╚══════╝╚═════╝░    ╚══════╝╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░"

echo "Atualizando o sistema..."
sudo pacman -Syu --noconfirm

PACOTES=(
    hyprland
    kitty
    wofi
    waybar
    dunst
    sddm
    fish
    starship
    ttf-jetbrains-mono-nerd
    polkit-kde-agent
    git
)

echo "Instalando pacotes base..."
sudo pacman -S --needed --noconfirm "${PACOTES[@]}"

echo "Restaurando arquivos de configuração..."
# Garante que .config existe
mkdir -p ~/.config

# Copia tudo da pasta .config do seu repositório para a .config do sistema
cp -r .config/* ~/.config/
echo "Configurações copiadas!"

# Ativar Serviços
echo "Habilitando serviços do sistema..."
sudo systemctl enable sddm.service --force

# Mudar o Shell Padrão
if [ "$SHELL" != "/usr/bin/fish" ]; then
    echo "Alterando shell padrão para Fish..."
    chsh -s /usr/bin/fish
fi

echo "Instalação concluída! Reinicie o sistema para aplicar tudo."