#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════════════════╗
# ║                        GIT CONFIG INSTALLER (PRO)                            ║
# ╠══════════════════════════════════════════════════════════════════════════════╣
# ║  Installation interactive :                                                  ║
# ║  1. Configure l'identité (Nom, Email, Clé SSH)                               ║
# ║  2. Adapte les chemins absolus (Templates)                                   ║
# ║  3. Lie le .gitconfig global                                                 ║
# ╚══════════════════════════════════════════════════════════════════════════════╝

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.gitconfig.backup.$(date +%s)"

echo "🚀 Installation de Git Config Boost..."
echo "📂 Dossier source : $CONFIG_DIR"

# 1. GÉNÉRATION DE USER.GITCONFIG
# ------------------------------------------------------------------------------
if [ ! -f "$CONFIG_DIR/modules/user.gitconfig" ]; then
    echo ""
    echo "👤 Configuration de l'identité :"
    read -p "   nom (ex: John Doe) : " GIT_NAME
    read -p "   email              : " GIT_EMAIL
    read -p "   github user        : " GITHUB_USER
    
    # Tentative de détection clé SSH
    SSH_KEY=""
    PUB_KEYS=$(find ~/.ssh -name "id_ed25519.pub" -o -name "id_rsa.pub" | head -n 1)
    if [ ! -z "$PUB_KEYS" ]; then
        SSH_KEY=$(cat "$PUB_KEYS")
        echo "🔑 Clé SSH détectée : $(basename "$PUB_KEYS")"
    else
        echo "⚠️  Aucune clé SSH publique trouvée dans ~/.ssh/"
    fi

    cp "$CONFIG_DIR/modules/user.gitconfig.example" "$CONFIG_DIR/modules/user.gitconfig"
    
    # Remplacement des variables (compatible Mac/Linux sed)
    sed -i.bak "s/YOUR_NAME/$GIT_NAME/" "$CONFIG_DIR/modules/user.gitconfig"
    sed -i.bak "s/YOUR_EMAIL/$GIT_EMAIL/" "$CONFIG_DIR/modules/user.gitconfig"
    sed -i.bak "s/YOUR_GITHUB_HANDLE/$GITHUB_USER/" "$CONFIG_DIR/modules/user.gitconfig"
    
    if [ ! -z "$SSH_KEY" ]; then
        # Échappement des slashs pour sed
        ESCAPED_KEY=$(echo "$SSH_KEY" | sed 's/\//\\\//g')
        sed -i.bak "s/# signingkey = YOUR_SSH_KEY_PUB/signingkey = $ESCAPED_KEY/" "$CONFIG_DIR/modules/user.gitconfig"
        # Activer la signature
        sed -i.bak "s/# gpgsign = true/gpgsign = true/" "$CONFIG_DIR/modules/user.gitconfig"
    fi
    
    rm "$CONFIG_DIR/modules/user.gitconfig.bak"
    echo "✅ modules/user.gitconfig créé."
else
    echo "ℹ️  modules/user.gitconfig existe déjà, on le garde."
fi

# 2. ADAPTATION DES CHEMINS (TEMPLATE)
# ------------------------------------------------------------------------------
# On génère core/paths.gitconfig à partir de l'exemple
TARGET_PATHS="$CONFIG_DIR/core/paths.gitconfig"
ESCAPED_PWD=$(echo "$CONFIG_DIR" | sed 's/\//\\\//g')

echo "⚙️  Génération de core/paths.gitconfig..."
cp "$CONFIG_DIR/core/paths.gitconfig.example" "$TARGET_PATHS"

# Remplacement du placeholder
sed -i.bak "s/GIT_CONFIG_DIR/$ESCAPED_PWD/g" "$TARGET_PATHS"
rm "$TARGET_PATHS.bak"

echo "✅ Chemins absolus configurés dans core/paths.gitconfig (ignoré par Git)"


# 3. LIEN SYMBOLIQUE
# ------------------------------------------------------------------------------
echo ""
echo "🔗 Liaison..."
TARGET="$HOME/.gitconfig"
SOURCE="$CONFIG_DIR/.gitconfig"

if [ -f "$TARGET" ] || [ -L "$TARGET" ]; then
    # Vérifie si c'est déjà le bon lien
    CURRENT_LINK=$(readlink "$TARGET")
    if [ "$CURRENT_LINK" == "$SOURCE" ]; then
        echo "✅ Déjà installé."
        exit 0
    fi
    
    echo "📦 Backup de l'ancien .gitconfig vers $BACKUP_DIR"
    cp "$TARGET" "$BACKUP_DIR"
fi

# Création du lien avec include
# Au lieu d'un symlink direct qui casse les chemins relatifs (parfois), 
# on crée un .gitconfig qui include notre fichier. C'est plus robuste.

echo "[include]" > "$TARGET"
echo "    path = $SOURCE" >> "$TARGET"

echo "✅ ~/.gitconfig configuré (Mode Include)."
echo ""
echo "🎉 Installation terminée ! Git est boosté."
