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
| 🏗️ | [**Architecture**](#-architecture) | Structure du projet |
| ✨ | [**Features**](#-features) | Optimisations activées |
| 🛠️ | [**Règles**](#-règles) | Convention de commit |
| � | [**Dépannage**](#-dépannage) | Résoudre les problèmes |
| �📜 | [**Licence**](#-licence) | Apache 2.0 |

</div>

<br/>

<br/>

## ⚡ Installation

```bash
git clone https://github.com/yanix2445/git-config-ultimate.git ~/git-config-ultimate
cd ~/git-config-ultimate && ./install.sh
```

> **Setup Automatisé :**
> *   ✅ **Identité** & Email
> *   ✅ **Signature SSH** (GPG)
> *   ✅ **Chemins** Portables
> *   ✅ **Clean Include**

<br/>

## 🏗️ Architecture

<div align="center">

```mermaid
flowchart LR
    Home([".gitconfig"])
    Root(["git-config-ultimate/.gitconfig"])
    Local(["core/paths.gitconfig"])
    
    Core["⚙️ Core (System, Optims)"]
    Modules["🧩 Modules (User, LFS, Delta...)"]

    %% Flow
    Home ==>| include | Root
    Root --> Core
    Root --> Modules
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

<div align="center">

| Fichier | Type | Rôle |
|:--------|:-----:|:-----|
| `.gitconfig` | ⛔ | Point d'entrée — **ne pas modifier** |
| `core/` | ⚙️ | Optimisations bas niveau & système |
| `modules/` | 🧩 | Fonctionnalités (User, LFS, Delta...) |
| `paths.gitconfig` | 🔥 | **Généré localement** — ignoré par Git |

</div>

<br/>

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

### 📝 Exemple

```text
feat(core): Ajout du module user

- Ajout de user.gitconfig
- Configuration de la clé SSH
```

> **Template** : `git commit` ouvre un modèle pré-rempli.

</td>
</tr>
</table>

</div>

<br/>

## 🚨 Dépannage

<div align="center">

<table>
<tr>
<td width="60%" valign="top">

### ❓ Problèmes Courants

| Symptôme | Solution Rapide |
|:---|:---|
| **Signature Failed** | Vérifier clé SSH dans GitHub |
| **Delta not found** | Installer : `brew install git-delta` |
| **Slow Status** | `git maintenance start` |
| **Permission Denied** | Vérifier vos clés SSH |

</td>
<td width="5%"></td>
<td width="35%" valign="top">

### ⚡ Actions

**Un souci de chemin ?**
Relancer l'installateur pour régénérer les chemins locaux.

<br>

```bash
# Régénération
./install.sh
```

<br>

> <span style="color:#f05133">⚠️ <b>Note :</b></span> Cela ne touche pas à vos données, juste à la config.

</td>
</tr>
</table>

</div>

<br>

<br>

<div align="center">

<a href="https://github.com/yanix2445">
<img src="https://capsule-render.vercel.app/api?type=waving&height=170&color=f05133&text=Made%20with%20%F0%9F%94%A5%20by%20@yanix2445&fontSize=20&fontAlign=50&fontAlignY=73&section=footer" width="100%"/>
</a>

</div>
