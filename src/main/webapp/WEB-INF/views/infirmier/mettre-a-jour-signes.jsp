<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.teleexpertisemedicale.entity.Patient" %>
<%
    Patient patient = (Patient) request.getAttribute("patient");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mettre à jour Signes Vitaux</title>
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
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
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
        .patient-info {
            background: linear-gradient(135deg, #e0f7fa 0%, #e1f5fe 100%);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border-left: 5px solid #11998e;
        }
        .patient-info h5 {
            color: #11998e;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        .form-label {
            color: #4a5568;
            font-weight: 600;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .form-control {
            border: 2px solid #e2e8f0;
            padding: 0.75rem 1rem;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #11998e;
            box-shadow: 0 0 0 4px rgba(17, 153, 142, 0.1);
        }
        .btn-save {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            border: none;
            color: white;
            padding: 1rem 2rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .btn-save:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(17, 153, 142, 0.4);
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
        .section-title {
            color: #11998e;
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        .section-title i {
            font-size: 1.5rem;
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
                        <h4><i class="fas fa-heartbeat"></i> Mettre à jour les Signes Vitaux</h4>
                    </div>
                    <div class="card-body p-4">
                        <div class="patient-info">
                            <h5>
                                <i class="fas fa-user-circle"></i> Informations du Patient
                            </h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <p class="mb-2">
                                        <i class="fas fa-user text-primary"></i> 
                                        <strong>Nom complet:</strong> <%= patient.getPrenom() %> <%= patient.getNom() %>
                                    </p>
                                    <p class="mb-2">
                                        <i class="fas fa-id-card text-primary"></i> 
                                        <strong>Carte:</strong> <%= patient.getCarte() %>
                                    </p>
                                </div>
                                <div class="col-md-6">
                                    <p class="mb-2">
                                        <i class="fas fa-phone text-primary"></i> 
                                        <strong>Téléphone:</strong> <%= patient.getTelephone() != null ? patient.getTelephone() : "Non renseigné" %>
                                    </p>
                                    <p class="mb-2">
                                        <i class="fas fa-birthday-cake text-primary"></i> 
                                        <strong>Date de naissance:</strong> <%= patient.getDateNaissance() %>
                                    </p>
                                </div>
                            </div>
                        </div>
                        
                        <h5 class="section-title">
                            <i class="fas fa-stethoscope"></i> Nouveaux Signes Vitaux
                        </h5>
                        
                        <form method="post" action="${pageContext.request.contextPath}/infirmier/mettre-a-jour-signes">
                            <input type="hidden" name="patientId" value="<%= patient.getId() %>">
                            
                            <div class="row mb-3">
                                <div class="col-md-3">
                                    <label for="tension" class="form-label">
                                        <i class="fas fa-tachometer-alt text-danger"></i> Tension Artérielle
                                    </label>
                                    <input type="text" class="form-control" id="tension" name="tension" 
                                           value="<%= patient.getTension() != null ? patient.getTension() : "" %>"
                                           placeholder="120/80">
                                    <small class="text-muted">Format: 120/80</small>
                                </div>
                                
                                <div class="col-md-3">
                                    <label for="temperature" class="form-label">
                                        <i class="fas fa-thermometer-half text-warning"></i> Température (°C)
                                    </label>
                                    <input type="number" class="form-control" id="temperature" name="temperature" 
                                           step="0.1" value="<%= patient.getTemperature() %>"
                                           placeholder="37.0">
                                </div>
                                
                                <div class="col-md-3">
                                    <label for="frequenceCardiaque" class="form-label">
                                        <i class="fas fa-heartbeat text-danger"></i> Fréquence Cardiaque (bpm)
                                    </label>
                                    <input type="number" class="form-control" id="frequenceCardiaque" name="frequenceCardiaque" 
                                           value="<%= patient.getFrequenceCardiaque() %>"
                                           placeholder="70">
                                </div>
                                
                                <div class="col-md-3">
                                    <label for="frequenceRespiratoire" class="form-label">
                                        <i class="fas fa-lungs text-info"></i> Fréquence Respiratoire
                                    </label>
                                    <input type="number" class="form-control" id="frequenceRespiratoire" name="frequenceRespiratoire" 
                                           value="<%= patient.getFrequenceRespiratoire() %>"
                                           placeholder="16">
                                </div>
                            </div>
                            
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label for="poids" class="form-label">
                                        <i class="fas fa-weight text-success"></i> Poids (kg)
                                    </label>
                                    <input type="number" class="form-control" id="poids" name="poids" 
                                           step="0.1" value="<%= patient.getPoids() %>"
                                           placeholder="70.5">
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="taille" class="form-label">
                                        <i class="fas fa-ruler-vertical text-primary"></i> Taille (cm)
                                    </label>
                                    <input type="number" class="form-control" id="taille" name="taille" 
                                           step="0.1" value="<%= patient.getTaille() %>"
                                           placeholder="175">
                                </div>
                            </div>
                            
                            <div class="d-flex justify-content-between mt-4">
                                <a href="${pageContext.request.contextPath}/infirmier/rechercher-patient" class="btn btn-cancel">
                                    <i class="fas fa-times"></i> Annuler
                                </a>
                                <button type="submit" class="btn btn-save">
                                    <i class="fas fa-save"></i> Enregistrer les Modifications
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