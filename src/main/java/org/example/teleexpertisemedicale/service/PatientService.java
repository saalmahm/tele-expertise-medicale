package org.example.teleexpertisemedicale.service;

import org.example.teleexpertisemedicale.dao.PatientDAO;
import org.example.teleexpertisemedicale.entity.Patient;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public class PatientService {
    
    private final PatientDAO patientDAO;
    
    public PatientService() {
        this.patientDAO = new PatientDAO();
    }
    
    /**
     * Enregistrer un nouveau patient
     */
   /**
 * Enregistrer un nouveau patient OU mettre à jour les signes vitaux s'il existe
 */
public Patient enregistrerPatient(Patient patient) {
    // Validation
    if (patient.getNom() == null || patient.getNom().trim().isEmpty()) {
        throw new IllegalArgumentException("Le nom du patient est obligatoire");
    }
    if (patient.getPrenom() == null || patient.getPrenom().trim().isEmpty()) {
        throw new IllegalArgumentException("Le prénom du patient est obligatoire");
    }
    if (patient.getCarte() == null || patient.getCarte().trim().isEmpty()) {
        throw new IllegalArgumentException("Le numéro de carte est obligatoire");
    }
    
    // Vérifier si le patient existe déjà par numéro de carte
    Patient patientExistant = patientDAO.findByCarte(patient.getCarte());
    
    if (patientExistant != null) {
        // Patient existe → Mettre à jour SEULEMENT les signes vitaux
        patientExistant.setTension(patient.getTension());
        patientExistant.setFrequenceCardiaque(patient.getFrequenceCardiaque());
        patientExistant.setTemperature(patient.getTemperature());
        patientExistant.setFrequenceRespiratoire(patient.getFrequenceRespiratoire());
        patientExistant.setPoids(patient.getPoids());
        patientExistant.setTaille(patient.getTaille());
        patientExistant.setEnAttente(true); // Remettre en attente
        patientExistant.setUpdatedAt(java.time.LocalDateTime.now());
        
        patientDAO.update(patientExistant);
        return patientExistant;
    } else {
        // Patient n'existe pas → Créer nouveau patient avec toutes les infos
        patientDAO.save(patient);
        return patient;
    }
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
     * Récupérer les patients en attente
     */
    public List<Patient> getPatientsEnAttente() {
        return patientDAO.findByEnAttente(true);
    }
    
    public Patient getPatientById(UUID id) {
        Patient patient = patientDAO.findById(id);
        if (patient == null) {
            throw new IllegalArgumentException("Patient non trouvé avec l'ID: " + id);
        }
        return patient;
    }
    
    /**
     * Mettre à jour un patient
     */
    public void updatePatient(Patient patient) {
        patientDAO.update(patient);
    }
        /**
     * Rechercher un patient par numéro de carte
     */
    public Patient rechercherParCarte(String carte) {
        return patientDAO.findByCarte(carte);
    }
}