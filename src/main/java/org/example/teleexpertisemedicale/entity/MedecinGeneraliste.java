package org.example.teleexpertisemedicale.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;


@Entity
@Table(name = "medecins_generalistes")
public class MedecinGeneraliste {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false, length = 100)
    private String nom;
    
    @Column(nullable = false, length = 100)
    private String prenom;
    
    @Column(unique = true, nullable = false, length = 100)
    private String email;
    
    @Column(length = 20)
    private String telephone;
    
    @Column(name = "numero_ordre", unique = true, length = 50)
    private String numeroOrdre; // Numéro d'ordre des médecins
    
    @OneToMany(mappedBy = "medecin", cascade = CascadeType.ALL)
    private List<Consultation> consultations = new ArrayList<>();
    
    // Constructeurs
    public MedecinGeneraliste() {
    }
    
    public MedecinGeneraliste(String nom, String prenom, String email) {
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
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
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getTelephone() {
        return telephone;
    }
    
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }
    
    public String getNumeroOrdre() {
        return numeroOrdre;
    }
    
    public void setNumeroOrdre(String numeroOrdre) {
        this.numeroOrdre = numeroOrdre;
    }
    
    public List<Consultation> getConsultations() {
        return consultations;
    }
    
    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }
    
    public String getNomComplet() {
        return "Dr. " + prenom + " " + nom;
    }
    
    @Override
    public String toString() {
        return "MedecinGeneraliste{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                '}';
    }
}