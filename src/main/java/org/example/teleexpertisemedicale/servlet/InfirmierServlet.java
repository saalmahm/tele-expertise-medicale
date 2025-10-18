package org.example.teleexpertisemedicale.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.teleexpertisemedicale.entity.Patient;
import org.example.teleexpertisemedicale.service.PatientService;

import java.util.ArrayList;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@WebServlet("/infirmier/*")
public class InfirmierServlet extends HttpServlet {
    
    private PatientService patientService;
    
    @Override
    public void init() throws ServletException {
        patientService = new PatientService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/infirmier/accueil");
        }
        else if (pathInfo.equals("/accueil")) {
            request.getRequestDispatcher("/WEB-INF/views/infirmier/home.jsp").forward(request, response);
        }
        else if (pathInfo.equals("/patients")) {
            List<Patient> patients = patientService.getPatientsOfToday();
            request.setAttribute("patients", patients);
            request.getRequestDispatcher("/WEB-INF/views/infirmier/patients.jsp").forward(request, response);
        }
        else if (pathInfo.equals("/enregistrer")) {
            request.getRequestDispatcher("/WEB-INF/views/infirmier/enregistrer-patient.jsp").forward(request, response);
        }
        else if (pathInfo.equals("/tous-patients")) {
            List<Patient> patients = patientService.getAllPatients();
            request.setAttribute("patients", patients);
            request.getRequestDispatcher("/WEB-INF/views/infirmier/tous-patients.jsp").forward(request, response);
        }
        else if (pathInfo.equals("/rechercher-patient")) {
        // Page de recherche par carte
        request.getRequestDispatcher("/WEB-INF/views/infirmier/rechercher-patient.jsp").forward(request, response);
            }

        else if (pathInfo.equals("/mettre-a-jour-signes")) {
            // Formulaire pour mettre à jour les signes vitaux d'un patient existant
            String patientIdStr = request.getParameter("id");
            if (patientIdStr != null) {
                UUID patientId = UUID.fromString(patientIdStr);
                Patient patient = patientService.getPatientById(patientId);
                request.setAttribute("patient", patient);
                request.getRequestDispatcher("/WEB-INF/views/infirmier/mettre-a-jour-signes.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/infirmier/rechercher-patient");
            }
            }
            else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String pathInfo = request.getPathInfo();
        
        if (pathInfo.equals("/enregistrer")) {
            try {
                // Récupérer les données du formulaire
                String nom = request.getParameter("nom");
                String prenom = request.getParameter("prenom");
                String dateNaissanceStr = request.getParameter("dateNaissance");
                String carte = request.getParameter("carte");
                String telephone = request.getParameter("telephone");
                String sexe = request.getParameter("sexe");  
                // Signes vitaux
                String tensionStr = request.getParameter("tension");
                String temperatureStr = request.getParameter("temperature");
                String poidsStr = request.getParameter("poids");
                String tailleStr = request.getParameter("taille");
                String frequenceCardiaqueStr = request.getParameter("frequenceCardiaque");
                String frequenceRespiratoire = request.getParameter("frequenceRespiratoire");
                
                // Créer le patient avec toutes les données
                Patient patient = new Patient();
                patient.setNom(nom);
                patient.setPrenom(prenom);
                patient.setDateNaissance(LocalDate.parse(dateNaissanceStr));
                patient.setCarte(carte);
                patient.setTelephone(telephone);
                patient.setSexe(sexe);
                // Ajouter les signes vitaux directement
                if (tensionStr != null && !tensionStr.isEmpty()) {
                    patient.setTension(tensionStr); 
                }
                if (temperatureStr != null && !temperatureStr.isEmpty()) {
                    patient.setTemperature(Double.parseDouble(temperatureStr));
                }
                if (poidsStr != null && !poidsStr.isEmpty()) {
                    patient.setPoids(Double.parseDouble(poidsStr));
                }
                if (tailleStr != null && !tailleStr.isEmpty()) {
                    patient.setTaille(Double.parseDouble(tailleStr));
                }
                if (frequenceCardiaqueStr != null && !frequenceCardiaqueStr.isEmpty()) {
                    patient.setFrequenceCardiaque(Integer.parseInt(frequenceCardiaqueStr));
                }
                if (frequenceRespiratoire != null && !frequenceRespiratoire.isEmpty()) {
                    patient.setFrequenceRespiratoire(Integer.parseInt(frequenceRespiratoire));
                }
                
                // Enregistrer le patient
                patientService.enregistrerPatient(patient);
                
                request.getSession().setAttribute("successMessage", 
                    "Patient " + patient.getPrenom() + " " + patient.getNom() + " enregistré avec succès!");
response.sendRedirect(request.getContextPath() + "/infirmier/patients");                                
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Erreur lors de l'enregistrement: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/views/infirmier/enregistrer-patient.jsp").forward(request, response);
            }
        }else if (pathInfo.equals("/rechercher-patient")) {
    // Rechercher un patient par numéro de carte
    String carte = request.getParameter("carte");
    
    if (carte == null || carte.trim().isEmpty()) {
        request.setAttribute("errorMessage", "Veuillez entrer un numéro de carte");
        request.getRequestDispatcher("/WEB-INF/views/infirmier/rechercher-patient.jsp").forward(request, response);
        return;
    }
    
    Patient patient = patientService.rechercherParCarte(carte);
    
    if (patient != null) {
        // Patient trouvé → Rediriger vers formulaire de mise à jour des signes
        response.sendRedirect(request.getContextPath() + "/infirmier/mettre-a-jour-signes?id=" + patient.getId());
    } else {
        // Patient non trouvé → Rediriger vers création avec carte pré-remplie
        request.getSession().setAttribute("carteRecherchee", carte);
        request.setAttribute("infoMessage", "Aucun patient trouvé avec cette carte. Créez un nouveau patient.");
        request.getRequestDispatcher("/WEB-INF/views/infirmier/enregistrer-patient.jsp").forward(request, response);
    }
}

else if (pathInfo.equals("/mettre-a-jour-signes")) {
    // Mettre à jour les signes vitaux d'un patient existant
    try {
        String patientIdStr = request.getParameter("patientId");
        UUID patientId = UUID.fromString(patientIdStr);
        
        Patient patient = patientService.getPatientById(patientId);
        
        // Récupérer les nouveaux signes vitaux
        String tensionStr = request.getParameter("tension");
        String temperatureStr = request.getParameter("temperature");
        String poidsStr = request.getParameter("poids");
        String tailleStr = request.getParameter("taille");
        String frequenceCardiaqueStr = request.getParameter("frequenceCardiaque");
        String frequenceRespiratoireStr = request.getParameter("frequenceRespiratoire");
        
        // Mettre à jour
        if (tensionStr != null && !tensionStr.isEmpty()) {
            patient.setTension(tensionStr);
        }
        if (temperatureStr != null && !temperatureStr.isEmpty()) {
            patient.setTemperature(Double.parseDouble(temperatureStr));
        }
        if (poidsStr != null && !poidsStr.isEmpty()) {
            patient.setPoids(Double.parseDouble(poidsStr));
        }
        if (tailleStr != null && !tailleStr.isEmpty()) {
            patient.setTaille(Double.parseDouble(tailleStr));
        }
        if (frequenceCardiaqueStr != null && !frequenceCardiaqueStr.isEmpty()) {
            patient.setFrequenceCardiaque(Integer.parseInt(frequenceCardiaqueStr));
        }
        if (frequenceRespiratoireStr != null && !frequenceRespiratoireStr.isEmpty()) {
            patient.setFrequenceRespiratoire(Integer.parseInt(frequenceRespiratoireStr));
        }
        
        patient.setEnAttente(true); // Remettre en attente
        patient.setUpdatedAt(java.time.LocalDateTime.now());
        
        patientService.updatePatient(patient);
        
        request.getSession().setAttribute("successMessage", 
            "Signes vitaux mis à jour pour " + patient.getPrenom() + " " + patient.getNom());
        
        response.sendRedirect(request.getContextPath() + "/infirmier/patients");
        
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "Erreur lors de la mise à jour: " + e.getMessage());
        request.getRequestDispatcher("/WEB-INF/views/infirmier/rechercher-patient.jsp").forward(request, response);
    }
}
    }
}