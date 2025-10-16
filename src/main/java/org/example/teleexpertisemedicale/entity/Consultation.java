package org.example.teleexpertisemedicale.entity;

import jakarta.persistence.*;
import org.example.teleexpertisemedicale.enums.StatutConsultation;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

@Entity
public class Consultation {

    @Id
    @GeneratedValue
    private UUID id;

    private String raison;
    private String observation;
    private double prix = 150.00;

    @Enumerated(EnumType.STRING)
    private StatutConsultation statut;

    private LocalDateTime createdAt;

    @ManyToOne
    private MedecinGeneraliste medecinGeneraliste;

    @ManyToOne
    private Patient patient;

    @ManyToMany
    @JoinTable(
            name = "consultation_acte",
            joinColumns = @JoinColumn(name = "consultation_id"),
            inverseJoinColumns = @JoinColumn(name = "acte_id")
    )
    private Set<ActeTechnique> actes = new HashSet<>();

    @PrePersist
    public void prePersist() {
        createdAt = LocalDateTime.now();
        statut = StatutConsultation.EN_ATTENTE_AVIS;
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

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
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

    public MedecinGeneraliste getMedecinGeneraliste() {
        return medecinGeneraliste;
    }

    public void setMedecinGeneraliste(MedecinGeneraliste medecinGeneraliste) {
        this.medecinGeneraliste = medecinGeneraliste;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public Set<ActeTechnique> getActes() {
        return actes;
    }

    public void setActes(Set<ActeTechnique> actes) {
        this.actes = actes;
    }
}
