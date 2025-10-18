package org.example.teleexpertisemedicale.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import org.example.teleexpertisemedicale.entity.User;
import org.example.teleexpertisemedicale.util.HibernateUtil;

public class UserDAO {

    public User findByEmailAndPassword(String email, String password) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            User user = em.createQuery(
                            "SELECT u FROM User u WHERE u.email = :email", User.class)
                    .setParameter("email", email)
                    .getSingleResult();

            // Vérifier le mot de passe
            if (user != null && password.equals(user.getPassword())) {
                return user;
            }
            return null;
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public void save(User user) {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    public long count() {
        EntityManager em = HibernateUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(u) FROM User u", Long.class)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }
}