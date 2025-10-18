package org.example.teleexpertisemedicale.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import org.example.teleexpertisemedicale.entity.User;
import org.example.teleexpertisemedicale.enums.Role;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        // URLs accessibles sans authentification
        if (path.startsWith("/login") || path.startsWith("/logout") || path.startsWith("/resources/")) {
            chain.doFilter(request, response);
            return;
        }

               // Vérifier si l'utilisateur est connecté
        HttpSession session = httpRequest.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("user") != null;

        if (loggedIn) {
            // Récupérer l'utilisateur de la session
            User user = (User) session.getAttribute("user");
            Role role = user.getRole();
            
            // Vérifier l'accès en fonction du rôle
            if ((path.startsWith("/infirmier/") && role == Role.INFIRMIER) ||
                (path.startsWith("/medecin/") && role == Role.MEDECIN_GENERALISTE) ||
                path.equals("/") || path.equals("")) {
                chain.doFilter(request, response);
            } else {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès non autorisé");
            }
        } else {
            // Rediriger vers la page de connexion
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation si nécessaire
    }

    @Override
    public void destroy() {
        // Nettoyage si nécessaire
    }
}