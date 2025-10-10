package org.example.teleexpertisemedicale.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.teleexpertisemedicale.entity.Patient;
import org.example.teleexpertisemedicale.entity.SignesVitaux;
import org.example.teleexpertisemedicale.service.PatientService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

/**
 * Servlet pour le Module Infirmier
 * URL: /infirmier
 * 
 * Fonctionnalités:
 * - Enregistrer un patient avec signes vitaux
 * - Consulter la liste des patients du jour
 * - Voir les statuts des patients
 */
@WebServlet("/infirmier/*")
public class InfirmierServlet extends HttpServlet {
    
    private PatientService patientService;
    
    @Override
    public void init() throws ServletException {
        // Initialiser le service au démarrage du servlet
        patientService = new PatientService();
    }
    
    /**
     * Méthode GET: Afficher les pages
     * Exemples d'URLs:
     * - /infirmier/patients -> Liste des patients
     * - /infirmier/enregistrer -> Formulaire d'enregistrement
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo(); // Partie après /infirmier
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Page d'accueil infirmier
            request.getRequestDispatcher("/WEB-INF/views/infirmier/home.jsp").forward(request, response);
        }
        else if (pathInfo.equals("/patients")) {
            // Liste des patients du jour
            List<Patient> patients = patientService.getPatientsOfToday();
            request.setAttribute("patients", patients);
            request.getRequestDispatcher("/WEB-INF/views/infirmier/patients.jsp").forward(request, response);
        }
        else if (pathInfo.equals("/enregistrer")) {
            // Formulaire d'enregistrement patient
            request.getRequestDispatcher("/WEB-INF/views/infirmier/enregistrer-patient.jsp").forward(request, response);
        }
        else if (pathInfo.equals("/tous-patients")) {
            // Tous les patients (pas seulement du jour)
            List<Patient> patients = patientService.getAllPatients();
            request.setAttribute("patients", patients);
            request.getRequestDispatcher("/WEB-INF/views/infirmier/tous-patients.jsp").forward(request, response);
        }
        else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    /**
     * Méthode POST: Traiter les formulaires
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String pathInfo = request.getPathInfo();
        
        if (pathInfo.equals("/enregistrer")) {
            // Enregistrer un nouveau patient avec signes vitaux
            try {
                // Récupérer les données du formulaire
                String nom = request.getParameter("nom");
                String prenom = request.getParameter("prenom");
                String dateNaissanceStr = request.getParameter("dateNaissance");
                String sexe = request.getParameter("sexe");
                String telephone = request.getParameter("telephone");
                String adresse = request.getParameter("adresse");
                
                // Signes vitaux
                String tension = request.getParameter("tension");
                String temperatureStr = request.getParameter("temperature");
                String poidsStr = request.getParameter("poids");
                String tailleStr = request.getParameter("taille");
                String frequenceStr = request.getParameter("frequenceCardiaque");
                
                // Créer le patient
                Patient patient = new Patient();
                patient.setNom(nom);
                patient.setPrenom(prenom);
                patient.setDateNaissance(LocalDate.parse(dateNaissanceStr));
                patient.setSexe(sexe);
                patient.setTelephone(telephone);
                patient.setAdresse(adresse);
                
                // Créer les signes vitaux
                SignesVitaux signesVitaux = new SignesVitaux();
                signesVitaux.setTension(tension);
                signesVitaux.setTemperature(Double.parseDouble(temperatureStr));
                signesVitaux.setPoids(Double.parseDouble(poidsStr));
                signesVitaux.setTaille(Double.parseDouble(tailleStr));
                signesVitaux.setFrequenceCardiaque(Integer.parseInt(frequenceStr));
                
                // Enregistrer via le service
                patientService.enregistrerPatientAvecSignesVitaux(patient, signesVitaux);
                
                request.getSession().setAttribute("successMessage", 
                    "Patient " + patient.getPrenom() + " " + patient.getNom() + " enregistré avec succès!");
                
                response.sendRedirect(request.getContextPath() + "/infirmier/patients");
                
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Erreur lors de l'enregistrement: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/views/infirmier/enregistrer-patient.jsp").forward(request, response);
            }
        }
        else if (pathInfo.equals("/ajouter-signes")) {
            // Ajouter des signes vitaux à un patient existant
            try {
                Long patientId = Long.parseLong(request.getParameter("patientId"));
                String tension = request.getParameter("tension");
                Double temperature = Double.parseDouble(request.getParameter("temperature"));
                Double poids = Double.parseDouble(request.getParameter("poids"));
                Double taille = Double.parseDouble(request.getParameter("taille"));
                Integer frequence = Integer.parseInt(request.getParameter("frequenceCardiaque"));
                
                SignesVitaux signesVitaux = new SignesVitaux(tension, temperature, poids, taille, frequence);
                patientService.ajouterSignesVitaux(patientId, signesVitaux);
                
                request.getSession().setAttribute("successMessage", "Signes vitaux ajoutés avec succès!");
                response.sendRedirect(request.getContextPath() + "/infirmier/patients");
                
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Erreur: " + e.getMessage());
                doGet(request, response);
            }
        }
    }
}