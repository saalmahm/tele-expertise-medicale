package org.example.teleexpertisemedicale.enums;

public enum TypeActe {
    RADIOGRAPHIE("Radiographie", 200.0),
    ECHOGRAPHIE("Échographie", 300.0),
    IRM("IRM", 800.0),
    ELECTROCARDIOGRAMME("Électrocardiogramme (ECG)", 150.0),
    DERMATOLOGIE("Consultation Dermatologie", 250.0),
    FOND_OEIL("Fond d'œil", 180.0),
    ANALYSE_SANG("Analyse de Sang", 120.0),
    ANALYSE_URINE("Analyse d'Urine", 100.0);
    
    private final String libelle;
    private final double prix;
    
    TypeActe(String libelle, double prix) {
        this.libelle = libelle;
        this.prix = prix;
    }
    
    public String getLibelle() {
        return libelle;
    }
    
    public double getPrix() {
        return prix;
    }
}