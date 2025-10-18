<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enregistrer un Patient</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .modern-card {
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
        .card-header-modern {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 2rem;
            color: white;
        }
        .card-header-modern h4 {
            margin: 0;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .card-header-modern h4 i {
            font-size: 2rem;
        }
        .section-title {
            color: #667eea;
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        .section-title i {
            font-size: 1.5rem;
        }
        .form-label {
            color: #4a5568;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        .form-control, .form-select {
            border: 2px solid #e2e8f0;
            padding: 0.75rem 1rem;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }
        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 1rem 2rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }
        .btn-cancel {
            background: white;
            border: 2px solid #e2e8f0;
            color: #4a5568;
            padding: 1rem 2rem;
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
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/navbar-infirmier.jsp" />
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-10 offset-md-1">
                <div class="modern-card">
                    <div class="card-header-modern">
                        <h4><i class="fas fa-user-plus"></i> Enregistrer un Nouveau Patient</h4>
                    </div>
                    <div class="card-body p-4">
                        <!-- Message d'erreur -->
                        <% if (request.getAttribute("errorMessage") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("errorMessage") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } %>
                        
                        <form action="${pageContext.request.contextPath}/infirmier/enregistrer" method="post">
                            <!-- Section: Informations Patient -->
                            <h5 class="section-title">
                                <i class="fas fa-user"></i> Informations du Patient
                            </h5>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="nom" class="form-label">Nom <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="nom" name="nom" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="prenom" class="form-label">Prénom <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="prenom" name="prenom" required>
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="dateNaissance" class="form-label">Date de Naissance <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" id="dateNaissance" name="dateNaissance" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="sexe" class="form-label">Sexe <span class="text-danger">*</span></label>
                                    <select class="form-select" id="sexe" name="sexe" required>
                                        <option value="">Sélectionner...</option>
                                        <option value="M">Masculin</option>
                                        <option value="F">Féminin</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="carte" class="form-label">Numéro de Carte <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="carte" name="carte" 
                                           value="<%= session.getAttribute("carteRecherchee") != null ? session.getAttribute("carteRecherchee") : "" %>"
                                           placeholder="Ex: 12345678" required>
                                    <% session.removeAttribute("carteRecherchee"); %>
                                </div>
                                <div class="col-md-6">
                                    <label for="telephone" class="form-label">Téléphone</label>
                                    <input type="tel" class="form-control" id="telephone" name="telephone" placeholder="0612345678">
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-12">
                                    <label for="adresse" class="form-label">Adresse</label>
                                    <input type="text" class="form-control" id="adresse" name="adresse" placeholder="Adresse complète">
                                </div>
                            </div>
                            
                            <hr class="my-4">
                            
                            <!-- Section: Signes Vitaux -->
                            <h5 class="section-title">
                                <i class="fas fa-heartbeat"></i> Signes Vitaux
                            </h5>
                            
                            <div class="row mb-3">
                                <div class="col-md-3">
                                    <label for="tension" class="form-label">Tension Artérielle <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="tension" name="tension" 
                                           placeholder="120/80" required>
                                    <small class="text-muted">Format: systolique/diastolique</small>
                                </div>
                                <div class="col-md-3">
                                    <label for="temperature" class="form-label">Température (°C) <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="temperature" name="temperature" 
                                           step="0.1" placeholder="37.0" required>
                                </div>
                                <div class="col-md-3">
                                    <label for="frequenceCardiaque" class="form-label">Fréquence Cardiaque (bpm) <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="frequenceCardiaque" name="frequenceCardiaque" 
                                           placeholder="70" required>
                                </div>
                                <div class="col-md-3">
                                    <label for="frequenceRespiratoire" class="form-label">Fréquence Respiratoire <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="frequenceRespiratoire" name="frequenceRespiratoire" 
                                           placeholder="16" required>
                                </div>
                            </div>
                            
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label for="poids" class="form-label">Poids (kg) <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="poids" name="poids" 
                                           step="0.1" placeholder="70.5" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="taille" class="form-label">Taille (cm) <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="taille" name="taille" 
                                           step="0.1" placeholder="175" required>
                                </div>
                            </div>
                            
                            <div class="d-flex justify-content-between mt-4">
                                <a href="${pageContext.request.contextPath}/infirmier" class="btn btn-cancel">
                                    <i class="fas fa-times"></i> Annuler
                                </a>
                                <button type="submit" class="btn btn-submit">
                                    <i class="fas fa-save"></i> Enregistrer le Patient
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>