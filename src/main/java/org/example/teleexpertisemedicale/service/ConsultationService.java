package org.example.teleexpertisemedicale.service;

import org.example.teleexpertisemedicale.dao.ActeTechniqueDAO;
import org.example.teleexpertisemedicale.dao.ConsultationDAO;
import org.example.teleexpertisemedicale.dao.PatientDAO;
import org.example.teleexpertisemedicale.entity.ActeTechnique;
import org.example.teleexpertisemedicale.entity.Consultation;
import org.example.teleexpertisemedicale.entity.Patient;
import org.example.teleexpertisemedicale.enums.StatutConsultation;
import org.example.teleexpertisemedicale.enums.StatutPatient;

import java.util.List;

/**
 * Service pour la logique métier liée aux consultations
 */
public class ConsultationService {
    
    private final ConsultationDAO consultationDAO;
    private final PatientDAO patientDAO;
    private final ActeTechniqueDAO acteTechniqueDAO;
    
    public ConsultationService() {
        this.consultationDAO = new ConsultationDAO();
        this.patientDAO = new PatientDAO();
        this.acteTechniqueDAO = new ActeTechniqueDAO();
    }
    
    /**
     * Créer une nouvelle consultation pour un patient
     */
    public Consultation creerConsultation(Long patientId, Long medecinId) {
        // Récupérer le patient
        Patient patient = patientDAO.findById(patientId);
        if (patient == null) {
            throw new IllegalArgumentException("Patient non trouvé");
        }
        
        // Créer la consultation
        Consultation consultation = new Consultation();
        consultation.setPatient(patient);
        consultation.setStatut(StatutConsultation.EN_COURS);
        
        // Changer le statut du patient
        patient.setStatut(StatutPatient.EN_CONSULTATION);
        patientDAO.update(patient);
        
        // Sauvegarder la consultation
        consultationDAO.save(consultation);
        
        return consultation;
    }
    
    /**
     * Ajouter un acte technique à une consultation
     */
    public void ajouterActeTechnique(Long consultationId, String codeActe) {
        // Récupérer la consultation
        Consultation consultation = consultationDAO.findById(consultationId);
        if (consultation == null) {
            throw new IllegalArgumentException("Consultation non trouvée");
        }
        
        // Récupérer l'acte technique par code
        ActeTechnique acteOriginal = acteTechniqueDAO.findByCode(codeActe);
        if (acteOriginal == null) {
            throw new IllegalArgumentException("Acte technique non trouvé: " + codeActe);
        }
        
        // Créer une copie de l'acte pour cette consultation
        ActeTechnique nouvelActe = new ActeTechnique();
        nouvelActe.setLibelle(acteOriginal.getLibelle());
        nouvelActe.setCode(codeActe + "-" + System.currentTimeMillis()); // Code unique
        nouvelActe.setPrix(acteOriginal.getPrix());
        nouvelActe.setConsultation(consultation);
        
        acteTechniqueDAO.save(nouvelActe);
    }
    
    /**
     * Terminer une consultation
     */
    public void terminerConsultation(Long consultationId, String diagnostic, String prescription, String observations) {
        Consultation consultation = consultationDAO.findById(consultationId);
        if (consultation == null) {
            throw new IllegalArgumentException("Consultation non trouvée");
        }
        
        // Mettre à jour la consultation
        consultation.setDiagnostic(diagnostic);
        consultation.setPrescription(prescription);
        consultation.setObservations(observations);
        consultation.setStatut(StatutConsultation.TERMINEE);
        consultationDAO.update(consultation);
        
        // Mettre à jour le statut du patient
        Patient patient = consultation.getPatient();
        patient.setStatut(StatutPatient.TERMINE);
        patientDAO.update(patient);
    }
    
    /**
     * Récupérer toutes les consultations
     */
    public List<Consultation> getAllConsultations() {
        return consultationDAO.findAll();
    }
    
    /**
     * Récupérer une consultation par ID
     */
    public Consultation getConsultationById(Long id) {
        return consultationDAO.findById(id);
    }
    
    /**
     * Récupérer les consultations d'un patient
     */
    public List<Consultation> getConsultationsByPatient(Long patientId) {
        return consultationDAO.findByPatientId(patientId);
    }
    
    /**
     * Calculer le coût total d'une consultation
     */
    public double calculerCoutTotal(Long consultationId) {
        Consultation consultation = consultationDAO.findById(consultationId);
        if (consultation == null) {
            return 0.0;
        }
        return consultation.calculerCoutTotal();
    }
}