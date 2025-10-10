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

import java.io.IOException;
import java.util.List;

/**
 * Servlet pour le Module Médecin Généraliste
 * URL: /medecin
 * 
 * Fonctionnalités:
 * - Voir les patients en attente de consultation
 * - Créer une consultation pour un patient
 * - Ajouter des actes techniques à une consultation
 */
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
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Page d'accueil médecin
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
                Long patientId = Long.parseLong(patientIdStr);
                Patient patient = patientService.getPatientById(patientId);
                request.setAttribute("patient", patient);
            }
            request.getRequestDispatcher("/WEB-INF/views/medecin/creer-consultation.jsp").forward(request, response);
        }
        else if (pathInfo.equals("/consultation-details")) {
            // Détails d'une consultation
            String consultationIdStr = request.getParameter("id");
            if (consultationIdStr != null) {
                Long consultationId = Long.parseLong(consultationIdStr);
                Consultation consultation = consultationService.getConsultationById(consultationId);
                double coutTotal = consultationService.calculerCoutTotal(consultationId);
                
                request.setAttribute("consultation", consultation);
                request.setAttribute("coutTotal", coutTotal);
                request.getRequestDispatcher("/WEB-INF/views/medecin/consultation-details.jsp").forward(request, response);
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
            // Créer une nouvelle consultation
            try {
                Long patientId = Long.parseLong(request.getParameter("patientId"));
                
                Consultation consultation = consultationService.creerConsultation(patientId, null);
                
                request.getSession().setAttribute("successMessage", "Consultation créée avec succès!");
                response.sendRedirect(request.getContextPath() + "/medecin/consultation-details?id=" + consultation.getId());
                
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Erreur: " + e.getMessage());
                doGet(request, response);
            }
        }
        else if (pathInfo.equals("/ajouter-acte")) {
            // Ajouter un acte technique à une consultation
            try {
                Long consultationId = Long.parseLong(request.getParameter("consultationId"));
                String codeActe = request.getParameter("codeActe");
                
                consultationService.ajouterActeTechnique(consultationId, codeActe);
                
                request.getSession().setAttribute("successMessage", "Acte technique ajouté!");
                response.sendRedirect(request.getContextPath() + "/medecin/consultation-details?id=" + consultationId);
                
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Erreur: " + e.getMessage());
                doGet(request, response);
            }
        }
        else if (pathInfo.equals("/terminer-consultation")) {
            // Terminer une consultation
            try {
                Long consultationId = Long.parseLong(request.getParameter("consultationId"));
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