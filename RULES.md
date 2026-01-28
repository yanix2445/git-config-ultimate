# Règles Git/GitHub CLI - Développeur Solo

## 🎯 Principes Fondamentaux

### Règle d'Or
```
TOUJOURS utiliser les CLI officiels
Git CLI (git) + GitHub CLI (gh) = SEULS outils autorisés
AUCUNE interface graphique, AUCUN MCP pour Git/GitHub
```

### 🇫🇷 RÈGLE LANGUE : FRANÇAIS EXCLUSIVEMENT
```
OBLIGATOIRE - TOUS les commits, messages, documentation en FRANÇAIS

✅ FRANÇAIS SEULEMENT:
- Messages de commit
- Descriptions de branches
- Documentation (README, CHANGELOG, etc.)
- Commentaires de code
- Issues et Pull Requests
- Noms de variables/fonctions (si possible)
- Messages d'erreur personnalisés
- Logs et traces
- Notes et TODOs

❌ INTERDIT:
- Messages en anglais
- Mélange français/anglais dans un même message
- Code Switching non justifié

EXCEPTIONS AUTORISÉES:
- Commandes Git/GitHub (git commit, git push, etc.)
- Mots-clés de programmation (function, class, const, etc.)
- Noms de frameworks/librairies (React, Express, etc.)
- Types de commit standardisés (feat, fix, wip, etc.)
- Noms de fichiers techniques (.gitignore, package.json, etc.)
- URLs et liens
- Noms propres (marques, produits)

EXEMPLES CORRECTS:
✅ git commit -m "feat(auth): Ajout du système d'authentification"
✅ git commit -m "fix(api): Correction du endpoint utilisateur"
✅ git commit -m "wip: Implémentation du tableau de bord"
✅ git commit -m "docs: Mise à jour de la documentation API"

EXEMPLES INCORRECTS:
❌ git commit -m "feat(auth): Add authentication system"
❌ git commit -m "fix: Fixed the bug in user endpoint"
❌ git commit -m "wip: Working on dashboard implementation"

RAISONS:
- Cohérence du projet
- Facilité de compréhension pour vous et futurs collaborateurs francophones
- Professionnalisme dans votre langue maternelle
- Traçabilité claire de l'évolution du projet
- Documentation accessible
```

### Hiérarchie des Commandes
```
1. git (pour toutes les opérations Git locales)
2. gh (pour toutes les interactions avec GitHub)
3. Jamais d'alternatives (GUI, MCP, etc.)
```

---

## 📋 Installation et Vérification Obligatoires

### Vérification Systématique au Démarrage

```xml
<git_github_verification>
<check_sequence>
  1. Vérifier Git CLI
  2. Vérifier GitHub CLI
  3. Vérifier authentification GitHub
  4. Vérifier configuration Git
  5. Logger les versions
</check_sequence>

<verification_protocol>
  <git_check>
    <command>git --version</command>
    <expected_format>git version X.Y.Z</expected_format>
    <minimum_version>2.30.0</minimum_version>
    <if_missing>
      <action>Installer via doc officielle</action>
      <doc_url>https://git-scm.com/book/en/v2/Getting-Started-Installing-Git</doc_url>
    </if_missing>
    <if_outdated>
      <action>Proposer mise à jour</action>
      <explain>Nouvelles fonctionnalités et correctifs de sécurité</explain>
    </if_outdated>
  </git_check>

  <github_cli_check>
    <command>gh --version</command>
    <expected_format>gh version X.Y.Z</expected_format>
    <minimum_version>2.0.0</minimum_version>
    <if_missing>
      <action>Installer via brew (macOS)</action>
      <install_command>brew install gh</install_command>
      <doc_url>https://cli.github.com/manual/installation</doc_url>
    </if_missing>
  </github_cli_check>

  <auth_check>
    <command>gh auth status</command>
    <if_not_authenticated>
      <action>Lancer l'authentification</action>
      <auth_command>gh auth login</auth_command>
      <recommend>
        - Protocole: HTTPS
        - Méthode: Login with web browser
        - Permissions: repo, workflow, admin:org
      </recommend>
    </if_not_authenticated>
  </auth_check>

  <git_config_check>
    <user_name>
      <command>git config --global user.name</command>
      <if_empty>
        <action>Demander configuration</action>
        <template>git config --global user.name "Votre Nom"</template>
      </if_empty>
    </user_name>
    <user_email>
      <command>git config --global user.email</command>
      <if_empty>
        <action>Demander configuration</action>
        <template>git config --global user.email "votre@email.com"</template>
      </if_empty>
    </user_email>
  </git_config_check>
</verification_protocol>
</git_github_verification>
```

### Template de Vérification Automatique

```bash
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
```

---

## 🏗️ Gestion des Repositories

### Création de Repository

```xml
<repo_creation_workflow>
<standard_process>
  1. <create_on_github>
     <command>gh repo create [nom-repo]</command>
     <options>
       --public / --private : Visibilité
       --description "Description du projet"
       --gitignore [language] : Template .gitignore
       --license [type] : Licence (ex: mit, apache-2.0)
       --clone : Clone automatiquement après création
     </options>
     <example>
       gh repo create mon-projet \
         --private \
         --description "Description de mon projet" \
         --gitignore Node \
         --license mit \
         --clone
     </example>
  </create_on_github>

  2. <if_not_cloned>
     <clone_command>gh repo clone [user]/[nom-repo]</clone_command>
     <alternative>git clone https://github.com/[user]/[nom-repo].git</alternative>
  </if_not_cloned>

  3. <initial_setup>
     cd [nom-repo]
     
     # Créer structure de base
     mkdir -p src tests docs
     
     # README initial
     echo "# [Nom Projet]" > README.md
     echo "" >> README.md
     echo "## Description" >> README.md
     echo "[Description du projet]" >> README.md
     
     # Premier commit
     git add .
     git commit -m "init: Initial project setup"
     git push -u origin main
  </initial_setup>
</standard_process>

<initialization_checklist>
  Vérifier avant premier push:
  - [ ] .gitignore approprié
  - [ ] README.md avec description
  - [ ] LICENSE file (si applicable)
  - [ ] Structure de dossiers de base
  - [ ] Configuration initiale (package.json, etc.)
</initialization_checklist>
</repo_creation_workflow>
```

### Clonage de Repository

```xml
<clone_workflow>
<preferred_method>
  # Avec GitHub CLI (recommandé)
  gh repo clone [user]/[repo]
  
  Avantages:
  - Gestion automatique des credentials
  - URLs SSH/HTTPS selon config
  - Integration avec gh
</preferred_method>

<alternative_method>
  # Avec Git CLI
  git clone https://github.com/[user]/[repo].git
  
  # Ou avec SSH (si configuré)
  git clone git@github.com:[user]/[repo].git
</alternative_method>

<post_clone_setup>
  cd [repo]
  
  # Vérifier remotes
  git remote -v
  
  # Vérifier branches
  git branch -a
  
  # Créer branche de développement si besoin
  git checkout -b develop
</post_clone_setup>
</clone_workflow>
```

---

## 📝 Convention de Commit - Solo Dev Multi-Changements

### Philosophie pour Développeur Solo

```markdown
En tant que développeur solo, vous avez besoin de:
1. Flexibilité pour commiter plusieurs changements
2. Historique clair pour retrouver les modifications
3. Possibilité de revenir en arrière facilement
4. Documentation de votre progression

La convention suivante permet tout cela sans la rigidité
des conventions d'équipe.
```

### Format de Commit Standard

```
<type>(<scope>): <subject>

<body>

<footer>
```

#### Types de Commit (Exhaustifs - Tous Domaines)

```xml
<commit_types>
<primary_types>
  <!-- DÉVELOPPEMENT GÉNÉRAL -->
  init:       Initialisation de projet/module/composant
  feat:       Nouvelle fonctionnalité
  fix:        Correction de bug
  refactor:   Refactorisation (sans changement de fonctionnalité)
  docs:       Documentation uniquement
  style:      Formatage, style, linting (pas de changement de code)
  test:       Ajout/modification de tests
  perf:       Amélioration de performance
  build:      Changements du système de build
  ci:         Changements CI/CD
  chore:      Maintenance, tâches diverses
  
  <!-- DÉVELOPPEMENT WEB -->
  ui:         Modifications interface utilisateur
  ux:         Améliorations expérience utilisateur
  a11y:       Améliorations accessibilité
  seo:        Optimisations SEO
  i18n:       Internationalisation/traductions
  l10n:       Localisation
  responsive: Adaptations responsive/mobile
  pwa:        Progressive Web App features
  
  <!-- DÉVELOPPEMENT MOBILE -->
  ios:        Spécifique iOS
  android:    Spécifique Android
  mobile:     Mobile multiplateforme
  native:     Code natif (Swift, Kotlin, Java)
  hybrid:     Framework hybride (React Native, Flutter)
  
  <!-- DÉVELOPPEMENT DESKTOP -->
  desktop:    Application desktop
  electron:   Spécifique Electron
  macos:      Spécifique macOS
  windows:    Spécifique Windows
  linux:      Spécifique Linux
  
  <!-- BACKEND & API -->
  api:        Endpoints/routes API
  endpoint:   Nouveau endpoint ou modification
  graphql:    Schémas/resolvers GraphQL
  rest:       API REST
  grpc:       Services gRPC
  websocket:  WebSocket implementation
  middleware: Middleware/interceptors
  controller: Controllers
  service:    Services métier
  repository: Data access layer
  
  <!-- BASE DE DONNÉES -->
  db:         Base de données général
  migration:  Migration de base de données
  schema:     Modification de schéma
  seed:       Données de seed/fixtures
  query:      Optimisation de requêtes
  index:      Index de base de données
  backup:     Backup/restore procédures
  
  <!-- SÉCURITÉ -->
  security:   Améliorations sécurité
  auth:       Authentification
  authz:      Autorisation
  oauth:      OAuth implementation
  jwt:        JWT handling
  encrypt:    Encryption/decryption
  audit:      Audit logs
  vulnerability: Correction de vulnérabilité
  
  <!-- INFRASTRUCTURE & DEVOPS -->
  infra:      Infrastructure as Code
  docker:     Dockerfile, docker-compose
  k8s:        Kubernetes manifests
  terraform:  Terraform configurations
  ansible:    Ansible playbooks
  helm:       Helm charts
  deploy:     Déploiement
  provision:  Provisioning
  monitoring: Monitoring/observability
  logging:    Logging configuration
  metrics:    Métriques
  alert:      Alertes/notifications
  
  <!-- RÉSEAU & SYSTÈME -->
  network:    Configuration réseau
  firewall:   Règles firewall
  dns:        Configuration DNS
  ssl:        Certificats SSL/TLS
  proxy:      Configuration proxy/reverse proxy
  loadbalancer: Load balancer
  cdn:        CDN configuration
  cache:      Mise en cache
  storage:    Stockage/filesystem
  system:     Configuration système
  kernel:     Modifications kernel
  driver:     Drivers/modules
  
  <!-- CI/CD -->
  ci:         Continuous Integration
  cd:         Continuous Deployment
  pipeline:   Pipeline configuration
  jenkins:    Jenkins jobs
  gitlab-ci:  GitLab CI/CD
  github-actions: GitHub Actions
  travis:     Travis CI
  circleci:   CircleCI
  
  <!-- CLOUD PROVIDERS -->
  aws:        Amazon Web Services
  azure:      Microsoft Azure
  gcp:        Google Cloud Platform
  digitalocean: DigitalOcean
  heroku:     Heroku
  vercel:     Vercel
  netlify:    Netlify
  
  <!-- OUTILS & WORKFLOW -->
  config:     Configuration
  deps:       Dépendances
  tooling:    Outils de développement
  scripts:    Scripts/automation
  makefile:   Makefile changes
  env:        Variables d'environnement
  
  <!-- QUALITÉ & ANALYSE -->
  lint:       Linting configuration
  format:     Code formatting
  analyze:    Analyse statique
  coverage:   Code coverage
  benchmark:  Benchmarks
  profiling:  Profiling/optimization
  
  <!-- DONNÉES & ETL -->
  data:       Modifications de données
  etl:        Extract Transform Load
  pipeline-data: Data pipeline
  stream:     Data streaming
  batch:      Batch processing
  
  <!-- MACHINE LEARNING & AI -->
  ml:         Machine Learning
  ai:         Intelligence Artificielle
  model:      Modèles ML/AI
  training:   Entraînement de modèles
  dataset:    Datasets
  inference:  Inférence
  
  <!-- GAMING (si applicable) -->
  game:       Game logic
  physics:    Physics engine
  graphics:   Graphics/rendering
  audio:      Audio/sound
  asset:      Game assets
  
  <!-- BLOCKCHAIN (si applicable) -->
  blockchain: Blockchain
  smart-contract: Smart contracts
  web3:       Web3 integration
  
  <!-- TESTING SPÉCIALISÉ -->
  unit:       Tests unitaires
  integration: Tests d'intégration
  e2e:        Tests end-to-end
  load:       Tests de charge
  stress:     Tests de stress
  smoke:      Smoke tests
  regression: Tests de régression
  snapshot:   Snapshot tests
  mock:       Mocks/stubs
  
  <!-- DOCUMENTATION SPÉCIALISÉE -->
  readme:     README updates
  wiki:       Wiki/documentation
  tutorial:   Tutoriels
  example:    Exemples de code
  changelog:  CHANGELOG updates
  api-docs:   Documentation API
  swagger:    Swagger/OpenAPI docs
  
  <!-- GESTION DE PROJET -->
  project:    Gestion de projet
  roadmap:    Roadmap updates
  milestone:  Milestone
  issue:      Lié à une issue
  ticket:     Lié à un ticket
  
  <!-- RELEASE & VERSIONING -->
  release:    Nouvelle release
  version:    Bump de version
  tag:        Tag de version
  hotfix:     Hotfix
  patch:      Patch
  breaking:   Breaking change
  
  <!-- MAINTENANCE -->
  cleanup:    Nettoyage de code
  remove:     Suppression de code
  deprecate:  Dépréciation
  upgrade:    Mise à jour/upgrade
  downgrade:  Downgrade
  rollback:   Rollback
  
  <!-- URGENCE -->
  urgent:     Changement urgent
  critical:   Correction critique
  emergency:  Urgence
</primary_types>

<special_types>
  <!-- WORKFLOW SOLO DEV -->
  wip:        Work In Progress (travail en cours, sauvegarde temporaire)
  checkpoint: Checkpoint de sauvegarde
  snapshot:   Point de sauvegarde important (fin de journée, avant expérimentation)
  savepoint:  Point de sauvegarde avant modifications risquées
  backup:     Backup avant changements majeurs
  
  <!-- GESTION DES BRANCHES -->
  merge:      Fusion de branches
  rebase:     Rebase de branche
  squash:     Squash de commits
  cherry-pick: Cherry-pick de commit
  
  <!-- CORRECTIONS -->
  revert:     Annulation d'un commit précédent
  fixup:      Fixup pour un commit précédent
  amend:      Amendement d'un commit
  
  <!-- EXPÉRIMENTATION -->
  experiment: Expérimentation/POC
  poc:        Proof of Concept
  spike:      Spike technique
  prototype:  Prototype
  draft:      Draft/brouillon
  temp:       Temporaire (à retravailler)
  
  <!-- NETTOYAGE HISTORIQUE -->
  cleanup-history: Nettoyage de l'historique
  rewrite:    Réécriture de l'historique
  optimize-history: Optimisation de l'historique
  
  <!-- SYNCHRONISATION -->
  sync:       Synchronisation
  upstream:   Mise à jour depuis upstream
  downstream: Propagation downstream
  
  <!-- REVIEW & QUALITÉ -->
  review:     Suite à code review
  feedback:   Suite à feedback
  suggestion: Implémentation de suggestion
  improvement: Amélioration générale
  
  <!-- CONFLITS -->
  conflict:   Résolution de conflit
  resolve:    Résolution de problème
  
  <!-- AUTOMATISATION -->
  auto:       Commit automatique
  bot:        Commit par bot
  cron:       Tâche cron/scheduled
</special_types>

<usage_guidelines>
  PRINCIPES POUR DÉVELOPPEUR SOLO:
  
  1. COMMITS FRÉQUENTS:
     - wip: Toutes les 30-60 minutes pendant développement actif
     - checkpoint: Après chaque micro-tâche complétée
     - snapshot: Fin de journée ou avant pause longue
  
  2. COMMITS SIGNIFICATIFS:
     - feat/fix: Changements fonctionnels importants
     - refactor: Nettoyage de code
     - perf: Optimisations mesurables
  
  3. COMMITS SPÉCIALISÉS:
     - Utiliser le type spécifique au domaine (api, db, docker, etc.)
     - Préfixer avec le domaine si nécessaire
  
  4. COMMITS D'URGENCE:
     - hotfix/critical: Corrections urgentes
     - urgent: Changements prioritaires
  
  5. RETRAVAILLER L'HISTORIQUE:
     - Avant merge vers main: squash des wip
     - Regrouper commits logiquement liés
     - Messages clairs et descriptifs
  
  🇫🇷 LANGUE OBLIGATOIRE: FRANÇAIS
  - TOUS les messages de commit en français
  - Descriptions détaillées en français
  - Documentation en français
  - AUCUN anglais dans les messages
  
  EXEMPLES PAR DOMAINE (EN FRANÇAIS):
  
  Web Full-Stack:
  - feat(frontend): Ajout de la page profil utilisateur
  - fix(api): Correction du endpoint d'authentification
  - ui: Refonte du design du tableau de bord
  - db(migration): Ajout des index sur la table users
  
  DevOps:
  - infra(terraform): Configuration de l'infrastructure AWS
  - docker: Mise à jour du Dockerfile de production
  - k8s: Ajout des manifests de déploiement
  - ci(github-actions): Configuration des tests automatisés
  
  Mobile:
  - mobile(ios): Implémentation des notifications push
  - android: Correction du crash au démarrage
  - feat(react-native): Ajout du mode hors ligne
  
  Réseau/Système:
  - network: Configuration de la passerelle VPN
  - firewall: Mise à jour des règles de sécurité
  - system: Optimisation des paramètres kernel
  - monitoring: Configuration des alertes Prometheus
  
  Machine Learning:
  - ml(model): Entraînement du modèle de classification
  - data: Préparation du jeu de données d'entraînement
  - inference: Optimisation du pipeline d'inférence
  
  Sécurité:
  - security: Implémentation du rate limiting
  - auth(oauth): Ajout de l'authentification Google OAuth
  - encrypt: Chiffrement des données sensibles au repos
  - vulnerability: Correction de l'injection SQL
</usage_guidelines>

<multi_domain_examples>
  # Projet Full-Stack avec Infrastructure (EN FRANÇAIS)
  git commit -m "feat(api): Ajout du endpoint de traitement des paiements"
  git commit -m "db(migration): Création de la table transactions"
  git commit -m "ui: Implémentation du formulaire de paiement"
  git commit -m "test(e2e): Ajout des tests du flux de paiement"
  git commit -m "docker: Mise à jour de la configuration de production"
  git commit -m "docs(api): Documentation de l'API de paiement"
  
  # DevOps Pipeline Complet (EN FRANÇAIS)
  git commit -m "infra(terraform): Configuration du cluster Kubernetes"
  git commit -m "k8s: Création des manifests de déploiement"
  git commit -m "docker: Optimisation des builds multi-stage"
  git commit -m "ci(gitlab): Configuration des déploiements automatisés"
  git commit -m "monitoring: Configuration des tableaux de bord Grafana"
  git commit -m "alert: Configuration de l'intégration PagerDuty"
  
  # Application Mobile Cross-Platform (EN FRANÇAIS)
  git commit -m "mobile(react-native): Ajout du flux d'authentification"
  git commit -m "ios: Configuration des notifications push"
  git commit -m "android: Configuration de l'intégration Firebase"
  git commit -m "feat(offline): Implémentation du mode hors ligne"
  git commit -m "perf: Optimisation du temps de démarrage de l'app"
  
  # Système & Réseau (EN FRANÇAIS)
  git commit -m "system: Configuration des interfaces réseau"
  git commit -m "firewall: Configuration des règles iptables"
  git commit -m "network(dns): Configuration de la résolution DNS"
  git commit -m "ssl: Installation et configuration des certificats"
  git commit -m "monitoring: Configuration de la collecte des métriques système"
</multi_domain_examples>
</commit_types>
```

#### Scopes Exhaustifs (Multi-Domaines)

```xml
<scopes>
<architecture_layers>
  <!-- COUCHES APPLICATIVES -->
  frontend:      Interface utilisateur / Client
  backend:       Serveur / Business logic
  fullstack:     Changements front + back
  
  <!-- FRONTEND DÉTAILLÉ -->
  ui:            User Interface components
  ux:            User Experience
  views:         Vues/pages
  components:    Composants réutilisables
  layouts:       Layouts/templates
  styles:        CSS/SCSS/styling
  assets:        Images, fonts, static files
  forms:         Formulaires
  validation:    Validation côté client
  routing:       Routage/navigation
  state:         State management
  store:         Store (Redux, Vuex, etc.)
  hooks:         React hooks ou similaires
  directives:    Directives (Angular, Vue)
  animations:    Animations/transitions
  
  <!-- BACKEND DÉTAILLÉ -->
  api:           API endpoints
  rest:          REST API
  graphql:       GraphQL
  grpc:          gRPC services
  websocket:     WebSocket handlers
  controllers:   Controllers
  services:      Business services
  repositories:  Data repositories
  models:        Data models
  entities:      Entities/domain objects
  dto:           Data Transfer Objects
  middleware:    Middleware
  interceptors:  Interceptors
  filters:       Filters
  guards:        Guards/authorization
  validators:    Validators backend
  serializers:   Serializers
  parsers:       Parsers
  handlers:      Event handlers
  workers:       Background workers
  jobs:          Job queues
  schedulers:    Scheduled tasks
  cron:          Cron jobs
</architecture_layers>

<data_layer>
  <!-- BASE DE DONNÉES -->
  db:            Base de données général
  database:      Database operations
  migrations:    Database migrations
  schema:        Database schema
  models:        Database models
  orm:           ORM configuration
  queries:       Queries optimization
  indexes:       Database indexes
  procedures:    Stored procedures
  triggers:      Database triggers
  views-db:      Database views
  seeds:         Database seeds
  fixtures:      Test fixtures
  backup:        Backup/restore
  
  <!-- TYPES DE BDD -->
  postgres:      PostgreSQL
  mysql:         MySQL/MariaDB
  mongodb:       MongoDB
  redis:         Redis
  elasticsearch: Elasticsearch
  cassandra:     Cassandra
  dynamodb:      DynamoDB
  sqlite:        SQLite
  
  <!-- DONNÉES -->
  data:          Data processing
  etl:           ETL processes
  pipeline:      Data pipeline
  streaming:     Data streaming
  batch:         Batch processing
  analytics:     Analytics
  reporting:     Reporting
</data_layer>

<security_layer>
  <!-- SÉCURITÉ -->
  security:      Sécurité général
  auth:          Authentication
  authz:         Authorization
  oauth:         OAuth
  jwt:           JWT handling
  session:       Session management
  cookies:       Cookies management
  tokens:        Token management
  encryption:    Encryption
  hashing:       Hashing
  signing:       Signing/verification
  rbac:          Role-Based Access Control
  acl:           Access Control Lists
  permissions:   Permissions
  policies:      Security policies
  firewall:      Firewall rules
  waf:           Web Application Firewall
  ddos:          DDoS protection
  rate-limit:    Rate limiting
  cors:          CORS configuration
  csp:           Content Security Policy
  ssl:           SSL/TLS
  certificates:  Certificates management
  secrets:       Secrets management
  vault:         Vault integration
  audit:         Audit logs
  compliance:    Compliance
  privacy:       Privacy/GDPR
</security_layer>

<infrastructure>
  <!-- INFRASTRUCTURE -->
  infra:         Infrastructure général
  infrastructure: Infrastructure as Code
  terraform:     Terraform
  ansible:       Ansible
  pulumi:        Pulumi
  cloudformation: CloudFormation
  
  <!-- CONTAINERS & ORCHESTRATION -->
  docker:        Docker
  dockerfile:    Dockerfile
  compose:       Docker Compose
  k8s:           Kubernetes
  kubernetes:    Kubernetes manifests
  helm:          Helm charts
  istio:         Istio service mesh
  pods:          Kubernetes pods
  deployments:   Kubernetes deployments
  services-k8s:  Kubernetes services
  ingress:       Ingress configuration
  configmaps:    ConfigMaps
  secrets-k8s:   Kubernetes secrets
  
  <!-- CLOUD PROVIDERS -->
  aws:           Amazon Web Services
  ec2:           AWS EC2
  s3:            AWS S3
  lambda:        AWS Lambda
  rds:           AWS RDS
  dynamodb:      AWS DynamoDB
  cloudfront:    AWS CloudFront
  route53:       AWS Route53
  iam:           AWS IAM
  
  azure:         Microsoft Azure
  gcp:           Google Cloud Platform
  digitalocean:  DigitalOcean
  heroku:        Heroku
  vercel:        Vercel
  netlify:       Netlify
  cloudflare:    Cloudflare
  
  <!-- RÉSEAU -->
  network:       Réseau général
  networking:    Network configuration
  dns:           DNS configuration
  loadbalancer:  Load balancer
  proxy:         Proxy configuration
  nginx:         Nginx
  apache:        Apache
  cdn:           CDN configuration
  vpn:           VPN configuration
  routing:       Network routing
  subnet:        Subnet configuration
  vlan:          VLAN configuration
  
  <!-- SYSTÈME -->
  system:        Système d'exploitation
  linux:         Linux
  ubuntu:        Ubuntu
  centos:        CentOS
  debian:        Debian
  macos:         macOS
  windows:       Windows Server
  kernel:        Kernel
  systemd:       Systemd services
  cron-system:   System cron
  logrotate:     Log rotation
  
  <!-- STOCKAGE -->
  storage:       Stockage
  filesystem:    Filesystem
  volumes:       Volumes
  nfs:           NFS
  ceph:          Ceph
  gluster:       GlusterFS
</infrastructure>

<devops_ops>
  <!-- CI/CD -->
  ci:            Continuous Integration
  cd:            Continuous Deployment
  pipeline:      Pipeline configuration
  jenkins:       Jenkins
  gitlab-ci:     GitLab CI/CD
  github-actions: GitHub Actions
  circleci:      CircleCI
  travis:        Travis CI
  azure-pipelines: Azure Pipelines
  bamboo:        Bamboo
  tekton:        Tekton
  argo:          ArgoCD
  flux:          FluxCD
  
  <!-- MONITORING & OBSERVABILITY -->
  monitoring:    Monitoring
  observability: Observability
  metrics:       Metrics collection
  logging:       Logging
  tracing:       Distributed tracing
  prometheus:    Prometheus
  grafana:       Grafana
  datadog:       Datadog
  newrelic:      New Relic
  splunk:        Splunk
  elk:           ELK Stack
  elasticsearch-monitoring: Elasticsearch
  logstash:      Logstash
  kibana:        Kibana
  loki:          Loki
  tempo:         Tempo
  jaeger:        Jaeger
  zipkin:        Zipkin
  sentry:        Sentry error tracking
  bugsnag:       Bugsnag
  
  <!-- ALERTING -->
  alerts:        Alertes
  alerting:      Alerting configuration
  pagerduty:     PagerDuty
  opsgenie:      OpsGenie
  notifications: Notifications
  slack:         Slack integration
  email:         Email notifications
  sms:           SMS notifications
  
  <!-- PERFORMANCE -->
  performance:   Performance
  optimization:  Optimization
  caching:       Caching
  cache:         Cache configuration
  redis-cache:   Redis caching
  memcached:     Memcached
  varnish:       Varnish
  cdn-perf:      CDN performance
</devops_ops>

<development_domains>
  <!-- MOBILE -->
  mobile:        Mobile général
  ios:           iOS
  android:       Android
  react-native:  React Native
  flutter:       Flutter
  xamarin:       Xamarin
  ionic:         Ionic
  cordova:       Cordova
  native:        Native code
  swift:         Swift
  kotlin:        Kotlin
  java:          Java
  objective-c:   Objective-C
  
  <!-- DESKTOP -->
  desktop:       Desktop général
  electron:      Electron
  tauri:         Tauri
  qt:            Qt
  gtk:           GTK
  wpf:           WPF
  winforms:      WinForms
  
  <!-- WEB FRAMEWORKS -->
  react:         React
  vue:           Vue.js
  angular:       Angular
  svelte:        Svelte
  nextjs:        Next.js
  nuxt:          Nuxt.js
  gatsby:        Gatsby
  remix:         Remix
  astro:         Astro
  
  <!-- BACKEND FRAMEWORKS -->
  express:       Express.js
  nestjs:        NestJS
  fastapi:       FastAPI
  django:        Django
  flask:         Flask
  spring:        Spring Boot
  laravel:       Laravel
  rails:         Ruby on Rails
  aspnet:        ASP.NET
  
  <!-- LANGAGES -->
  javascript:    JavaScript
  typescript:    TypeScript
  python:        Python
  java-lang:     Java
  csharp:        C#
  go:            Go
  rust:          Rust
  php:           PHP
  ruby:          Ruby
  swift-lang:    Swift
  kotlin-lang:   Kotlin
</development_domains>

<specialized_domains>
  <!-- MACHINE LEARNING & AI -->
  ml:            Machine Learning
  ai:            Intelligence Artificielle
  model:         ML models
  training:      Model training
  inference:     Inference
  dataset:       Datasets
  features:      Feature engineering
  preprocessing: Data preprocessing
  pipeline-ml:   ML pipeline
  tensorflow:    TensorFlow
  pytorch:       PyTorch
  scikit:        Scikit-learn
  keras:         Keras
  
  <!-- BLOCKCHAIN -->
  blockchain:    Blockchain
  smart-contracts: Smart contracts
  web3:          Web3
  ethereum:      Ethereum
  solidity:      Solidity
  nft:           NFT
  defi:          DeFi
  
  <!-- GAMING -->
  game:          Game logic
  unity:         Unity
  unreal:        Unreal Engine
  godot:         Godot
  physics:       Physics engine
  graphics:      Graphics/rendering
  audio-game:    Game audio
  assets:        Game assets
  
  <!-- IoT -->
  iot:           Internet of Things
  embedded:      Embedded systems
  firmware:      Firmware
  sensors:       Sensors
  mqtt:          MQTT
  zigbee:        Zigbee
  bluetooth:     Bluetooth
  
  <!-- RÉALITÉ AUGMENTÉE/VIRTUELLE -->
  ar:            Augmented Reality
  vr:            Virtual Reality
  xr:            Extended Reality
</specialized_domains>

<quality_testing>
  <!-- TESTING -->
  test:          Tests général
  unit:          Unit tests
  integration:   Integration tests
  e2e:           End-to-end tests
  acceptance:    Acceptance tests
  functional:    Functional tests
  regression:    Regression tests
  smoke:         Smoke tests
  sanity:        Sanity tests
  load:          Load tests
  stress:        Stress tests
  performance-test: Performance tests
  security-test: Security tests
  penetration:   Penetration tests
  snapshot:      Snapshot tests
  visual:        Visual regression tests
  a11y-test:     Accessibility tests
  
  <!-- MOCKING & FIXTURES -->
  mocks:         Mocks
  stubs:         Stubs
  fixtures:      Test fixtures
  factories:     Test factories
  
  <!-- QUALITÉ CODE -->
  lint:          Linting
  format:        Code formatting
  prettier:      Prettier
  eslint:        ESLint
  sonar:         SonarQube
  codeclimate:   Code Climate
  coverage:      Code coverage
  analyze:       Static analysis
  complexity:    Cyclomatic complexity
  duplication:   Code duplication
</quality_testing>

<documentation>
  <!-- DOCUMENTATION -->
  docs:          Documentation général
  readme:        README
  wiki:          Wiki
  api-docs:      API documentation
  swagger:       Swagger/OpenAPI
  jsdoc:         JSDoc
  docstrings:    Docstrings
  tutorial:      Tutorials
  guide:         Guides
  examples:      Examples
  changelog:     CHANGELOG
  contributing:  CONTRIBUTING guide
  license:       LICENSE
  code-of-conduct: Code of Conduct
  architecture:  Architecture docs
  adr:           Architecture Decision Records
</documentation>

<project_management>
  <!-- GESTION PROJET -->
  project:       Project management
  roadmap:       Roadmap
  milestone:     Milestone
  epic:          Epic
  story:         User story
  task:          Task
  issue:         Issue
  ticket:        Ticket
  bug:           Bug tracking
  feature-request: Feature request
  
  <!-- WORKFLOW -->
  workflow:      Workflow
  process:       Process
  automation:    Automation
  scripts:       Scripts
  tooling:       Development tooling
  makefile:      Makefile
  package:       Package management
  dependencies:  Dependencies
  deps:          Dependencies (court)
  vendor:        Vendor dependencies
  
  <!-- CONFIGURATION -->
  config:        Configuration général
  env:           Environment variables
  settings:      Settings
  options:       Options/preferences
  flags:         Feature flags
  constants:     Constants
</project_management>

<user_features>
  <!-- FEATURES UTILISATEUR -->
  user:          User features
  profile:       User profile
  account:       Account management
  dashboard:     Dashboard
  settings-user: User settings
  notifications: Notifications
  messaging:     Messaging
  chat:          Chat
  comments:      Comments
  reviews:       Reviews
  ratings:       Ratings
  search:        Search functionality
  filters:       Filters
  sorting:       Sorting
  pagination:    Pagination
  
  <!-- E-COMMERCE -->
  ecommerce:     E-commerce
  cart:          Shopping cart
  checkout:      Checkout process
  payment:       Payment processing
  orders:        Orders management
  products:      Products catalog
  inventory:     Inventory management
  shipping:      Shipping
  invoicing:     Invoicing
  
  <!-- CONTENT -->
  content:       Content management
  cms:           CMS
  blog:          Blog
  articles:      Articles
  pages:         Pages
  media:         Media management
  gallery:       Gallery
  video:         Video
  audio:         Audio
  
  <!-- SOCIAL -->
  social:        Social features
  feed:          Social feed
  likes:         Likes
  shares:        Shares
  follows:       Follow/unfollow
  friends:       Friends
  groups:        Groups
  events:        Events
</user_features>

<internationalization>
  <!-- INTERNATIONALIZATION -->
  i18n:          Internationalization
  l10n:          Localization
  translations:  Translations
  locale:        Locale configuration
  languages:     Languages support
  rtl:           Right-to-left support
  currency:      Currency handling
  timezone:      Timezone handling
  date-format:   Date formatting
</internationalization>

<accessibility_compliance>
  <!-- ACCESSIBILITÉ -->
  a11y:          Accessibility
  wcag:          WCAG compliance
  aria:          ARIA attributes
  keyboard:      Keyboard navigation
  screen-reader: Screen reader support
  
  <!-- COMPLIANCE -->
  compliance:    Compliance général
  gdpr:          GDPR
  hipaa:         HIPAA
  pci:           PCI-DSS
  sox:           SOX
  iso:           ISO standards
  legal:         Legal requirements
  terms:         Terms of service
  privacy:       Privacy policy
</accessibility_compliance>

<scope_usage_rules>
  RÈGLES D'UTILISATION DES SCOPES:
  
  1. OPTIONNEL POUR SOLO DEV
     - Utilisez seulement si ça aide votre organisation
     - Plus utile pour projets complexes/multi-domaines
  
  2. COHÉRENCE
     - Si vous commencez avec scopes, continuez
     - Définissez vos propres scopes selon projet
  
  3. HIÉRARCHIE
     - Général → Spécifique
     - Ex: backend(api) ou juste api
  
  4. MULTIPLE SCOPES (optionnel)
     - frontend,mobile: Change affects both
     - Séparer par virgule si nécessaire
  
  5. PERSONNALISATION
     - Ces scopes sont des suggestions
     - Adaptez selon votre architecture
     - Créez vos propres conventions
  
  EXEMPLES PAR PROJET:
  
  Application Web Full-Stack:
  - feat(auth): Add login functionality
  - fix(api): Correct user endpoint
  - ui(dashboard): Redesign layout
  - db(migration): Add indexes
  
  Infrastructure DevOps:
  - infra(terraform): Setup AWS VPC
  - k8s(deployment): Update replicas
  - monitoring(grafana): Add dashboards
  - ci(github-actions): Configure pipeline
  
  Application Mobile:
  - mobile(ios): Implement notifications
  - android(auth): Fix OAuth flow
  - react-native(navigation): Update routing
  
  Micro-services:
  - service(user): Add profile endpoint
  - service(payment): Integrate Stripe
  - gateway: Update routing rules
  - shared: Update common utilities
</scope_usage_rules>

<scope_shortcuts>
  RACCOURCIS COMMUNS (Optionnels):
  
  Au lieu de longs scopes, vous pouvez:
  
  - fe = frontend
  - be = backend
  - db = database
  - api = api
  - ui = user interface
  - ux = user experience
  - auth = authentication
  - cfg = config
  - dep = dependencies
  - doc = documentation
  - inf = infrastructure
  - mon = monitoring
  - sec = security
  - test = testing
  
  Exemples:
  - feat(fe): Add login form
  - fix(be/api): Correct endpoint
  - chore(dep): Update packages
</scope_shortcuts>
</scopes>
```

#### Exemples de Commits Solo Dev (EN FRANÇAIS)

```bash
# Commits simples et fréquents (recommandé pour solo)
git commit -m "wip: Ajout de la logique d'authentification utilisateur"
git commit -m "wip: Mise à jour du style du formulaire de connexion"
git commit -m "fix: Correction de la regex de validation du mot de passe"
git commit -m "feat: Implémentation du flux de mot de passe oublié"

# Commit de fin de journée
git commit -m "snapshot: Fin de journée - module auth complété à 80%

- Connexion/déconnexion fonctionnels
- Réinitialisation de mot de passe implémentée
- TODO: Ajouter la vérification par email
- TODO: Améliorer les messages d'erreur"

# Commit avec body détaillé (pour changements importants)
git commit -m "feat(auth): Système d'authentification utilisateur complet

Implémentation du flux d'authentification complet:
- Connexion avec email/mot de passe
- Gestion des tokens JWT
- Réinitialisation du mot de passe par email
- Persistance des sessions
- Fonctionnalité de déconnexion

Testé avec plus de 10 scénarios, tous réussis.
Prêt pour l'intégration avec le frontend."

# Commit multi-fichiers (fréquent en solo)
git commit -m "refactor: Réorganisation de la structure du projet

- Déplacement des utilitaires vers /src/utils
- Création du répertoire /services
- Mise à jour de tous les chemins d'import
- Aucun changement de fonctionnalité"

# Commit de fix urgent
git commit -m "fix!: Problème de sécurité critique dans l'authentification

BREAKING CHANGE: Mise à jour de la validation des tokens
Affecte toutes les sessions existantes - les utilisateurs devront se reconnecter"

# Exemples par domaine

# Frontend
git commit -m "ui(dashboard): Refonte de l'interface du tableau de bord"
git commit -m "feat(forms): Ajout de la validation côté client"
git commit -m "style: Amélioration de la responsivité mobile"
git commit -m "a11y: Ajout des attributs ARIA pour l'accessibilité"

# Backend
git commit -m "api(users): Ajout du endpoint de gestion des utilisateurs"
git commit -m "middleware: Implémentation du rate limiting"
git commit -m "service(email): Intégration de SendGrid"
git commit -m "controller(auth): Refactorisation du contrôleur d'authentification"

# Base de données
git commit -m "db(migration): Ajout de la table utilisateurs"
git commit -m "schema: Modification de la structure des commandes"
git commit -m "seed: Ajout des données de test"
git commit -m "query: Optimisation de la requête de recherche"

# Infrastructure
git commit -m "docker: Configuration de l'environnement de développement"
git commit -m "k8s(deployment): Configuration du déploiement en production"
git commit -m "terraform(aws): Provisionnement de l'infrastructure EC2"
git commit -m "ci(gitlab): Ajout du pipeline de tests automatisés"

# Sécurité
git commit -m "security: Implémentation du chiffrement des données"
git commit -m "auth(2fa): Ajout de l'authentification à deux facteurs"
git commit -m "vulnerability: Correction de la faille XSS"
git commit -m "audit: Ajout des logs d'audit de sécurité"

# Documentation
git commit -m "docs(readme): Mise à jour des instructions d'installation"
git commit -m "docs(api): Documentation complète des endpoints REST"
git commit -m "wiki: Ajout du guide de contribution"
git commit -m "changelog: Mise à jour pour la version 2.0.0"

# Tests
git commit -m "test(unit): Ajout des tests unitaires pour le service utilisateur"
git commit -m "test(e2e): Tests end-to-end du flux d'achat"
git commit -m "test(integration): Tests d'intégration de l'API"
git commit -m "mock: Création des mocks pour les services externes"

# Mobile
git commit -m "mobile(ios): Implémentation des notifications push"
git commit -m "android(permissions): Gestion des permissions runtime"
git commit -m "react-native: Migration vers la nouvelle architecture"
git commit -m "native(swift): Optimisation du module caméra"

# Performance
git commit -m "perf(queries): Optimisation des requêtes base de données"
git commit -m "perf(bundle): Réduction de la taille du bundle de 40%"
git commit -m "cache: Implémentation du cache Redis"
git commit -m "optimization: Amélioration du temps de chargement initial"
```

### Workflow de Commit Quotidien

```xml
<daily_commit_workflow>
<morning_start>
  # Récupérer les dernières modifications (si repo partagé ou multi-devices)
  git pull origin main
  
  # Créer une branche de travail (optionnel pour solo, mais recommandé)
  git checkout -b feature/nom-feature
</morning_start>

<during_work>
  # Commits fréquents de type "wip"
  # Chaque 30-60 min ou après chaque mini-réalisation
  
  git add [fichiers modifiés]
  git commit -m "wip: [description courte]"
  
  # Exemple de session
  # 10h00
  git commit -m "wip: Setup authentication routes"
  
  # 11h00
  git commit -m "wip: Add JWT generation"
  
  # 12h00
  git commit -m "wip: Implement login endpoint"
  
  # Pas besoin de push à chaque commit si solo
  # Sauf si vous voulez backup cloud
</during_work>

<end_of_day>
  # Commit snapshot récapitulatif
  git add .
  git commit -m "snapshot: [Feature] - end of day

  Completed today:
  - [Tâche 1]
  - [Tâche 2]
  
  In progress:
  - [Tâche en cours]
  
  TODO tomorrow:
  - [Tâche suivante]"
  
  # Push pour backup
  git push origin feature/nom-feature
</end_of_day>

<feature_complete>
  # Quand la feature est terminée
  
  # Option 1: Squash des commits wip en un seul commit propre
  git rebase -i HEAD~[nombre_de_commits]
  # Squash tous les "wip" en un seul "feat"
  
  # Option 2: Merge sans squash (garde l'historique détaillé)
  git checkout main
  git merge feature/nom-feature
  
  # Push final
  git push origin main
</feature_complete>
</daily_commit_workflow>
