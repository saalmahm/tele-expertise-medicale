<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enregistrer un Patient</title>
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
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-10 offset-md-1">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4><i class="fas fa-user-plus"></i> Enregistrer un Nouveau Patient</h4>
                    </div>
                    <div class="card-body">
                        <!-- Message d'erreur -->
                        <% if (request.getAttribute("errorMessage") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("errorMessage") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } %>
                        
                        <form action="${pageContext.request.contextPath}/infirmier/enregistrer" method="post">
                            <!-- Section: Informations Patient -->
                            <h5 class="mb-3 text-primary">
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
                                    <label for="telephone" class="form-label">Téléphone</label>
                                    <input type="tel" class="form-control" id="telephone" name="telephone" placeholder="0612345678">
                                </div>
                                <div class="col-md-6">
                                    <label for="adresse" class="form-label">Adresse</label>
                                    <input type="text" class="form-control" id="adresse" name="adresse" placeholder="Adresse complète">
                                </div>
                            </div>
                            
                            <hr class="my-4">
                            
                            <!-- Section: Signes Vitaux -->
                            <h5 class="mb-3 text-success">
                                <i class="fas fa-heartbeat"></i> Signes Vitaux
                            </h5>
                            
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="tension" class="form-label">Tension Artérielle <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="tension" name="tension" 
                                           placeholder="120/80" required>
                                    <small class="text-muted">Format: systolique/diastolique</small>
                                </div>
                                <div class="col-md-4">
                                    <label for="temperature" class="form-label">Température (°C) <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="temperature" name="temperature" 
                                           step="0.1" placeholder="37.0" required>
                                </div>
                                <div class="col-md-4">
                                    <label for="frequenceCardiaque" class="form-label">Fréquence Cardiaque (bpm) <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="frequenceCardiaque" name="frequenceCardiaque" 
                                           placeholder="70" required>
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
                            
                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/infirmier" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Annuler
                                </a>
                                <button type="submit" class="btn btn-primary">
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