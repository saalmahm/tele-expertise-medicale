package org.example.teleexpertisemedicale.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import org.example.teleexpertisemedicale.enums.StatutConsultation;
import java.util.ArrayList;
import java.util.List;

@Entity
public class MedecinGeneraliste extends User {

    @OneToMany(mappedBy = "medecinGeneraliste")
    private List<Consultation> consultations = new ArrayList<>();

    // Remplir une consultation
    public void remplirConsultation(Consultation consultation, String raison, String observation) {
        consultation.setRaison(raison);
        consultation.setObservation(observation);
        consultation.setStatut(StatutConsultation.TERMINEE);
    }

    // Getters / Setters

    public List<Consultation> getConsultations() {
        return consultations;
    }

    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }
}
