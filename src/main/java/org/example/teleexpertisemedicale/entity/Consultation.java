package org.example.teleexpertisemedicale.entity;

import jakarta.persistence.*;
import org.example.teleexpertisemedicale.enums.StatutConsultation;
import org.example.teleexpertisemedicale.enums.TypeActe;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
public class Consultation {
    @Id
    @GeneratedValue
    private UUID id;

    private String raison;
    private String observation;
    
    @Column(name = "prix_consultation")
    private double prixConsultation = 150.0;

    @Column(name = "prix_total")
    private double prixTotal;
    
    @Column(name = "besoin_avis_expertise")
    private boolean besoinAvisExpertise = false;

    @ElementCollection
    @CollectionTable(name = "consultation_actes", joinColumns = @JoinColumn(name = "consultation_id"))
    @Enumerated(EnumType.STRING)
    @Column(name = "acte_type")
    private List<TypeActe> actes = new ArrayList<>();

    @Enumerated(EnumType.STRING)
    private StatutConsultation statut;

    private LocalDateTime createdAt = LocalDateTime.now();

    // Relations
    @ManyToOne
    private Patient patient;

    @ManyToOne
    private MedecinGeneraliste medecin;

    // Constructeur
    public Consultation() {
        this.statut = null;
    }

    // Méthodes métier
    public void terminer() {
        this.statut = StatutConsultation.TERMINEE;
    }

    public void demanderAvisSpecialiste() {
        this.statut = StatutConsultation.EN_ATTENTE_AVIS_SPECIALISTE;
    }
    
    /**
     * Calculer le prix total : consultation + actes
     */
    public void calculerPrixTotal() {
        double total = this.prixConsultation;
        for (TypeActe acte : actes) {
            total += acte.getPrix();
        }
        this.prixTotal = total;
    }

    // Getters & Setters
    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getRaison() {
        return raison;
    }

    public void setRaison(String raison) {
        this.raison = raison;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    public double getPrixConsultation() {
        return prixConsultation;
    }

    public void setPrixConsultation(double prixConsultation) {
        this.prixConsultation = prixConsultation;
    }

    public double getPrixTotal() {
        return prixTotal;
    }

    public void setPrixTotal(double prixTotal) {
        this.prixTotal = prixTotal;
    }

    public boolean isBesoinAvisExpertise() {
        return besoinAvisExpertise;
    }

    public void setBesoinAvisExpertise(boolean besoinAvisExpertise) {
        this.besoinAvisExpertise = besoinAvisExpertise;
    }

    public List<TypeActe> getActes() {
        return actes;
    }

    public void setActes(List<TypeActe> actes) {
        this.actes = actes;
    }

    public StatutConsultation getStatut() {
        return statut;
    }

    public void setStatut(StatutConsultation statut) {
        this.statut = statut;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public MedecinGeneraliste getMedecin() {
        return medecin;
    }

    public void setMedecin(MedecinGeneraliste medecin) {
        this.medecin = medecin;
    }
}