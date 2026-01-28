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
git clone https://github.com/yanix2445/git-config-ultimate.git ~/git-config-ultimate

# 2. Installer
cd ~/git-config-ultimate && ./install.sh
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
flowchart LR
    Home([".gitconfig"])
    Root(["git-config-ultimate/.gitconfig"])
    Local(["core/paths.gitconfig"])
    
    subgraph Core
        System["core"]
        Optim["optimization"]
        Color["color"]
        Help["help"]
    end
    
    subgraph Modules
        User["user"]
        Delta["delta"]
        Diff["diff"]
        Workflow["workflow"]
        Maint["maintenance"]
        Creds["credentials"]
        LFS["lfs"]
        Url["url"]
    end

    %% Flow
    Home ==>| include | Root
    Root -.->| include dynamic | Local
    
    Root --> Core
    Root --> Modules
    
    %% Styles
    style Home fill:#f05133,stroke:#fff,color:#fff,stroke-width:2px
    style Root fill:#2c3e50,stroke:#fff,color:#fff,stroke-width:2px
    style Core fill:#34495e,stroke:#fff,color:#fff,stroke-width:1px
    style Modules fill:#34495e,stroke:#fff,color:#fff,stroke-width:1px
    style Local fill:#f39c12,stroke:#fff,color:#fff,stroke-width:1px,stroke-dasharray: 5 5

    linkStyle 0 stroke:#f05133,stroke-width:3px
    linkStyle 1 stroke:#f39c12,stroke-width:2px,stroke-dasharray: 5 5
```

</div>

<br/>

## ✨ Features

<div align="center">

<table>
<tr>
<td width="50%" valign="top">

### 🚀 Performance & Sécurité

| Feature | Impact |
|:---|:---|
| **FS Monitor** | `git status` instantané |
| **Commit Graph** | Logs et Merges ultra-rapides |
| **SSH Signing** | Commits signés (Verified) |
| **SSH Force** | Fini HTTPS, vive SSH |

</td>
<td width="50%" valign="top">

### 🎨 Confort & Visuel

| Feature | Impact |
|:---|:---|
| **Zdiff3** | Résolution de conflits intelligente |
| **Delta** | Diffs syntaxiques magnifiques |
| **Auto-Stash** | Pull/Rebase sans perte |
| **Sort** | Branches triées par date |

</td>
</tr>
</table>

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
