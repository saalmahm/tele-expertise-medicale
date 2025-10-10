package org.example.teleexpertisemedicale.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.teleexpertisemedicale.entity.Consultation;
import org.example.teleexpertisemedicale.enums.StatutConsultation;
import org.example.teleexpertisemedicale.util.HibernateUtil;

import java.util.List;

public class ConsultationDAO {
    
    public void save(Consultation consultation) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(consultation);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la sauvegarde de la consultation", e);
        } finally {
            em.close();
        }
    }
    
    public Consultation findById(Long id) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            // Utiliser JOIN FETCH pour charger les actes techniques en même temps
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT c FROM Consultation c LEFT JOIN FETCH c.actesTechniques WHERE c.id = :id",
                Consultation.class
            );
            query.setParameter("id", id);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }
    
    public List<Consultation> findAll() {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT c FROM Consultation c ORDER BY c.dateConsultation DESC",
                Consultation.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Récupérer les consultations par statut
     */
    public List<Consultation> findByStatut(StatutConsultation statut) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT c FROM Consultation c WHERE c.statut = :statut ORDER BY c.dateConsultation",
                Consultation.class
            );
            query.setParameter("statut", statut);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Récupérer les consultations d'un patient
     */
    public List<Consultation> findByPatientId(Long patientId) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT c FROM Consultation c WHERE c.patient.id = :patientId ORDER BY c.dateConsultation DESC",
                Consultation.class
            );
            query.setParameter("patientId", patientId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public void update(Consultation consultation) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(consultation);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la mise à jour de la consultation", e);
        } finally {
            em.close();
        }
    }
    
    public void delete(Long id) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Consultation consultation = em.find(Consultation.class, id);
            if (consultation != null) {
                em.remove(consultation);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression de la consultation", e);
        } finally {
            em.close();
        }
    }
}