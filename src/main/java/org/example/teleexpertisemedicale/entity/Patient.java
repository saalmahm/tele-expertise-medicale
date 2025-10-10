package org.example.teleexpertisemedicale.entity;

import jakarta.persistence.*;
import org.example.teleexpertisemedicale.enums.StatutPatient;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.time.format.DateTimeFormatter;


@Entity
@Table(name = "patients")
public class Patient {
    
    // @GeneratedValue: La valeur est auto-générée (auto-increment)
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false, length = 100)
    private String nom;
    
    @Column(nullable = false, length = 100)
    private String prenom;
    
    @Column(name = "date_naissance")
    private LocalDate dateNaissance;
    
    @Column(length = 1)
    private String sexe; // 'M' ou 'F'
    
    @Column(length = 20)
    private String telephone;
    
    @Column(length = 255)
    private String adresse;
    
    @Column(name = "date_enregistrement")
    private LocalDateTime dateEnregistrement;
    
    // @Enumerated: Pour stocker un ENUM dans la base de données
    // EnumType.STRING: Stocke le nom de l'enum (EN_ATTENTE, EN_CONSULTATION...)
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatutPatient statut;
    

    // mappedBy: Indique que c'est la classe SignesVitaux qui gère la relation
    // cascade: Les opérations sur Patient s'appliquent aussi aux SignesVitaux
    // orphanRemoval: Si on supprime un SignesVitaux de la liste, il est supprimé de la DB
    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<SignesVitaux> signesVitaux = new ArrayList<>();
    
    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Consultation> consultations = new ArrayList<>();
    
    public Patient() {
        this.dateEnregistrement = LocalDateTime.now();
        this.statut = StatutPatient.EN_ATTENTE;
    }
    
    public Patient(String nom, String prenom, LocalDate dateNaissance, String sexe) {
        this();
        this.nom = nom;
        this.prenom = prenom;
        this.dateNaissance = dateNaissance;
        this.sexe = sexe;
    }
    
    // Getters et Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
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
    
    public String getSexe() {
        return sexe;
    }
    
    public void setSexe(String sexe) {
        this.sexe = sexe;
    }
    
    public String getTelephone() {
        return telephone;
    }
    
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }
    
    public String getAdresse() {
        return adresse;
    }
    
    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }
    
    public LocalDateTime getDateEnregistrement() {
        return dateEnregistrement;
    }
    
    public void setDateEnregistrement(LocalDateTime dateEnregistrement) {
        this.dateEnregistrement = dateEnregistrement;
    }
    
    public StatutPatient getStatut() {
        return statut;
    }
    
    public void setStatut(StatutPatient statut) {
        this.statut = statut;
    }
    
    public List<SignesVitaux> getSignesVitaux() {
        return signesVitaux;
    }
    
    public void setSignesVitaux(List<SignesVitaux> signesVitaux) {
        this.signesVitaux = signesVitaux;
    }
    
    public List<Consultation> getConsultations() {
        return consultations;
    }
    
    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }
    
    // Méthodes pour gérer les relations bidirectionnelles
    public void addSignesVitaux(SignesVitaux sv) {
        signesVitaux.add(sv);
        sv.setPatient(this);
    }
    
    public void addConsultation(Consultation consultation) {
        consultations.add(consultation);
        consultation.setPatient(this);
    }

    public String getDateNaissanceFormatee() {
        return dateNaissance != null 
            ? dateNaissance.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) 
            : "";
    }

    public String getDateEnregistrementFormatee() {
        return dateEnregistrement != null 
            ? dateEnregistrement.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"))
            : "";
    }

    public String getHeureArrivee() {
        return dateEnregistrement != null 
            ? dateEnregistrement.format(DateTimeFormatter.ofPattern("HH:mm"))
            : "";
    }
    
    @Override
    public String toString() {
        return "Patient{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", statut=" + statut +
                '}';
    }
}