<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.teleexpertisemedicale.entity.Patient" %>
<%@ page import="org.example.teleexpertisemedicale.enums.TypeActe" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer une Consultation</title>
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
        .patient-info {
            background: linear-gradient(135deg, #e0f7fa 0%, #e1f5fe 100%);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border-left: 5px solid #667eea;
        }
        .patient-info h5 {
            color: #667eea;
            font-weight: 700;
            margin-bottom: 0.5rem;
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
        .acte-card {
            transition: all 0.3s;
            cursor: pointer;
            border: 2px solid #e2e8f0;
            border-radius: 15px;
            height: 100%;
        }
        .acte-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.2);
            border-color: #667eea;
        }
        .acte-card.selected {
            border: 3px solid #667eea;
            background: linear-gradient(135deg, #e7f1ff 0%, #f0e7ff 100%);
        }
        .form-label {
            color: #4a5568;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        .form-control, .form-select, textarea {
            border: 2px solid #e2e8f0;
            padding: 0.75rem 1rem;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .form-control:focus, .form-select:focus, textarea:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }
        .prix-total {
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .prix-container {
            background: linear-gradient(135deg, #e0f7fa 0%, #e1f5fe 100%);
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
        }
        .btn-submit {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
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
        .expertise-card {
            border: 2px solid #ffc107;
            border-radius: 15px;
            background: linear-gradient(135deg, #fff9e6 0%, #fff3cd 100%);
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/navbar-medecin.jsp" />
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-10 offset-md-1">
                <div class="modern-card">
                    <div class="card-header-modern">
                        <h4><i class="fas fa-file-medical"></i> Créer une Consultation</h4>
                    </div>
                    <div class="card-body p-4">
                        <% 
                            Patient patient = (Patient) request.getAttribute("patient");
                            if (patient == null) {
                                response.sendRedirect(request.getContextPath() + "/medecin/patients-attente");
                                return;
                            }
                        %>
                        
                        <div class="patient-info">
                            <h5><i class="fas fa-user"></i> Patient : <%= patient.getPrenom() %> <%= patient.getNom() %></h5>
                            <p class="mb-0">
                                <strong>Carte :</strong> <%= patient.getCarte() %> | 
                                <strong>Sexe :</strong> <%= patient.getSexe() %> | 
                                <strong>Téléphone :</strong> <%= patient.getTelephone() != null ? patient.getTelephone() : "N/A" %>
                            </p>
                        </div>
                        
                        <form id="consultationForm" 
                        action="${pageContext.request.contextPath}/medecin/creer-consultation" 
                        method="post"
                        onsubmit="console.log('Form submit!'); return true;">                            <input type="hidden" name="patientId" value="<%= patient.getId() %>">
                            
                            <h5 class="section-title">
                                <i class="fas fa-stethoscope"></i> Actes Techniques (Optionnel)
                            </h5>
                            
                            <div class="row mb-4">
                                <% 
                                    TypeActe[] actes = TypeActe.values();
                                    for (TypeActe acte : actes) {
                                %>
                                    <div class="col-md-4 mb-3">
                                        <div class="card acte-card h-100" onclick="toggleActe(this, '<%= acte.name() %>')">
                                            <div class="card-body text-center">
                                                <input type="checkbox" name="actes" value="<%= acte.name() %>" 
                                                       class="form-check-input d-none acte-checkbox" 
                                                       data-prix="<%= acte.getPrix() %>">
                                                <h6><%= acte.getLibelle() %></h6>
                                                <p class="text-success mb-0"><strong><%= String.format("%.2f", acte.getPrix()) %> DH</strong></p>
                                            </div>
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                            
                            <hr class="my-4">
                            
                            <!-- Raison de la consultation -->
                            <div class="mb-3">
                                <label for="raison" class="form-label"><i class="fas fa-clipboard-list"></i> Raison de la Consultation <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="raison" name="raison" 
                                    placeholder="Ex: Fièvre, Douleurs abdominales, Contrôle de routine..." required>
                                <small class="text-muted">Motif principal de la visite</small>
                            </div>
                            
                            <!-- Observations -->
                            <div class="mb-4">
                                <label for="observations" class="form-label">Observations</label>
                                <textarea class="form-control" id="observations" name="observations" rows="3" 
                                          placeholder="Notes ou observations sur la consultation..."></textarea>
                            </div>

                            <!-- Besoin d'avis expertise -->
                            <div class="expertise-card p-3 mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="besoinAvis" name="besoinAvisExpertise" value="true">
                                    <label class="form-check-label" for="besoinAvis">
                                        <strong><i class="fas fa-user-md text-warning"></i> Besoin d'avis d'un spécialiste</strong>
                                    </label>
                                </div>
                            </div>
                            
                            <hr class="my-4">
                            
                            <!-- Prix Total -->
                            <div class="prix-container mb-4">
                                <h5 class="mb-3"><i class="fas fa-calculator"></i> Prix Total</h5>
                                <div class="prix-total" id="prixTotal">150.00 DH</div>
                                <small class="text-muted">Prix consultation: 150 DH</small>
                            </div>
                            
                            <div class="d-flex justify-content-between mt-4">
                                <a href="${pageContext.request.contextPath}/medecin/patients-attente" class="btn btn-cancel">
                                    <i class="fas fa-arrow-left"></i> Retour
                                </a>
                                <button type="submit" class="btn btn-submit" onclick="console.log('Bouton cliqué'); return true;">
                                    <i class="fas fa-check"></i> Créer Consultation
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const PRIX_CONSULTATION = 150.0;
        
        function toggleActe(card, acteName) {
            const checkbox = card.querySelector('.acte-checkbox');
            checkbox.checked = !checkbox.checked;
            
            if (checkbox.checked) {
                card.classList.add('selected');
            } else {
                card.classList.remove('selected');
            }
            
            calculerPrixTotal();
        }
        
        function calculerPrixTotal() {
            let total = PRIX_CONSULTATION;
            const checkboxes = document.querySelectorAll('.acte-checkbox:checked');
            
            checkboxes.forEach(checkbox => {
                total += parseFloat(checkbox.getAttribute('data-prix'));
            });
            
            document.getElementById('prixTotal').textContent = total.toFixed(2) + ' DH';
        }
    </script>
</body>
</html>