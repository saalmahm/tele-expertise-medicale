<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .navbar-custom {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        padding: 1rem 0;
        border: none;
    }
    
    .navbar-brand {
        font-weight: 700;
        font-size: 1.3rem;
        color: white !important;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        transition: all 0.3s ease;
    }
    
    .navbar-brand:hover {
        transform: scale(1.05);
    }
    
    .navbar-brand i {
        font-size: 1.5rem;
        color: white;
    }
    
    .nav-link {
        color: rgba(255, 255, 255, 0.9) !important;
        font-weight: 500;
        padding: 0.5rem 1rem !important;
        margin: 0 0.25rem;
        border-radius: 8px;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .nav-link:hover {
        background: rgba(255, 255, 255, 0.2);
        color: white !important;
        transform: translateY(-2px);
    }
    
    .nav-link.active {
        background: rgba(255, 255, 255, 0.25);
        color: white !important;
    }
    
    .nav-link i {
        font-size: 1.1rem;
    }
    
    .user-info {
        background: rgba(255, 255, 255, 0.15);
        padding: 0.5rem 1rem;
        border-radius: 10px;
        color: white;
        font-weight: 500;
        margin-right: 1rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .user-info i {
        font-size: 1.2rem;
    }
    
    .btn-logout {
        background: rgba(255, 255, 255, 0.2);
        border: 2px solid rgba(255, 255, 255, 0.3);
        color: white;
        font-weight: 600;
        padding: 0.5rem 1.25rem;
        border-radius: 10px;
        transition: all 0.3s ease;
    }
    
    .btn-logout:hover {
        background: white;
        color: #667eea;
        border-color: white;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }
    
    .navbar-toggler {
        border: 2px solid rgba(255, 255, 255, 0.5);
        padding: 0.5rem;
    }
    
    .navbar-toggler:focus {
        box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.25);
    }
    
    .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 1%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }
</style>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-hospital"></i>
            <span>Télé-Expertise Médicale</span>
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/infirmier/accueil">
                        <i class="fas fa-home"></i> Accueil
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/infirmier/rechercher-patient">
                        <i class="fas fa-search"></i> Rechercher
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/infirmier/patients">
                        <i class="fas fa-users"></i> Patients du jour
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/infirmier/tous-patients">
                        <i class="fas fa-list"></i> Tous les patients
                    </a>
                </li>
            </ul>
            
            <div class="d-flex align-items-center">
                <div class="user-info">
                    <i class="fas fa-user-nurse"></i>
                    <span>
                        <% 
                            org.example.teleexpertisemedicale.entity.User user = 
                                (org.example.teleexpertisemedicale.entity.User) session.getAttribute("user");
                            if (user != null) {
                                out.print(user.getNom() + " " + user.getPrenom());
                            }
                        %>
                    </span>
                </div>
                
                <form method="post" action="${pageContext.request.contextPath}/logout" class="d-inline">
                    <button type="submit" class="btn btn-logout">
                        <i class="fas fa-sign-out-alt"></i> Déconnexion
                    </button>
                </form>
            </div>
        </div>
    </div>
</nav>