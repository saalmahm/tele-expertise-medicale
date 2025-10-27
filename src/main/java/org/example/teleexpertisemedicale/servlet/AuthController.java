package org.example.teleexpertisemedicale.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.teleexpertisemedicale.dao.UserDAO;
import org.example.teleexpertisemedicale.entity.User;
import org.example.teleexpertisemedicale.enums.Role;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

@WebServlet("/login")
public class AuthController extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Afficher le formulaire de connexion
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validation des champs
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Veuillez remplir tous les champs");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        try {
            // Authentifier l'utilisateur
            User user = userDAO.findByEmailAndPassword(email, password);

            if (user != null) {
                // Créer la session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userRole", user.getRole());

                // Rediriger selon le rôle
                if (user.getRole() == Role.INFIRMIER) {
                    response.sendRedirect(request.getContextPath() + "/infirmier/accueil");
                } else if (user.getRole() == Role.MEDECIN_GENERALISTE) {
                    response.sendRedirect(request.getContextPath() + "/medecin/accueil");
                } else {
                    request.setAttribute("error", "Rôle utilisateur non reconnu");
                    request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                }
            } else {
                // Échec de l'authentification
                request.setAttribute("error", "Email ou mot de passe incorrect");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de l'authentification: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}