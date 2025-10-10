package org.example.teleexpertisemedicale.entity;

import jakarta.persistence.*;

/**
 * Entité ActeTechnique - Représente un acte médical technique effectué lors d'une consultation
 * Ex: Radiographie, Prise de sang, ECG, etc.
 */
@Entity
@Table(name = "actes_techniques")
public class ActeTechnique {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false, length = 200)
    private String libelle; // Nom de l'acte (Ex: "Radiographie thorax")
    
    @Column(unique = true, nullable = false, length = 50)
    private String code; // Code de l'acte (Ex: "RADIO-001")
    
    @Column(nullable = false)
    private Double prix;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consultation_id")
    private Consultation consultation;
    
    // Constructeurs
    public ActeTechnique() {
    }
    
    public ActeTechnique(String libelle, String code, Double prix) {
        this.libelle = libelle;
        this.code = code;
        this.prix = prix;
    }
    
    // Getters et Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getLibelle() {
        return libelle;
    }
    
    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }
    
    public String getCode() {
        return code;
    }
    
    public void setCode(String code) {
        this.code = code;
    }
    
    public Double getPrix() {
        return prix;
    }
    
    public void setPrix(Double prix) {
        this.prix = prix;
    }
    
    public Consultation getConsultation() {
        return consultation;
    }
    
    public void setConsultation(Consultation consultation) {
        this.consultation = consultation;
    }
    
    @Override
    public String toString() {
        return "ActeTechnique{" +
                "id=" + id +
                ", libelle='" + libelle + '\'' +
                ", code='" + code + '\'' +
                ", prix=" + prix +
                '}';
    }
}