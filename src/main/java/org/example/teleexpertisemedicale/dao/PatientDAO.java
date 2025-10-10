package org.example.teleexpertisemedicale.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.teleexpertisemedicale.entity.Patient;
import org.example.teleexpertisemedicale.enums.StatutPatient;
import org.example.teleexpertisemedicale.util.HibernateUtil;

import java.time.LocalDate;
import java.util.List;

/**
 * DAO pour gérer les opérations CRUD sur les Patients
 */
public class PatientDAO {
    
    
      // Sauvegarder un nouveau patient dans la base de données
     
    public void save(Patient patient) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();  // Début de transaction
            em.persist(patient);           // INSERT dans la base
            em.getTransaction().commit();  // Valider la transaction
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();  // Annuler en cas d'erreur
            }
            throw new RuntimeException("Erreur lors de la sauvegarde du patient", e);
        } finally {
            em.close();  // TOUJOURS fermer l'EntityManager
        }
    }
    
 
    public Patient findById(Long id) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            return em.find(Patient.class, id);  // SELECT * FROM patients WHERE id = ?
        } finally {
            em.close();
        }
    }
    

    public List<Patient> findAll() {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            // JPQL: Java Persistence Query Language (similaire à SQL mais sur les objets)
            TypedQuery<Patient> query = em.createQuery("SELECT p FROM Patient p ORDER BY p.dateEnregistrement DESC", Patient.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Récupérer les patients du jour
     */
    public List<Patient> findPatientsOfDay(LocalDate date) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery(
                "SELECT p FROM Patient p WHERE DATE(p.dateEnregistrement) = :date ORDER BY p.dateEnregistrement",
                Patient.class
            );
            query.setParameter("date", date);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Récupérer les patients par statut
     */
    public List<Patient> findByStatut(StatutPatient statut) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery(
                "SELECT p FROM Patient p WHERE p.statut = :statut ORDER BY p.dateEnregistrement",
                Patient.class
            );
            query.setParameter("statut", statut);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Mettre à jour un patient existant
     */
    public void update(Patient patient) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(patient);  // UPDATE dans la base
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la mise à jour du patient", e);
        } finally {
            em.close();
        }
    }
    
    /**
     * Supprimer un patient
     */
    public void delete(Long id) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Patient patient = em.find(Patient.class, id);
            if (patient != null) {
                em.remove(patient);  // DELETE FROM patients WHERE id = ?
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression du patient", e);
        } finally {
            em.close();
        }
    }
}