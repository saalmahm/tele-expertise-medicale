<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Télé-Expertise Médicale - Accueil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .module-card {
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
        }
        .module-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="text-center mb-5">
            <h1 class="display-4 text-white mb-3">
                <i class="fas fa-hospital"></i> Système de Télé-Expertise Médicale
            </h1>
            <p class="lead text-white">Sélectionnez votre module</p>
        </div>
        
        <div class="row justify-content-center g-4">
            <!-- Module Infirmier -->
            <div class="col-md-5">
                <div class="card module-card" onclick="location.href='${pageContext.request.contextPath}/infirmier'">
                    <div class="card-body text-center p-5">
                        <i class="fas fa-user-nurse fa-5x text-primary mb-4"></i>
                        <h3 class="card-title">Module Infirmier</h3>
                        <p class="card-text text-muted">
                            Enregistrer les patients<br>
                            Gérer les signes vitaux<br>
                            Suivre les statuts
                        </p>
                        <a href="${pageContext.request.contextPath}/infirmier" class="btn btn-primary btn-lg mt-3">
                            Accéder <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Module Médecin Généraliste -->
            <div class="col-md-5">
                <div class="card module-card" onclick="location.href='${pageContext.request.contextPath}/medecin'">
                    <div class="card-body text-center p-5">
                        <i class="fas fa-user-md fa-5x text-success mb-4"></i>
                        <h3 class="card-title">Module Médecin Généraliste</h3>
                        <p class="card-text text-muted">
                            Consulter les patients<br>
                            Créer des consultations<br>
                            Gérer les actes techniques
                        </p>
                        <a href="${pageContext.request.contextPath}/medecin" class="btn btn-success btn-lg mt-3">
                            Accéder <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>

    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>