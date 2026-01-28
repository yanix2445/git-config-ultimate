<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=f05133&height=200&section=header&text=GIT%20ULTIMATE&fontSize=80&fontColor=ffffff&fontAlignY=40&animation=fadeIn" width="100%"/>

[![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)](https://git-scm.com/)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue?style=for-the-badge)](LICENSE)
[![Author](https://img.shields.io/badge/Author-@yanix2445-f05133?style=for-the-badge&logo=github&logoColor=white)](https://github.com/yanix2445)

**Une configuration Git modulaire, sécurisée et ultra-rapide pour les développeurs exigeants.**

</div>

<br/>

<div align="center">

| | Section | Description |
|:---:|:---|:---|
| ⚡ | [**Installation**](#-installation) | Prêt en 30 secondes |
| 🏗️ | [**Architecture**](#-architecture) | Structure modulaire |
| ✨ | [**Features**](#-features) | Optimisations activées |
| 🛠️ | [**Règles**](#-règles) | Convention de commit |
| 📜 | [**Licence**](#-licence) | Apache 2.0 |

</div>

<br/>

<br/>

## ⚡ Installation

```bash
# 1. Cloner
git clone https://github.com/yanix2445/git-config-ultimate.git ~/Developer/_Config/git

# 2. Installer
cd ~/Developer/_Config/git && ./install.sh
```

> **L'installateur interactif va :**
> - ✅ Configurer votre **Identité** (User, Email)
> - ✅ Activer la **Signature SSH** (Badge Verified)
> - ✅ Générer les **Chemins Locaux** (Paths)
> - ✅ Lier le tout proprement (`include`)

<br/>

## 🏗️ Architecture

<div align="center">

```mermaid
    Home([".gitconfig"])
    Root(["_Config/git/.gitconfig"])
    Local(["core/paths.gitconfig"])
    
    subgraph Core
        System["core.gitconfig"]
        Optim["optimization.gitconfig"]
    end
    
    subgraph Modules
        User["user.gitconfig"]
        Url["url.gitconfig"]
        Diff["diff.gitconfig"]
    end

    %% Flow
    Home ==>| include | Root
    Root --> System
    Root --> User
    Root -.->| include dynamic | Local
    
    %% Styles
    style Home fill:#f05133,stroke:#fff,color:#fff,stroke-width:2px
    style Root fill:#2c3e50,stroke:#fff,color:#fff,stroke-width:2px
    style Core fill:#34495e,stroke:#fff,color:#fff,stroke-width:1px
    style Modules fill:#34495e,stroke:#fff,color:#fff,stroke-width:1px
    style Local fill:#f39c12,stroke:#fff,color:#fff,stroke-width:1px,stroke-dasharray: 5 5

    linkStyle 0 stroke:#f05133,stroke-width:3px
    linkStyle 3 stroke:#f39c12,stroke-width:2px,stroke-dasharray: 5 5
```

</div>

<br/>

## ✨ Features

<div align="center">

### 🚀 Performance & Sécurité

| Feature | Impact |
|:---|:---|
| **FS Monitor** | `git status` instantané |
| **Commit Graph** | Logs et Merges ultra-rapides |
| **SSH Signing** | Commits signés (Verified) |
| **SSH Force** | Fini HTTPS, vive SSH |

### 🎨 Confort & Visuel

| Feature | Impact |
|:---|:---|
| **Zdiff3** | Résolution de conflits intelligente |
| **Delta** | Diffs syntaxiques magnifiques |
| **Auto-Stash** | Pull/Rebase sans perte |
| **Sort** | Branches triées par date |

</div>

<br/>

## 🛠️ Règles

<div align="center">
<i>Cette config impose un standard professionnel pour vos commits.</i>

<br/>

| Type | Usage | Exemple |
|:---:|:---|:---|
| `feat` | Nouvelle fonctionnalité | `feat(core): Ajout du module user` |
| `fix` | Correction de bug | `fix(install): Correction des chemins` |
| `docs` | Documentation | `docs(readme): Nouveau design` |
| `chore` | Maintenance | `chore: Mise à jour des deps` |
| `refactor` | Amélioration code | `refactor: Nettoyage install.sh` |

</div>

<br/>

<br/>

<div align="center">

<a href="https://github.com/yanix2445">
<img src="https://capsule-render.vercel.app/api?type=waving&height=170&color=f05133&text=Made%20with%20%F0%9F%94%A5%20by%20@yanix2445&fontSize=20&fontAlign=50&fontAlignY=73&section=footer" width="100%"/>
</a>

</div>
