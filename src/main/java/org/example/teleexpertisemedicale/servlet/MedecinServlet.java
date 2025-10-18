package org.example.teleexpertisemedicale.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.teleexpertisemedicale.entity.Consultation;
import org.example.teleexpertisemedicale.entity.Patient;
import org.example.teleexpertisemedicale.service.ConsultationService;
import org.example.teleexpertisemedicale.service.PatientService;
import org.example.teleexpertisemedicale.enums.TypeActe;
import java.util.ArrayList;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/medecin/*")
public class MedecinServlet extends HttpServlet {
    
    private PatientService patientService;
    private ConsultationService consultationService;
    
    @Override
    public void init() throws ServletException {
        patientService = new PatientService();
        consultationService = new ConsultationService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/accueil")) {
            request.getRequestDispatcher("/WEB-INF/views/medecin/home.jsp").forward(request, response);
        }
        else if (pathInfo.equals("/patients-attente")) {
            // Liste des patients en attente
            List<Patient> patients = patientService.getPatientsEnAttente();
            request.setAttribute("patients", patients);
            request.getRequestDispatcher("/WEB-INF/views/medecin/patients-attente.jsp").forward(request, response);
        }
        else if (pathInfo.equals("/consultation")) {
            // Formulaire de création de consultation
            String patientIdStr = request.getParameter("patientId");
            if (patientIdStr != null) {
            UUID patientId = UUID.fromString(patientIdStr);
                Patient patient = patientService.getPatientById(patientId);
                request.setAttribute("patient", patient);
            }
            request.getRequestDispatcher("/WEB-INF/views/medecin/creer-consultation.jsp").forward(request, response);
        }
            else if (pathInfo.equals("/creer-consultation")) {
                // Formulaire de création de consultation
                String patientIdStr = request.getParameter("patientId");
                if (patientIdStr != null) {
                    UUID patientId = UUID.fromString(patientIdStr);
                    Patient patient = patientService.getPatientById(patientId);
                    request.setAttribute("patient", patient);
                    request.getRequestDispatcher("/WEB-INF/views/medecin/creer-consultation.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/medecin/patients-attente");
                }
            }

        else if (pathInfo.equals("/consultations")) {
            // Liste de toutes les consultations
            List<Consultation> consultations = consultationService.getAllConsultations();
            request.setAttribute("consultations", consultations);
            request.getRequestDispatcher("/WEB-INF/views/medecin/consultations.jsp").forward(request, response);
        }
        else if (pathInfo.equals("/consultation-details")) {
            // Détails d'une consultation
            String consultationIdStr = request.getParameter("id");
            if (consultationIdStr != null) {
                try {
                    UUID consultationId = UUID.fromString(consultationIdStr);
                        Consultation consultation = consultationService.getConsultationByIdWithActes(consultationId);
                    if (consultation != null) {
                        // Calculer le coût total des actes techniques
                        double coutTotal = 0.0;
                        if (consultation.getActes() != null) {
                            for (var acte : consultation.getActes()) {
                                coutTotal += acte.getPrix();
                            }
                        }
                        
                        request.setAttribute("consultation", consultation);
                        request.setAttribute("coutTotal", coutTotal);
                        request.getRequestDispatcher("/WEB-INF/views/medecin/consultation-details.jsp").forward(request, response);
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Consultation non trouvée");
                    }
                } catch (IllegalArgumentException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de consultation invalide");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/medecin/consultations");
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
        
        if (pathInfo.equals("/creer-consultation")) {
            // Créer une nouvelle consultation avec actes techniques
            try {
                String patientIdStr = request.getParameter("patientId");
                System.out.println("=== CRÉATION CONSULTATION ===");
                System.out.println("Patient ID: " + patientIdStr);
                
                UUID patientId = UUID.fromString(patientIdStr);
                
                // Récupérer les données
                String raison = request.getParameter("raison");
                String observations = request.getParameter("observations");
                System.out.println("Raison: " + raison);
                System.out.println("Observations: " + observations);
                
                // Récupérer les actes techniques sélectionnés
                String[] actesArray = request.getParameterValues("actes");
                List<TypeActe> actes = new ArrayList<>();
                if (actesArray != null) {
                    System.out.println("Nombre d'actes: " + actesArray.length);
                    for (String acteStr : actesArray) {
                        System.out.println("Acte: " + acteStr);
                        actes.add(TypeActe.valueOf(acteStr));
                    }
                } else {
                    System.out.println("Aucun acte sélectionné");
                }
                
                // Besoin d'avis expertise
                boolean besoinAvisExpertise = request.getParameter("besoinAvisExpertise") != null;
                System.out.println("Besoin avis: " + besoinAvisExpertise);
                
                // Créer la consultation
                System.out.println("Appel du service...");
                Consultation consultation = consultationService.creerConsultationComplete(
                    patientId, raison, observations, actes, besoinAvisExpertise
                );
                System.out.println("Consultation créée avec ID: " + consultation.getId());
                System.out.println("===========================");
                
                request.getSession().setAttribute("successMessage", "Consultation créée avec succès!");
                response.sendRedirect(request.getContextPath() + "/medecin/patients-attente");
                
            } catch (Exception e) {
                System.err.println("ERREUR lors de la création de consultation:");
                e.printStackTrace();
                request.setAttribute("errorMessage", "Erreur: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/medecin/patients-attente");
            }
        }
        else if (pathInfo.equals("/terminer-consultation")) {
            // Terminer une consultation
            try {
                UUID consultationId = UUID.fromString(request.getParameter("consultationId"));
                String diagnostic = request.getParameter("diagnostic");
                String prescription = request.getParameter("prescription");
                String observations = request.getParameter("observations");
                
                consultationService.terminerConsultation(consultationId, diagnostic, prescription, observations);
                
                request.getSession().setAttribute("successMessage", "Consultation terminée avec succès!");
                response.sendRedirect(request.getContextPath() + "/medecin/consultations");
                
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Erreur: " + e.getMessage());
                doGet(request, response);
            }
        }
    }
}