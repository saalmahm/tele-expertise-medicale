package org.example.teleexpertisemedicale.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.teleexpertisemedicale.entity.SignesVitaux;
import org.example.teleexpertisemedicale.util.HibernateUtil;

import java.util.List;

public class SignesVitauxDAO {
    
    public void save(SignesVitaux signesVitaux) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(signesVitaux);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la sauvegarde des signes vitaux", e);
        } finally {
            em.close();
        }
    }
    
    public SignesVitaux findById(Long id) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            return em.find(SignesVitaux.class, id);
        } finally {
            em.close();
        }
    }
    
    /**
     * Récupérer les signes vitaux d'un patient spécifique
     */
    public List<SignesVitaux> findByPatientId(Long patientId) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<SignesVitaux> query = em.createQuery(
                "SELECT sv FROM SignesVitaux sv WHERE sv.patient.id = :patientId ORDER BY sv.dateEnregistrement DESC",
                SignesVitaux.class
            );
            query.setParameter("patientId", patientId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Récupérer les derniers signes vitaux d'un patient
     */
    public SignesVitaux findLatestByPatientId(Long patientId) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<SignesVitaux> query = em.createQuery(
                "SELECT sv FROM SignesVitaux sv WHERE sv.patient.id = :patientId ORDER BY sv.dateEnregistrement DESC",
                SignesVitaux.class
            );
            query.setParameter("patientId", patientId);
            query.setMaxResults(1);  // Limiter à 1 résultat
            List<SignesVitaux> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }
    
    public void update(SignesVitaux signesVitaux) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(signesVitaux);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la mise à jour des signes vitaux", e);
        } finally {
            em.close();
        }
    }
}