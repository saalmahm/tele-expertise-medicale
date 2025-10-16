package org.example.teleexpertisemedicale.entity;

import jakarta.persistence.*;
import org.example.teleexpertisemedicale.enums.StatutPatient;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Entity
public class Patient {

    @Id
    @GeneratedValue
    private UUID id;

    private String nom;
    private String prenom;
    private LocalDate dateNaissance;
    private String carte;
    private String telephone;

    private double tension;
    private int frequenceCardiaque;
    private double temperature;
    private int frequenceRespiratoire;
    private double poids;
    private double taille;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    @Enumerated(EnumType.STRING)
    private StatutPatient statut;

    @ManyToOne
    private Infirmier infirmier;

    @OneToMany(mappedBy = "patient")
    private List<Consultation> consultations;

    // --- Constructeur ---
    public Patient() {
        this.createdAt = LocalDateTime.now();
        this.statut = StatutPatient.EN_ATTENTE_AVIS;
    }

    // --- Getters & Setters ---


    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public LocalDate getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(LocalDate dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public String getCarte() {
        return carte;
    }

    public void setCarte(String carte) {
        this.carte = carte;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public double getTension() {
        return tension;
    }

    public void setTension(double tension) {
        this.tension = tension;
    }

    public int getFrequenceCardiaque() {
        return frequenceCardiaque;
    }

    public void setFrequenceCardiaque(int frequenceCardiaque) {
        this.frequenceCardiaque = frequenceCardiaque;
    }

    public double getTemperature() {
        return temperature;
    }

    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }

    public int getFrequenceRespiratoire() {
        return frequenceRespiratoire;
    }

    public void setFrequenceRespiratoire(int frequenceRespiratoire) {
        this.frequenceRespiratoire = frequenceRespiratoire;
    }

    public double getPoids() {
        return poids;
    }

    public void setPoids(double poids) {
        this.poids = poids;
    }

    public double getTaille() {
        return taille;
    }

    public void setTaille(double taille) {
        this.taille = taille;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public StatutPatient getStatut() {
        return statut;
    }

    public void setStatut(StatutPatient statut) {
        this.statut = statut;
    }

    public Infirmier getInfirmier() {
        return infirmier;
    }

    public void setInfirmier(Infirmier infirmier) {
        this.infirmier = infirmier;
    }

    public List<Consultation> getConsultations() {
        return consultations;
    }

    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }
}
