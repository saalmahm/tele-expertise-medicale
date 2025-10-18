# 🏥 Télé-Expertise Médicale

[![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://openjdk.java.net/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-1.0.0-orange?style=for-the-badge&logo=jakarta-ee&logoColor=white)](https://jakarta.ee/)
[![Hibernate](https://img.shields.io/badge/Hibernate-6.0.0-red?style=for-the-badge&logo=hibernate&logoColor=white)](https://hibernate.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3.0-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white)](https://getbootstrap.com/)

## 📋 Description du Projet

Application web de télé-expertise médicale permettant la gestion des patients et des consultations médicales à distance. Développée pour faciliter la collaboration entre infirmiers et médecins généralistes dans un environnement hospitalier.

---

## 🎯 Fonctionnalités Principales

### 👩‍⚕️ Module Infirmier

- Enregistrement des patients avec leurs informations personnelles et signes vitaux
- Recherche de patients par numéro de carte médicale
- Mise à jour des signes vitaux des patients existants
- Liste des patients du jour et historique complet
- Gestion des patients en attente de consultation

### 👨‍⚕️ Module Médecin Généraliste

- File d'attente des patients nécessitant une consultation
- Création de consultations avec sélection d'actes techniques
- Gestion des consultations (diagnostic, prescription, observations)
- Suivi des consultations terminées avec détails complets
- Calcul automatique du coût total (consultation + actes)

### 🔐 Système d'Authentification

- Connexion sécurisée avec gestion des sessions
- Autorisation par rôle (Infirmier / Médecin)
- Filtrage automatique des accès selon les permissions

### 🏗️ Architecture

- MVC (Model-View-Controller) avec couche Service
- Séparation des responsabilités (DAO, Service, Servlet)
- Persistance JPA/Hibernate avec stratégie JOINED
- Interface responsive avec Bootstrap 5
- Sécurité intégrée avec filtres d'authentification

---

## 🛠️ Technologies Utilisées

### Backend

- **Java 17** - Langage de programmation
- **Jakarta EE 10** - Spécifications d'entreprise
- **Hibernate 6.0** - ORM pour la persistance
- **MySQL 8.0** - Base de données relationnelle
- **Maven** - Gestion des dépendances et build

### Frontend

- **JSP (JavaServer Pages)** - Génération dynamique des vues
- **Bootstrap 5.3** - Framework CSS responsive
- **Font Awesome 6.4** - Iconographie
- **CSS3 personnalisé** - Styles et animations

### Sécurité

- **Filtres d'authentification** - Contrôle d'accès par rôle
- **Sessions HTTP** - Gestion des utilisateurs connectés
- **Protection CSRF** - Prévention des attaques

### Développement

- **IntelliJ IDEA** - Environnement de développement
- **Tomcat 10** - Serveur d'application
- **Git** - Contrôle de version
- **Maven** - Gestion du cycle de vie

---

## 📁 Structure du Projet

```
tele-expertise-medicale/
├── 📂 src/main/java/org/example/teleexpertisemedicale/
│   ├── 📂 dao/                          # Couche d'accès aux données
│   │   ├── ConsultationDAO.java         # Gestion des consultations en BD
│   │   ├── PatientDAO.java              # Gestion des patients en BD
│   │   └── UserDAO.java                 # Authentification en BD
│   ├── 📂 entity/                       # Entités JPA
│   │   ├── Consultation.java            # Entité consultation
│   │   ├── Patient.java                 # Entité patient avec signes vitaux
│   │   ├── User.java                    # Entité utilisateur (classe abstraite)
│   │   ├── Infirmier.java               # Entité infirmier (hérite de User)
│   │   └── MedecinGeneraliste.java      # Entité médecin (hérite de User)
│   ├── 📂 enums/                        # Énumérations
│   │   ├── Role.java                    # Rôles utilisateur
│   │   ├── StatutConsultation.java      # États des consultations
│   │   └── TypeActe.java                # Types d'actes techniques avec prix
│   ├── 📂 filter/                       # Filtres de sécurité
│   │   └── AuthenticationFilter.java    # Contrôle d'accès par rôle
│   ├── 📂 servlet/                      # Contrôleurs HTTP (MVC)
│   │   ├── AuthController.java          # Gestion de l'authentification
│   │   ├── HomeServlet.java             # Page d'accueil
│   │   ├── InfirmierServlet.java        # Module infirmier
│   │   ├── MedecinServlet.java          # Module médecin
│   │   └── LogoutController.java        # Déconnexion
│   ├── 📂 service/                      # Logique métier
│   │   ├── ConsultationService.java     # Métier des consultations
│   │   └── PatientService.java          # Métier des patients
│   └── 📂 util/                         # Utilitaires
│       └── HibernateUtil.java           # Configuration Hibernate
├── 📂 src/main/resources/
│   └── META-INF/persistence.xml         # Configuration JPA
├── 📂 src/main/webapp/                  # Ressources web
│   ├── WEB-INF/views/                   # Pages JSP
│   │   ├── infirmier/                   # Pages module infirmier
│   │   │   ├── home.jsp                 # Accueil infirmier
│   │   │   ├── enregistrer-patient.jsp  # Formulaire enregistrement
│   │   │   ├── rechercher-patient.jsp   # Recherche par carte
│   │   │   ├── mettre-a-jour-signes.jsp # Mise à jour signes vitaux
│   │   │   ├── patients.jsp             # Liste patients du jour
│   │   │   └── tous-patients.jsp        # Historique complet
│   │   ├── medecin/                     # Pages module médecin
│   │   │   ├── home.jsp                 # Accueil médecin
│   │   │   ├── patients-attente.jsp     # File d'attente
│   │   │   ├── creer-consultation.jsp   # Création consultation
│   │   │   ├── consultations.jsp        # Liste consultations
│   │   │   └── consultation-details.jsp # Détails consultation
│   │   └── login.jsp                    # Page de connexion
│   └── 📂 resources/                    # CSS, JS, images
├── 📂 target/                           # Fichiers générés
│   └── tele-expertise-medicale-1.0-SNAPSHOT.war
├── pom.xml                              # Configuration Maven
└── README.md                            # Ce fichier
```

---

## 🚀 Prérequis

### Environnement de Développement

- **Java 17** ou supérieur
- **Maven 3.6** ou supérieur
- **MySQL 8.0** ou supérieur
- **Tomcat 10** ou serveur Jakarta EE compatible
- **IDE** (IntelliJ IDEA, Eclipse, VS Code)

### Configuration de la Base de Données

**Étape 1 : Créer la base de données**

```sql
CREATE DATABASE tele_expertise_medicale 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;
```

**Étape 2 : Configurer la connexion dans `persistence.xml`**

```xml
<property name="javax.persistence.jdbc.url" 
          value="jdbc:mysql://localhost:3306/tele_expertise_medicale"/>
<property name="javax.persistence.jdbc.user" 
          value="votre_utilisateur"/>
<property name="javax.persistence.jdbc.password" 
          value="votre_mot_de_passe"/>
```

---

## 📥 Installation et Déploiement

### Étape 1 : Cloner le projet

```bash
git clone https://github.com/saalmahm/tele-expertise-medicale
cd tele-expertise-medicale
```

### Étape 2 : Compiler l'application

```bash
mvn clean compile
```

### Étape 3 : Générer le fichier WAR

```bash
mvn clean package
```

### Étape 4 : Déployer sur Tomcat

1. Copier `target/tele-expertise-medicale-1.0-SNAPSHOT.war`
2. Dans le dossier `webapps/` de Tomcat
3. Démarrer Tomcat
4. Accéder à : `http://localhost:8080/tele-expertise-medicale-1.0-SNAPSHOT/`

---

## 🔑 Comptes de Test

| Rôle      | Email                      | Mot de passe   |
|-----------|----------------------------|----------------|
| Infirmier | infirmier@test.com         | 123456         |
| Médecin   | medecin@test.com           | 123456         |

---

## 🌐 Ports Utilisés

- **Tomcat** : 8080 (configurable)
- **MySQL** : 3306 (par défaut)

---

## 📚 Guide d'Utilisation

### Connexion

1. Accéder à la page d'accueil : `http://localhost:8080/tele-expertise-medicale/`
2. Se connecter avec les identifiants appropriés
3. Être redirigé vers le module correspondant au rôle

### Workflow Infirmier

1. **Accueil** → Consulter les patients du jour
2. **Enregistrer Patient** → Ajouter un nouveau patient avec signes vitaux
3. **Rechercher Patient** → Trouver un patient par carte médicale
4. **Mettre à jour Signes** → Modifier les constantes d'un patient existant

### Workflow Médecin

1. **Accueil** → Consulter la file d'attente
2. **Patients en Attente** → Voir les patients nécessitant une consultation
3. **Créer Consultation** → Renseigner diagnostic et actes techniques
4. **Consultations** → Suivre l'historique des consultations

---

## 🔧 Configuration Avancée

### Base de Données

- **Dialect** : MySQL8Dialect
- **Stratégie de génération** : UUID pour les IDs
- **Héritage** : JOINED pour la hiérarchie User/Infirmier/Medecin

### Sécurité

- **Filtre d'authentification** : `@WebFilter("/*")`
- **Gestion des rôles** : Enum Role avec INFIRMIER/MEDECIN_GENERALISTE
- **Sessions** : Durée par défaut de Tomcat (30 minutes)

### Performances

- **Connection pooling** : Configuré dans persistence.xml
- **Lazy loading** : Activé pour optimiser les requêtes
- **Cache de second niveau** : Hibernate activé

---

## 🐛 Résolution de Problèmes

### Erreur de Connexion MySQL

**Solution** : Vérifier les paramètres de connexion dans `persistence.xml`

### Problème de Déploiement

**Solution** : S'assurer que Tomcat 10+ est utilisé (compatible Jakarta EE)

### Erreur de Mapping JPA

**Solution** : Vérifier les annotations `@Entity` et la configuration Hibernate

---

## 📈 Évolutions Possibles

- [ ] Module Spécialiste pour les avis d'expertise
- [ ] Notifications temps réel avec WebSocket
- [ ] API REST pour intégration mobile
- [ ] Rapports statistiques avec graphiques
- [ ] Sauvegarde automatique des données
- [ ] Authentification OAuth2 avec comptes externes

---

## 👥 Auteur

- **Développée par** : Salma Hamdi
