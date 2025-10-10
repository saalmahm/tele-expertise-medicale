-- Script d'initialisation de la base de données
-- Télé-Expertise Médicale - TICKET-001

-- Créer la base de données (à exécuter dans psql en dehors du "USE")
-- À noter : PostgreSQL n’utilise pas USE, mais \c pour se connecter
CREATE DATABASE tele_expertise
    WITH ENCODING 'UTF8'
    LC_COLLATE='fr_FR.UTF-8'
    LC_CTYPE='fr_FR.UTF-8'
    TEMPLATE template0;

-- Se connecter à la base
\c tele_expertise;

-- ⚠️ Les tables sont créées automatiquement par Hibernate (hbm2ddl.auto=update)
-- Ce script contient uniquement les données initiales

-- Insérer des médecins généralistes
INSERT INTO medecins_generalistes (nom, prenom, email, telephone, numero_ordre) VALUES
('ALAMI', 'Hassan', 'h.alami@hospital.ma', '0661234567', 'MED-001'),
('BENNANI', 'Fatima', 'f.bennani@hospital.ma', '0662345678', 'MED-002'),
('IDRISSI', 'Mohammed', 'm.idrissi@hospital.ma', '0663456789', 'MED-003');

-- Insérer des actes techniques (catalogue)
INSERT INTO actes_techniques (code, libelle, prix, consultation_id) VALUES
('CONS-GEN', 'Consultation Générale', 200.00, NULL),
('ECG', 'Électrocardiogramme (ECG)', 150.00, NULL),
('RADIO-THORAX', 'Radiographie Thorax', 300.00, NULL),
('RADIO-MEMBRE', 'Radiographie Membre', 250.00, NULL),
('PRISE-SANG', 'Prise de Sang - Bilan Standard', 100.00, NULL),
('PRISE-SANG-COMPLET', 'Prise de Sang - Bilan Complet', 250.00, NULL),
('TENSION', 'Mesure de Tension Artérielle', 50.00, NULL),
('GLYCEMIE', 'Test de Glycémie', 75.00, NULL),
('ECHOGRAPHIE', 'Échographie Abdominale', 400.00, NULL),
('SUTURE', 'Suture Simple', 150.00, NULL);

-- Insérer des patients de test
INSERT INTO patients (nom, prenom, date_naissance, sexe, telephone, adresse, date_enregistrement, statut) VALUES
('ZAKI', 'Ahmed', '1985-05-15', 'M', '0671234567', '15 Rue Hassan II, Casablanca', CURRENT_TIMESTAMP, 'EN_ATTENTE'),
('AMRANI', 'Sanaa', '1990-08-22', 'F', '0672345678', '32 Avenue Mohammed V, Rabat', CURRENT_TIMESTAMP, 'EN_ATTENTE'),
('CHAKIR', 'Youssef', '1978-12-10', 'M', '0673456789', '8 Boulevard Zerktouni, Marrakech', CURRENT_TIMESTAMP, 'EN_ATTENTE');

-- Insérer des signes vitaux pour les patients
INSERT INTO signes_vitaux (tension, temperature, poids, taille, frequence_cardiaque, date_enregistrement, patient_id) VALUES
('120/80', 37.0, 75.5, 175.0, 72, CURRENT_TIMESTAMP, 1),
('110/70', 36.8, 62.0, 165.0, 68, CURRENT_TIMESTAMP, 2),
('130/85', 37.2, 82.0, 180.0, 75, CURRENT_TIMESTAMP, 3);

COMMIT;
