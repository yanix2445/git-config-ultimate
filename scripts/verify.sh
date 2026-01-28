#!/bin/bash
# Script de vérification Git/GitHub (à exécuter au début de chaque session)

echo "🔍 Vérification Git/GitHub CLI..."

# Git
if ! command -v git &> /dev/null; then
    echo "❌ Git n'est pas installé"
    exit 1
fi
GIT_VERSION=$(git --version)
echo "✅ $GIT_VERSION"

# GitHub CLI
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI n'est pas installé"
    echo "📥 Installation: brew install gh"
    exit 1
fi
GH_VERSION=$(gh --version | head -n 1)
echo "✅ $GH_VERSION"

# Auth GitHub
if ! gh auth status &> /dev/null; then
    echo "⚠️  Non authentifié sur GitHub"
    echo "🔑 Lancer: gh auth login"
    exit 1
fi
echo "✅ Authentifié sur GitHub"

# Config Git
GIT_USER=$(git config --global user.name)
GIT_EMAIL=$(git config --global user.email)

if [ -z "$GIT_USER" ] || [ -z "$GIT_EMAIL" ]; then
    echo "⚠️  Configuration Git incomplète"
    echo "Configurer: git config --global user.name 'Nom'"
    echo "Configurer: git config --global user.email 'email@example.com'"
    exit 1
fi

echo "✅ Git configuré: $GIT_USER <$GIT_EMAIL>"
echo ""
echo "🎉 Tous les outils sont prêts!"
