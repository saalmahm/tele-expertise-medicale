package org.example.teleexpertisemedicale.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.teleexpertisemedicale.dao.UserDAO;
import org.example.teleexpertisemedicale.entity.Infirmier;
import org.example.teleexpertisemedicale.entity.User;
import org.example.teleexpertisemedicale.enums.Role;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.io.IOException;
import java.lang.reflect.Field;

import static org.mockito.Mockito.*;

class AuthControllerTest {

    private AuthController authController;
    
    @Mock
    private HttpServletRequest request;
    
    @Mock
    private HttpServletResponse response;
    
    @Mock
    private HttpSession session;
    
    @Mock
    private UserDAO userDAO;

    @Mock
    private RequestDispatcher requestDispatcher;

    @BeforeEach
    void setUp() throws Exception {
        // Initialise les mocks
        MockitoAnnotations.openMocks(this);
        authController = new AuthController();
        
        // Injecter le mock userDAO via réflexion (car il est private)
        Field userDAOField = AuthController.class.getDeclaredField("userDAO");
        userDAOField.setAccessible(true);
        userDAOField.set(authController, userDAO);
    }

    @Test
    void testConnexionInfirmierReussie() throws ServletException, IOException {
        // 1. Préparer les données de test
        String email = "infirmier@hopital.com";
        String mdp = "123456";
        
        // Créer un utilisateur fictif (Infirmier car User est abstract)
        Infirmier infirmier = new Infirmier();
        infirmier.setEmail(email);
        infirmier.setPassword(mdp);
        infirmier.setRole(Role.INFIRMIER);
        
        // 2. Configurer les mocks
        when(request.getParameter("email")).thenReturn(email);
        when(request.getParameter("password")).thenReturn(mdp);
        when(userDAO.findByEmailAndPassword(email, mdp)).thenReturn(infirmier);
        when(request.getSession()).thenReturn(session);
        
        // 3. Exécuter la méthode à tester
        authController.doPost(request, response);
        
        // 4. Vérifier les résultats
        verify(session).setAttribute("user", infirmier);
        verify(response).sendRedirect(request.getContextPath() + "/infirmier/accueil");
    }

    @Test
    void testConnexionEchouee() throws ServletException, IOException {
        // 1. Préparer des identifiants incorrects
        when(request.getParameter("email")).thenReturn("inconnu@test.com");
        when(request.getParameter("password")).thenReturn("fauxmdp");
        when(userDAO.findByEmailAndPassword(anyString(), anyString())).thenReturn(null);
        when(request.getRequestDispatcher("/WEB-INF/views/login.jsp")).thenReturn(requestDispatcher);
        
        // 2. Exécuter
        authController.doPost(request, response);
        
        // 3. Vérifier qu'on reste sur la page de login avec un message d'erreur
        verify(request).setAttribute("error", "Email ou mot de passe incorrect");
        verify(requestDispatcher).forward(request, response);
    }
}