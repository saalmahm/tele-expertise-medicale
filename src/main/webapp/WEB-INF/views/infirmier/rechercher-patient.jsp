<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rechercher Patient</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .search-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .search-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 3rem 2rem;
            text-align: center;
            color: white;
        }
        .search-header i {
            font-size: 3rem;
            margin-bottom: 1rem;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }
        .search-header h3 {
            font-weight: 700;
            margin: 0;
        }
        .search-body {
            padding: 3rem;
        }
        .form-label {
            color: #4a5568;
            font-weight: 600;
            margin-bottom: 0.75rem;
        }
        .input-group-text {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 1rem 1.25rem;
        }
        .form-control {
            border: 2px solid #e2e8f0;
            padding: 1rem 1.25rem;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }
        .btn-search {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 1rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }
        .btn-cancel {
            background: white;
            border: 2px solid #e2e8f0;
            color: #4a5568;
            padding: 1rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .btn-cancel:hover {
            border-color: #cbd5e0;
            background: #f7fafc;
        }
        .alert {
            border-radius: 10px;
            border: none;
            padding: 1rem 1.5rem;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/navbar-infirmier.jsp" />
    
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="search-card">
                    <div class="search-header">
                        <i class="fas fa-search fa-2x mb-3 d-block"></i>
                        <h3>Rechercher un Patient</h3>
                    </div>
                    
                    <div class="search-body">
                        <!-- Messages d'erreur -->
                        <% if (request.getAttribute("errorMessage") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-triangle"></i> 
                                <%= request.getAttribute("errorMessage") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } %>
                        
                        <!-- Messages d'info -->
                        <% if (request.getAttribute("infoMessage") != null) { %>
                            <div class="alert alert-info alert-dismissible fade show" role="alert">
                                <i class="fas fa-info-circle"></i> 
                                <%= request.getAttribute("infoMessage") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } %>
               
                        
                        <!-- Formulaire -->
                        <form method="post" action="${pageContext.request.contextPath}/infirmier/rechercher-patient" class="mt-4">
                            <div class="mb-4">
                                <label for="carte" class="form-label fw-bold">
                                    <i class="fas fa-id-card text-primary"></i> Numéro de Carte Médicale
                                </label>
                                <div class="input-group input-group-lg">
                                    <span class="input-group-text bg-primary text-white">
                                        <i class="fas fa-hashtag"></i>
                                    </span>
                                    <input type="text" 
                                           class="form-control form-control-lg" 
                                           id="carte" 
                                           name="carte" 
                                           placeholder="Entrez le numéro de carte (ex: 12345678)" 
                                           required 
                                           autofocus
                                           pattern="[A-Za-z0-9]+"
                                           title="Lettres et chiffres uniquement">
                                </div>
                                <div class="form-text">
                                    <i class="fas fa-info-circle"></i> Le numéro de carte est unique pour chaque patient
                                </div>
                            </div>
                            
                            <div class="d-grid gap-3">
                                <button type="submit" class="btn btn-search">
                                    <i class="fas fa-search me-2"></i> Rechercher le Patient
                                </button>
                                <a href="${pageContext.request.contextPath}/infirmier/accueil" 
                                   class="btn btn-cancel">
                                    <i class="fas fa-times me-2"></i> Annuler
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Auto-focus et validation -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-uppercase pour le numéro de carte
            const carteInput = document.getElementById('carte');
            if (carteInput) {
                carteInput.addEventListener('input', function() {
                    this.value = this.value.toUpperCase();
                });
            }
        });
    </script>
</body>
</html>