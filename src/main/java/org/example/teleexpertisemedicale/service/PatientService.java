package org.example.teleexpertisemedicale.service;

import org.example.teleexpertisemedicale.dao.PatientDAO;
import org.example.teleexpertisemedicale.dao.SignesVitauxDAO;
import org.example.teleexpertisemedicale.entity.Patient;
import org.example.teleexpertisemedicale.entity.SignesVitaux;
import org.example.teleexpertisemedicale.enums.StatutPatient;

import java.time.LocalDate;
import java.util.List;

/**
 * Service pour la logique métier liée aux patients
 * Les services utilisent les DAOs et contiennent les règles métier
 */
public class PatientService {
    
    private final PatientDAO patientDAO;
    private final SignesVitauxDAO signesVitauxDAO;
    
    public PatientService() {
        this.patientDAO = new PatientDAO();
        this.signesVitauxDAO = new SignesVitauxDAO();
    }
    
    /**
     * Enregistrer un nouveau patient avec ses signes vitaux
     * LOGIQUE MÉTIER: Validation + Sauvegarde
     */
    public Patient enregistrerPatientAvecSignesVitaux(Patient patient, SignesVitaux signesVitaux) {
        // Validation
        if (patient.getNom() == null || patient.getNom().trim().isEmpty()) {
            throw new IllegalArgumentException("Le nom du patient est obligatoire");
        }
        if (patient.getPrenom() == null || patient.getPrenom().trim().isEmpty()) {
            throw new IllegalArgumentException("Le prénom du patient est obligatoire");
        }
        
        // Initialiser le statut si non défini
        if (patient.getStatut() == null) {
            patient.setStatut(StatutPatient.EN_ATTENTE);
        }
        
        // Sauvegarder le patient
        patientDAO.save(patient);
        
        // Si des signes vitaux sont fournis, les associer et sauvegarder
        if (signesVitaux != null) {
            signesVitaux.setPatient(patient);
            signesVitauxDAO.save(signesVitaux);
        }
        
        return patient;
    }
    
    public List<Patient> getAllPatients() {
        return patientDAO.findAll();
    }
    
    /**
     * Récupérer les patients du jour
     */
    public List<Patient> getPatientsOfToday() {
        return patientDAO.findPatientsOfDay(LocalDate.now());
    }
    
    /**
     * Récupérer les patients en attente de consultation
     */
    public List<Patient> getPatientsEnAttente() {
        return patientDAO.findByStatut(StatutPatient.EN_ATTENTE);
    }
    
    public Patient getPatientById(Long id) {
        Patient patient = patientDAO.findById(id);
        if (patient == null) {
            throw new IllegalArgumentException("Patient non trouvé avec l'ID: " + id);
        }
        return patient;
    }
    
    /**
     * Changer le statut d'un patient
     */
    public void changerStatutPatient(Long patientId, StatutPatient nouveauStatut) {
        Patient patient = getPatientById(patientId);
        patient.setStatut(nouveauStatut);
        patientDAO.update(patient);
    }
    
    /**
     * Récupérer les signes vitaux d'un patient
     */
    public List<SignesVitaux> getSignesVitauxByPatient(Long patientId) {
        return signesVitauxDAO.findByPatientId(patientId);
    }
    
    /**
     * Ajouter des signes vitaux à un patient existant
     */
    public void ajouterSignesVitaux(Long patientId, SignesVitaux signesVitaux) {
        Patient patient = getPatientById(patientId);
        signesVitaux.setPatient(patient);
        signesVitauxDAO.save(signesVitaux);
    }
}