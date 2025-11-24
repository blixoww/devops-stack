# DevOps Stack – CI/CD complète Java Spring Boot → Docker → k3s (Kubernetes)  
**Tout en containers, sur une seule VM Alpine Linux**

Un projet full-stack CI/CD :  
Build → Test → Analyse de code → Packaging Docker → Déploiement Kubernetes → Monitoring

[![Alpine](https://img.shields.io/badge/OS-Alpine_Linux-blue?style=flat&logo=alpinelinux)](https://alpinelinux.org/)
[![k3s](https://img.shields.io/badge/Kubernetes-k3s_v1.30+-00c7b7?style=flat&logo=kubernetes)](https://k3s.io)
[![Jenkins](https://img.shields.io/badge/CI-Jenkins_LTS-red?style=flat&logo=jenkins)](https://jenkins.io)
[![Docker](https://img.shields.io/badge/Container-Docker-blue?style=flat&logo=docker)](https://docker.com)
[![Prometheus](https://img.shields.io/badge/Monitoring-Prometheus_E42E25?style=flat&logo=prometheus)](https://prometheus.io)
[![Grafana](https://img.shields.io/badge/Grafana-11.2-F46800?style=flat&logo=grafana)](https://grafana.com)

## Fonctionnalités réalisées

- Pipeline Jenkins 100 % automatisée (dans un container Docker)
- Build + tests unitaires Maven
- Analyse de code avec SonarQube (container)
- Génération d’une image Docker `employee-api:latest`
- Déploiement automatique sur k3s (Kubernetes léger)
- Monitoring complet avec Prometheus + Grafana
- Script bash de packaging propre (exclusion des données sensibles)

## Architecture globale

GitHub → Jenkins (Docker)
├── Maven build & tests
├── SonarQube scan
├── docker build → employee-api:latest
└── kubectl apply → k3s (pod + service)

## Stack technique

| Composant          | Technologie                     | Port  |
|--------------------|----------------------------------|-------|
| OS                 | Alpine Linux                     | -     |
| Orchestrateur      | k3s (single-node)                | 6443  |
| CI/CD              | Jenkins (image custom + Docker + kubectl) | 8081  |
| Analyse de code    | SonarQube                        | 9000  |
| Monitoring         | Prometheus + Grafana             | 9090 / 3000 |
| Application        | Spring Boot → Docker → k3s       | 8082  |

## Captures d’écran

Pipeline Jenkins réussie
Dashboard Grafana (RAM, CPU)
Pod k3s en Running
SonarQube analysis

## Fonctionnement de la pipeline Jenkins (Jenkinsfile)

1. Clone du repo
2. `mvn clean test`
3. Analyse SonarQube
4. `mvn package -DskipTests`
5. Build image Docker `employee-api:latest`
6. `kubectl apply -f k8s/` → déploiement automatique sur k3s

## Contenu du repository (version publique)

Le repo est **propre et sécurisé** :
- Code source de `employee-api` retiré (seul le Dockerfile + JAR buildé restent)
- Tous les fichiers sensibles supprimés (`jenkins_home`, caches, logs, .git, target/, etc.)
- Tous les Dcokerfile
- Tous les `docker-compose.yml` et manifests Kubernetes présents
