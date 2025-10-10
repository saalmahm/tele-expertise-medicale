package org.example.teleexpertisemedicale.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * Classe utilitaire pour gérer les connexions Hibernate
 * EntityManager: Interface pour interagir avec la base de données (CRUD)
 * EntityManagerFactory: Crée des EntityManager (coûteux à créer, donc singleton)
 */
public class HibernateUtil {
    
    // Singleton: Une seule instance pour toute l'application
    private static final EntityManagerFactory entityManagerFactory;
    
    static {
        try {
            // Créer l'EntityManagerFactory à partir du persistence.xml
            entityManagerFactory = Persistence.createEntityManagerFactory("tele-expertise-pu");
        } catch (Throwable ex) {
            System.err.println("Erreur initialisation EntityManagerFactory: " + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }
    
    /**
     * Obtenir l'EntityManagerFactory
     */
    public static EntityManagerFactory getEntityManagerFactory() {
        return entityManagerFactory;
    }
    
    /**
     * Créer un nouvel EntityManager
     */
    public static EntityManager getEntityManager() {
        return entityManagerFactory.createEntityManager();
    }
    
    /**
     * Fermer l'EntityManagerFactory (au shutdown de l'application)
     */
    public static void shutdown() {
        if (entityManagerFactory != null) {
            entityManagerFactory.close();
        }
    }
}