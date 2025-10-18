package org.example.teleexpertisemedicale.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.UUID;
import java.time.LocalDate;

@Entity
public class Patient {
    @Id
    @GeneratedValue
    private UUID id;

    private String nom;
    private String prenom;
    private String carte;
    private String telephone;
    private LocalDate dateNaissance;
    private String sexe;
    // Données médicales
    private String tension;
    private int frequenceCardiaque;
    private double temperature;
    private int frequenceRespiratoire;
    private double poids;
    private double taille;

    // Statut simple
    private boolean enAttente = true;

    private LocalDateTime createdAt = LocalDateTime.now();
    private LocalDateTime updatedAt = LocalDateTime.now();

    // Getters & setters

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

    public LocalDate getDateNaissance() {
        return dateNaissance;
    }


    public String getSexe() {
        return sexe;
    }

    public void setSexe(String sexe) {
        this.sexe = sexe;
    }
    public void setDateNaissance(LocalDate dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public String getTension() {
        return tension;
    }

    public void setTension(String tension) {
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

    public boolean isEnAttente() {
        return enAttente;
    }

    public void setEnAttente(boolean enAttente) {
        this.enAttente = enAttente;
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
}
