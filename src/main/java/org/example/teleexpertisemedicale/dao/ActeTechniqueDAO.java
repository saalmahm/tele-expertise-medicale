package org.example.teleexpertisemedicale.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.teleexpertisemedicale.entity.ActeTechnique;
import org.example.teleexpertisemedicale.util.HibernateUtil;

import java.util.List;

public class ActeTechniqueDAO {
    
    public void save(ActeTechnique acteTechnique) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(acteTechnique);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la sauvegarde de l'acte technique", e);
        } finally {
            em.close();
        }
    }
    
    public ActeTechnique findById(Long id) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            return em.find(ActeTechnique.class, id);
        } finally {
            em.close();
        }
    }
    
    /**
     * Récupérer tous les actes techniques disponibles (catalogue)
     */
    public List<ActeTechnique> findAll() {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<ActeTechnique> query = em.createQuery(
                "SELECT a FROM ActeTechnique a WHERE a.consultation IS NULL ORDER BY a.libelle",
                ActeTechnique.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Récupérer les actes d'une consultation
     */
    public List<ActeTechnique> findByConsultationId(Long consultationId) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<ActeTechnique> query = em.createQuery(
                "SELECT a FROM ActeTechnique a WHERE a.consultation.id = :consultationId",
                ActeTechnique.class
            );
            query.setParameter("consultationId", consultationId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Rechercher un acte par code
     */
    public ActeTechnique findByCode(String code) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<ActeTechnique> query = em.createQuery(
                "SELECT a FROM ActeTechnique a WHERE a.code = :code",
                ActeTechnique.class
            );
            query.setParameter("code", code);
            List<ActeTechnique> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }
    
    public void update(ActeTechnique acteTechnique) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(acteTechnique);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la mise à jour de l'acte technique", e);
        } finally {
            em.close();
        }
    }
}