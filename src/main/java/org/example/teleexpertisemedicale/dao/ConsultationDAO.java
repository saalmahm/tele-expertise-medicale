package org.example.teleexpertisemedicale.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.teleexpertisemedicale.entity.Consultation;
import org.example.teleexpertisemedicale.enums.StatutConsultation;
import org.example.teleexpertisemedicale.util.HibernateUtil;

import java.util.List;
import java.util.UUID;

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

    public Consultation findById(UUID id) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            return em.find(Consultation.class, id);
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Trouver une consultation par ID avec ses actes chargés (évite LazyInitializationException)
     */
    public Consultation findByIdWithActes(UUID id) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                    "SELECT c FROM Consultation c LEFT JOIN FETCH c.actes WHERE c.id = :id",
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
                    "SELECT c FROM Consultation c ORDER BY c.createdAt DESC",
                    Consultation.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Consultation> findByPatientId(UUID patientId) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                    "SELECT c FROM Consultation c WHERE c.patient.id = :patientId ORDER BY c.createdAt DESC",
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
}