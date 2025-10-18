package org.example.teleexpertisemedicale.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.teleexpertisemedicale.entity.Patient;
import org.example.teleexpertisemedicale.util.HibernateUtil;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public class PatientDAO {
    
    public void save(Patient patient) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(patient);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la sauvegarde du patient", e);
        } finally {
            em.close();
        }
    }
    
    public Patient findById(UUID id) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            return em.find(Patient.class, id);
        } finally {
            em.close();
        }
    }
    
    public List<Patient> findAll() {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery(
                "SELECT p FROM Patient p ORDER BY p.createdAt DESC", 
                Patient.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Récupérer les patients du jour (cree ou modifier aujourd'hui)
     */
    public List<Patient> findPatientsOfDay(LocalDate date) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            // Convertir LocalDate en LocalDateTime pour comparaison
            LocalDateTime startOfDay = date.atStartOfDay();
            LocalDateTime endOfDay = date.plusDays(1).atStartOfDay();

            TypedQuery<Patient> query = em.createQuery(
                "SELECT p FROM Patient p WHERE " +
                "(p.createdAt >= :startOfDay AND p.createdAt < :endOfDay) OR " +
                "(p.updatedAt >= :startOfDay AND p.updatedAt < :endOfDay) " +
                "ORDER BY p.updatedAt DESC",
                Patient.class
            );
            query.setParameter("startOfDay", startOfDay);
            query.setParameter("endOfDay", endOfDay);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Récupérer les patients en attente
     */
    public List<Patient> findByEnAttente(boolean enAttente) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery(
                "SELECT p FROM Patient p WHERE p.enAttente = :enAttente ORDER BY p.createdAt ASC",
                Patient.class
            );
            query.setParameter("enAttente", enAttente);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    /**
     * Rechercher un patient par son numéro de carte
     */
    public Patient findByCarte(String carte) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery(
                "SELECT p FROM Patient p WHERE p.carte = :carte",
                Patient.class
            );
            query.setParameter("carte", carte);
            List<Patient> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
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
            em.merge(patient);
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
}