<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails Consultation</title>
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
                <i class="fas fa-user-md"></i> Module Médecin
            </span>
        </div>
    </nav>
    
    <div class="container mt-4">
        <h2><i class="fas fa-clipboard-list"></i> Détails de la Consultation #${consultation.id}</h2>
        
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        
        <div class="row mt-4">
            <!-- Informations Patient -->
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5><i class="fas fa-user"></i> Informations Patient</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Nom:</strong> ${consultation.patient.prenom} ${consultation.patient.nom}</p>
                        <p><strong>Date de Naissance:</strong> 
                            <fmt:formatDate value="${consultation.patient.dateNaissance}" pattern="dd/MM/yyyy"/>
                        </p>
                        <p><strong>Sexe:</strong> ${consultation.patient.sexe == 'M' ? 'Masculin' : 'Féminin'}</p>
                        <p><strong>Téléphone:</strong> ${consultation.patient.telephone}</p>
                        <p><strong>Adresse:</strong> ${consultation.patient.adresse}</p>
                    </div>
                </div>
            </div>
            
            <!-- Informations Consultation -->
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header bg-success text-white">
                        <h5><i class="fas fa-stethoscope"></i> Informations Consultation</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Date:</strong> 
                            <fmt:formatDate value="${consultation.dateConsultation}" pattern="dd/MM/yyyy HH:mm"/>
                        </p>
                        <p><strong>Statut:</strong> 
                            <span class="badge bg-${consultation.statut == 'TERMINEE' ? 'success' : 'warning'}">
                                ${consultation.statut}
                            </span>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Actes Techniques -->
        <div class="card mb-4">
            <div class="card-header bg-info text-white">
                <h5><i class="fas fa-syringe"></i> Actes Techniques</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty consultation.actesTechniques}">
                        <p class="text-muted">Aucun acte technique ajouté</p>
                    </c:when>
                    <c:otherwise>
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>Code</th>
                                    <th>Libellé</th>
                                    <th>Prix</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="acte" items="${consultation.actesTechniques}">
                                    <tr>
                                        <td><code>${acte.code}</code></td>
                                        <td>${acte.libelle}</td>
                                        <td><strong><fmt:formatNumber value="${acte.prix}" pattern="#,##0.00"/> DH</strong></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr class="table-success">
                                    <td colspan="2"><strong>TOTAL</strong></td>
                                    <td><strong><fmt:formatNumber value="${coutTotal}" pattern="#,##0.00"/> DH</strong></td>
                                </tr>
                            </tfoot>
                        </table>
                    </c:otherwise>
                </c:choose>
                
                <!-- Formulaire Ajouter Acte -->
                <c:if test="${consultation.statut != 'TERMINEE'}">
                    <hr>
                    <h6>Ajouter un Acte Technique</h6>
                    <form action="${pageContext.request.contextPath}/medecin/ajouter-acte" method="post" class="row g-3">
                        <input type="hidden" name="consultationId" value="${consultation.id}">
                        <div class="col-md-8">
                            <select name="codeActe" class="form-select" required>
                                <option value="">Sélectionner un acte...</option>
                                <option value="CONS-GEN">Consultation Générale - 200 DH</option>
                                <option value="ECG">Électrocardiogramme (ECG) - 150 DH</option>
                                <option value="RADIO-THORAX">Radiographie Thorax - 300 DH</option>
                                <option value="PRISE-SANG">Prise de Sang - 100 DH</option>
                                <option value="TENSION">Mesure Tension - 50 DH</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-plus"></i> Ajouter
                            </button>
                        </div>
                    </form>
                </c:if>
            </div>
        </div>
        
        <!-- Formulaire Terminer Consultation -->
        <c:if test="${consultation.statut != 'TERMINEE'}">
            <div class="card mb-4">
                <div class="card-header bg-warning">
                    <h5><i class="fas fa-check-circle"></i> Terminer la Consultation</h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/medecin/terminer-consultation" method="post">
                        <input type="hidden" name="consultationId" value="${consultation.id}">
                        
                        <div class="mb-3">
                            <label for="diagnostic" class="form-label">Diagnostic</label>
                            <textarea class="form-control" id="diagnostic" name="diagnostic" rows="3" required></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="prescription" class="form-label">Prescription</label>
                            <textarea class="form-control" id="prescription" name="prescription" rows="3"></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="observations" class="form-label">Observations</label>
                            <textarea class="form-control" id="observations" name="observations" rows="2"></textarea>
                        </div>
                        
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-check"></i> Terminer la Consultation
                        </button>
                    </form>
                </div>
            </div>
        </c:if>
        
        <!-- Résumé si consultation terminée -->
        <c:if test="${consultation.statut == 'TERMINEE'}">
            <div class="card mb-4 border-success">
                <div class="card-header bg-success text-white">
                    <h5><i class="fas fa-file-medical"></i> Résumé de la Consultation</h5>
                </div>
                <div class="card-body">
                    <h6>Diagnostic:</h6>
                    <p>${consultation.diagnostic}</p>
                    
                    <h6>Prescription:</h6>
                    <p>${consultation.prescription}</p>
                    
                    <c:if test="${not empty consultation.observations}">
                        <h6>Observations:</h6>
                        <p>${consultation.observations}</p>
                    </c:if>
                </div>
            </div>
        </c:if>
        
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/medecin/consultations" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left"></i> Retour aux Consultations
            </a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>