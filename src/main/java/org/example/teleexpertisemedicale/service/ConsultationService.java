package org.example.teleexpertisemedicale.service;

import org.example.teleexpertisemedicale.dao.ConsultationDAO;
import org.example.teleexpertisemedicale.dao.PatientDAO;
import org.example.teleexpertisemedicale.entity.Consultation;
import org.example.teleexpertisemedicale.entity.Patient;
import org.example.teleexpertisemedicale.enums.StatutConsultation;
import org.example.teleexpertisemedicale.enums.TypeActe;

import java.util.List;
import java.util.UUID;

public class ConsultationService {
    
    private final ConsultationDAO consultationDAO;
    private final PatientDAO patientDAO;
    
    public ConsultationService() {
        this.consultationDAO = new ConsultationDAO();
        this.patientDAO = new PatientDAO();
    }
    
    /**
     * Créer une nouvelle consultation pour un patient
     */
    public Consultation creerConsultation(UUID patientId, UUID medecinId) {
        Patient patient = patientDAO.findById(patientId);
        if (patient == null) {
            throw new IllegalArgumentException("Patient non trouvé");
        }
        
        Consultation consultation = new Consultation();
        consultation.setPatient(patient);
        consultation.setStatut(StatutConsultation.EN_ATTENTE_AVIS_SPECIALISTE);
        
        // Marquer le patient comme n'étant plus en attente
        patient.setEnAttente(false);
        patientDAO.update(patient);
        
        consultationDAO.save(consultation);
        return consultation;
    }
    
    /**
     * Ajouter un acte technique à une consultation
     */
    public void ajouterActeTechnique(UUID consultationId, String codeActe) {
        Consultation consultation = consultationDAO.findById(consultationId);
        if (consultation == null) {
            throw new IllegalArgumentException("Consultation non trouvée");
        }
        // Logique pour ajouter un acte technique si nécessaire
        consultationDAO.update(consultation);
    }
    
    /**
     * Terminer une consultation
     */
    public void terminerConsultation(UUID consultationId, String diagnostic, String prescription, String observations) {
        Consultation consultation = consultationDAO.findById(consultationId);
        if (consultation == null) {
            throw new IllegalArgumentException("Consultation non trouvée");
        }
        
        consultation.setRaison(diagnostic);
        consultation.setObservation(observations);
        consultation.setStatut(StatutConsultation.TERMINEE);
        consultationDAO.update(consultation);
    }
    
    /**
     * Récupérer toutes les consultations
     */
    public List<Consultation> getAllConsultations() {
        return consultationDAO.findAll();
    }
    
    /**
     * Récupérer une consultation par ID avec ses actes chargés
     */
    public Consultation getConsultationByIdWithActes(UUID id) {
        return consultationDAO.findByIdWithActes(id);
    }
        
    /**
     * Récupérer les consultations d'un patient
     */
    public List<Consultation> getConsultationsByPatient(UUID patientId) {
        return consultationDAO.findByPatientId(patientId);
    }
    
    /**
     * Calculer le coût total d'une consultation
     */
    public double calculerCoutTotal(UUID consultationId) {
        Consultation consultation = consultationDAO.findById(consultationId);
        if (consultation == null) {
            return 0.0;
        }
        return consultation.getPrixTotal();
    }

/**
 * Créer une consultation complète avec actes techniques
 */
public Consultation creerConsultationComplete(UUID patientId, String raison, String observations,
                                               List<TypeActe> actes, boolean besoinAvisExpertise) {
    Patient patient = patientDAO.findById(patientId);
    if (patient == null) {
        throw new IllegalArgumentException("Patient non trouvé");
    }
    
    Consultation consultation = new Consultation();
    consultation.setPatient(patient);
    consultation.setRaison(raison);
    consultation.setObservation(observations);
    consultation.setActes(actes);
    consultation.setBesoinAvisExpertise(besoinAvisExpertise);
    
    // Calculer le prix total
    consultation.calculerPrixTotal();
    
    // Définir le statut
    if (besoinAvisExpertise) {
        consultation.setStatut(StatutConsultation.EN_ATTENTE_AVIS_SPECIALISTE);
    } else {
        consultation.setStatut(StatutConsultation.TERMINEE);
    }
    
    // Marquer le patient comme n'étant plus en attente
    patient.setEnAttente(false);
    patientDAO.update(patient);
    
    consultationDAO.save(consultation);
    return consultation;
}
}