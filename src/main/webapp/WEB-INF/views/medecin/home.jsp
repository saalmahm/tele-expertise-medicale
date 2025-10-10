<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module Médecin Généraliste</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-hospital"></i> Télé-Expertise Médicale
            </a>
            <span class="navbar-text text-white">
                <i class="fas fa-user-md"></i> Module Médecin Généraliste
            </span>
        </div>
    </nav>
    
    <div class="container mt-5">
        <h2 class="mb-4">Tableau de Bord Médecin</h2>
        
        <div class="row g-4">
            <div class="col-md-6">
                <div class="card h-100 border-warning">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="fas fa-clock text-warning"></i> Patients en Attente
                        </h5>
                        <p class="card-text">Voir les patients qui attendent une consultation</p>
                        <a href="${pageContext.request.contextPath}/medecin/patients-attente" class="btn btn-warning">
                            <i class="fas fa-list"></i> Voir les Patients
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card h-100 border-success">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="fas fa-clipboard-list text-success"></i> Mes Consultations
                        </h5>
                        <p class="card-text">Gérer toutes les consultations</p>
                        <a href="${pageContext.request.contextPath}/medecin/consultations" class="btn btn-success">
                            <i class="fas fa-eye"></i> Voir Consultations
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