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
# Git a besoin de chemins absolus pour certaine config incluse
# On remplace GIT_CONFIG_DIR par le chemin réel dans core/core.gitconfig
echo ""
echo "🔧 Adaptation des chemins..."
# On fait une copie de travail pour core.gitconfig si besoin, ou on modifie en place
# Ici on modifie en place mais de façon idempotente si possible, ou on restaure d'abord
# Pour simplifier, on assume que le repo contient 'GIT_CONFIG_DIR' placeholder.

# Astuce : On remplace le placeholder. Si l'utilisateur déplace le dossier, il devra relancer install.sh
TARGET_CORE="$CONFIG_DIR/core/core.gitconfig"
ESCAPED_PWD=$(echo "$CONFIG_DIR" | sed 's/\//\\\//g')

# On restaure le placeholder d'abord si on réinstalle (pour éviter path/path/path)
# (Optionnel, ici on suppose qu'on part du clean repo ou que sed gère)
# On cherche le pattern GIT_CONFIG_DIR
if grep -q "GIT_CONFIG_DIR" "$TARGET_CORE"; then
   sed -i.bak "s/GIT_CONFIG_DIR/$ESCAPED_PWD/g" "$TARGET_CORE"
   rm "$TARGET_CORE.bak"
   echo "✅ Chemins absolus injectés dans core.gitconfig"
else
   echo "ℹ️  Chemins déjà configurés ou placeholder introuvable."
fi


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
