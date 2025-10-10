-- Schéma de la base de données (adapté pour PostgreSQL)
-- Télé-Expertise Médicale

-- Table: patients
CREATE TABLE patients (
    id BIGSERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    date_naissance DATE,
    sexe VARCHAR(1),
    telephone VARCHAR(20),
    adresse VARCHAR(255),
    date_enregistrement TIMESTAMP,
    statut VARCHAR(50) NOT NULL
);

CREATE INDEX idx_patients_statut ON patients(statut);
CREATE INDEX idx_patients_date_enregistrement ON patients(date_enregistrement);

-- Table: signes_vitaux
CREATE TABLE signes_vitaux (
    id BIGSERIAL PRIMARY KEY,
    tension VARCHAR(20),
    temperature DOUBLE PRECISION,
    poids DOUBLE PRECISION,
    taille DOUBLE PRECISION,
    frequence_cardiaque INT,
    date_enregistrement TIMESTAMP NOT NULL,
    patient_id BIGINT NOT NULL REFERENCES patients(id) ON DELETE CASCADE
);

CREATE INDEX idx_signes_vitaux_patient ON signes_vitaux(patient_id);

-- Table: medecins_generalistes
CREATE TABLE medecins_generalistes (
    id BIGSERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telephone VARCHAR(20),
    numero_ordre VARCHAR(50) UNIQUE
);

CREATE INDEX idx_medecins_email ON medecins_generalistes(email);

-- Table: consultations
CREATE TABLE consultations (
    id BIGSERIAL PRIMARY KEY,
    date_consultation TIMESTAMP NOT NULL,
    diagnostic TEXT,
    prescription TEXT,
    observations TEXT,
    statut VARCHAR(50) NOT NULL,
    patient_id BIGINT NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
    medecin_id BIGINT REFERENCES medecins_generalistes(id) ON DELETE SET NULL
);

CREATE INDEX idx_consultations_statut ON consultations(statut);
CREATE INDEX idx_consultations_patient ON consultations(patient_id);

-- Table: actes_techniques
CREATE TABLE actes_techniques (
    id BIGSERIAL PRIMARY KEY,
    libelle VARCHAR(200) NOT NULL,
    code VARCHAR(50) NOT NULL,
    prix DOUBLE PRECISION NOT NULL,
    consultation_id BIGINT REFERENCES consultations(id) ON DELETE CASCADE
);

CREATE INDEX idx_actes_code ON actes_techniques(code);
CREATE INDEX idx_actes_consultation ON actes_techniques(consultation_id);
