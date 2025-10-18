package org.example.teleexpertisemedicale.bootstrap;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.example.teleexpertisemedicale.dao.UserDAO;
import org.example.teleexpertisemedicale.entity.Infirmier;
import org.example.teleexpertisemedicale.entity.MedecinGeneraliste;
import org.example.teleexpertisemedicale.enums.Role;

@WebListener
public class DataSeeder implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        UserDAO userDAO = new UserDAO();

        // Si des utilisateurs existent déjà, ne rien faire
        if (userDAO.count() > 0) {
            System.out.println("✓ Utilisateurs déjà créés");
            return;
        }

        try {
            // Créer un infirmier
            Infirmier infirmier = new Infirmier();
            infirmier.setNom("Diallo");
            infirmier.setPrenom("Aicha");
            infirmier.setEmail("infirmier@test.com");
            infirmier.setPassword("123456");
            infirmier.setRole(Role.INFIRMIER);
            userDAO.save(infirmier);

            // Créer un médecin généraliste
            MedecinGeneraliste medecin = new MedecinGeneraliste();
            medecin.setNom("Traoré");
            medecin.setPrenom("Moussa");
            medecin.setEmail("medecin@test.com");
            medecin.setPassword("123456");
            medecin.setRole(Role.MEDECIN_GENERALISTE);
            userDAO.save(medecin);

        } catch (Exception e) {
            System.err.println("✗ Erreur lors de la création des utilisateurs");
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}