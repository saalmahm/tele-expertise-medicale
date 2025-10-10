<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module Infirmier</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-hospital"></i> Télé-Expertise Médicale
            </a>
            <span class="navbar-text text-white">
                <i class="fas fa-user-nurse"></i> Module Infirmier
            </span>
        </div>
    </nav>
    
    <div class="container mt-5">
        <h2 class="mb-4">Tableau de Bord Infirmier</h2>
        
        <div class="row g-4">
            <div class="col-md-6">
                <div class="card h-100">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="fas fa-user-plus text-primary"></i> Enregistrer un Patient
                        </h5>
                        <p class="card-text">Enregistrer un nouveau patient avec ses signes vitaux</p>
                        <a href="${pageContext.request.contextPath}/infirmier/enregistrer" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Nouveau Patient
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card h-100">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="fas fa-list text-success"></i> Patients du Jour
                        </h5>
                        <p class="card-text">Consulter la liste des patients enregistrés aujourd'hui</p>
                        <a href="${pageContext.request.contextPath}/infirmier/patients" class="btn btn-success">
                            <i class="fas fa-eye"></i> Voir les Patients
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card h-100">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="fas fa-users text-info"></i> Tous les Patients
                        </h5>
                        <p class="card-text">Voir tous les patients enregistrés dans le système</p>
                        <a href="${pageContext.request.contextPath}/infirmier/tous-patients" class="btn btn-info">
                            <i class="fas fa-database"></i> Tous les Patients
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left"></i> Retour à l'Accueil
            </a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>