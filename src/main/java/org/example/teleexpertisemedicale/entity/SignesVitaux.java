package org.example.teleexpertisemedicale.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Un patient peut avoir plusieurs enregistrements de signes vitaux
 */
@Entity
@Table(name = "signes_vitaux")
public class SignesVitaux {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(length = 20)
    private String tension; // Ex: "120/80"
    
    private Double temperature; // En degrés Celsius
    
    private Double poids; // En kg
    
    private Double taille; // En cm
    
    @Column(name = "frequence_cardiaque")
    private Integer frequenceCardiaque; // Battements par minute
    
    @Column(name = "date_enregistrement", nullable = false)
    private LocalDateTime dateEnregistrement;
    
    // @ManyToOne: Plusieurs SignesVitaux appartiennent à un Patient
    // @JoinColumn: Spécifie le nom de la colonne de la clé étrangère
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;
    
    // Constructeurs
    public SignesVitaux() {
        this.dateEnregistrement = LocalDateTime.now();
    }
    
    public SignesVitaux(String tension, Double temperature, Double poids, Double taille, Integer frequenceCardiaque) {
        this();
        this.tension = tension;
        this.temperature = temperature;
        this.poids = poids;
        this.taille = taille;
        this.frequenceCardiaque = frequenceCardiaque;
    }
    
    // Getters et Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getTension() {
        return tension;
    }
    
    public void setTension(String tension) {
        this.tension = tension;
    }
    
    public Double getTemperature() {
        return temperature;
    }
    
    public void setTemperature(Double temperature) {
        this.temperature = temperature;
    }
    
    public Double getPoids() {
        return poids;
    }
    
    public void setPoids(Double poids) {
        this.poids = poids;
    }
    
    public Double getTaille() {
        return taille;
    }
    
    public void setTaille(Double taille) {
        this.taille = taille;
    }
    
    public Integer getFrequenceCardiaque() {
        return frequenceCardiaque;
    }
    
    public void setFrequenceCardiaque(Integer frequenceCardiaque) {
        this.frequenceCardiaque = frequenceCardiaque;
    }
    
    public LocalDateTime getDateEnregistrement() {
        return dateEnregistrement;
    }
    
    public void setDateEnregistrement(LocalDateTime dateEnregistrement) {
        this.dateEnregistrement = dateEnregistrement;
    }
    
    public Patient getPatient() {
        return patient;
    }
    
    public void setPatient(Patient patient) {
        this.patient = patient;
    }
    
    @Override
    public String toString() {
        return "SignesVitaux{" +
                "id=" + id +
                ", tension='" + tension + '\'' +
                ", temperature=" + temperature +
                ", poids=" + poids +
                '}';
    }
}