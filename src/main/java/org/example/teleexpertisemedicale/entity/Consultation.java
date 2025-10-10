package org.example.teleexpertisemedicale.entity;

import jakarta.persistence.*;
import org.example.teleexpertisemedicale.enums.StatutConsultation;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


@Entity
@Table(name = "consultations")
public class Consultation {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "date_consultation", nullable = false)
    private LocalDateTime dateConsultation;
    
    @Column(columnDefinition = "TEXT")
    private String diagnostic;
    
    @Column(columnDefinition = "TEXT")
    private String prescription;
    
    @Column(columnDefinition = "TEXT")
    private String observations;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatutConsultation statut;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medecin_id")
    private MedecinGeneraliste medecin;
    
    @OneToMany(mappedBy = "consultation", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ActeTechnique> actesTechniques = new ArrayList<>();
    
    // Constructeurs
    public Consultation() {
        this.dateConsultation = LocalDateTime.now();
        this.statut = StatutConsultation.EN_ATTENTE;
    }
    
    public Consultation(Patient patient, MedecinGeneraliste medecin) {
        this();
        this.patient = patient;
        this.medecin = medecin;
    }
    
    // Méthode pour calculer le coût total de la consultation
    public double calculerCoutTotal() {
        return actesTechniques.stream()
                .mapToDouble(ActeTechnique::getPrix)
                .sum();
    }
    
    // Getters et Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public LocalDateTime getDateConsultation() {
        return dateConsultation;
    }
    
    public void setDateConsultation(LocalDateTime dateConsultation) {
        this.dateConsultation = dateConsultation;
    }
    
    public String getDiagnostic() {
        return diagnostic;
    }
    
    public void setDiagnostic(String diagnostic) {
        this.diagnostic = diagnostic;
    }
    
    public String getPrescription() {
        return prescription;
    }
    
    public void setPrescription(String prescription) {
        this.prescription = prescription;
    }
    
    public String getObservations() {
        return observations;
    }
    
    public void setObservations(String observations) {
        this.observations = observations;
    }
    
    public StatutConsultation getStatut() {
        return statut;
    }
    
    public void setStatut(StatutConsultation statut) {
        this.statut = statut;
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
    
    public List<ActeTechnique> getActesTechniques() {
        return actesTechniques;
    }
    
    public void setActesTechniques(List<ActeTechnique> actesTechniques) {
        this.actesTechniques = actesTechniques;
    }
    
    // Méthode pour ajouter un acte technique
    public void addActeTechnique(ActeTechnique acte) {
        actesTechniques.add(acte);
        acte.setConsultation(this);
    }
    
    @Override
    public String toString() {
        return "Consultation{" +
                "id=" + id +
                ", dateConsultation=" + dateConsultation +
                ", statut=" + statut +
                '}';
    }
}