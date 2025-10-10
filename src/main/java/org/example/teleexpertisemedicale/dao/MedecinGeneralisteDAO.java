package org.example.teleexpertisemedicale.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.teleexpertisemedicale.entity.MedecinGeneraliste;
import org.example.teleexpertisemedicale.util.HibernateUtil;

import java.util.List;

public class MedecinGeneralisteDAO {
    
    public void save(MedecinGeneraliste medecin) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(medecin);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la sauvegarde du médecin", e);
        } finally {
            em.close();
        }
    }
    
    public MedecinGeneraliste findById(Long id) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            return em.find(MedecinGeneraliste.class, id);
        } finally {
            em.close();
        }
    }
    
    public List<MedecinGeneraliste> findAll() {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<MedecinGeneraliste> query = em.createQuery(
                "SELECT m FROM MedecinGeneraliste m ORDER BY m.nom, m.prenom",
                MedecinGeneraliste.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public MedecinGeneraliste findByEmail(String email) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            TypedQuery<MedecinGeneraliste> query = em.createQuery(
                "SELECT m FROM MedecinGeneraliste m WHERE m.email = :email",
                MedecinGeneraliste.class
            );
            query.setParameter("email", email);
            List<MedecinGeneraliste> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }
    
    public void update(MedecinGeneraliste medecin) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(medecin);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la mise à jour du médecin", e);
        } finally {
            em.close();
        }
    }
}