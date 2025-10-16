package org.example.teleexpertisemedicale.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Infirmier extends User {

    @OneToMany(mappedBy = "infirmier")
    private List<Patient> patients = new ArrayList<>();

    // Méthodes métiers
    public void enregistrerPatient(Patient patient) {
        patients.add(patient);
    }

    public List<Patient> voirListePatients() {
        return patients;
    }

    // Getters / Setters
    public List<Patient> getPatients() {
        return patients;
    }

    public void setPatients(List<Patient> patients) {
        this.patients = patients;
    }
}
