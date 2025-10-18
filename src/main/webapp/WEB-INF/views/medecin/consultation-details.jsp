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
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .page-header {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            animation: slideDown 0.5s ease-out;
        }
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .page-header h2 {
            color: #2d3748;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .page-header h2 i {
            color: #667eea;
            font-size: 2rem;
        }
        .info-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            animation: fadeInUp 0.6s ease-out;
            height: 100%;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .card-header-modern {
            border-bottom: 3px solid;
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }
        .card-header-modern.primary {
            border-color: #667eea;
        }
        .card-header-modern.success {
            border-color: #11998e;
        }
        .card-header-modern.info {
            border-color: #4facfe;
        }
        .card-header-modern h5 {
            color: #2d3748;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        .card-header-modern.primary h5 i { color: #667eea; }
        .card-header-modern.success h5 i { color: #11998e; }
        .card-header-modern.info h5 i { color: #4facfe; }
        .info-card p {
            margin-bottom: 1rem;
            color: #4a5568;
        }
        .info-card p strong {
            color: #2d3748;
            font-weight: 600;
        }
        .modern-table {
            border-radius: 10px;
            overflow: hidden;
        }
        .modern-table thead {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }
        .modern-table thead th {
            border: none;
            padding: 1rem;
            font-weight: 600;
        }
        .modern-table tbody tr {
            transition: all 0.3s ease;
        }
        .modern-table tbody tr:hover {
            background: #f7fafc;
        }
        .modern-table tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #e2e8f0;
        }
        .modern-table tfoot {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
            font-weight: 700;
        }
        .modern-table tfoot td {
            padding: 1rem;
            border: none;
        }
        .badge-modern {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 600;
        }
        .resume-card {
            background: linear-gradient(135deg, #e0f7fa 0%, #e1f5fe 100%);
            border-radius: 15px;
            padding: 2rem;
            border-left: 5px solid #11998e;
            animation: fadeInUp 0.8s ease-out;
        }
        .resume-card h6 {
            color: #11998e;
            font-weight: 700;
            margin-bottom: 0.75rem;
        }
        .empty-state {
            text-align: center;
            padding: 2rem;
            color: #a0aec0;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/navbar-medecin.jsp" />
    
    <div class="container mt-4">
        <div class="page-header">
            <h2><i class="fas fa-clipboard-list"></i> Détails de la Consultation #${consultation.id}</h2>
        </div>
        
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        
        <div class="row">
            <div class="col-md-6 mb-4">
                <div class="info-card">
                    <div class="card-header-modern primary">
                        <h5><i class="fas fa-user"></i> Informations Patient</h5>
                    </div>
                    <p><strong>Nom:</strong> ${consultation.patient.prenom} ${consultation.patient.nom}</p>
                    <p><strong>Date de Naissance:</strong> ${consultation.patient.dateNaissance}</p>
                    <p><strong>Sexe:</strong> ${consultation.patient.sexe == 'M' ? 'Masculin' : 'Féminin'}</p>
                    <p><strong>Téléphone:</strong> ${consultation.patient.telephone}</p>
                    <p class="mb-0"><strong>Carte:</strong> <span class="badge badge-modern bg-secondary">${consultation.patient.carte}</span></p>
                </div>
            </div>
            
            <div class="col-md-6 mb-4">
                <div class="info-card">
                    <div class="card-header-modern success">
                        <h5><i class="fas fa-stethoscope"></i> Informations Consultation</h5>
                    </div>
                    <p><strong>Date:</strong> ${consultation.createdAt}</p>
                    <p class="mb-0"><strong>Statut:</strong> 
                        <span class="badge badge-modern bg-${consultation.statut == 'TERMINEE' ? 'success' : 'warning'}">
                            <i class="fas fa-${consultation.statut == 'TERMINEE' ? 'check' : 'clock'}"></i> ${consultation.statut}
                        </span>
                    </p>
                </div>
            </div>
        </div>
        
        <div class="info-card mb-4">
            <div class="card-header-modern info">
                <h5><i class="fas fa-syringe"></i> Actes Techniques</h5>
            </div>
            <c:choose>
                <c:when test="${empty consultation.actes}">
                    <div class="empty-state">
                        <i class="fas fa-inbox fa-3x mb-3"></i>
                        <p>Aucun acte technique ajouté</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table modern-table">
                            <thead>
                                <tr>
                                    <th>Code</th>
                                    <th>Libellé</th>
                                    <th>Prix</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="acte" items="${consultation.actes}">
                                    <tr>
                                        <td><code class="badge bg-light text-dark">${acte.name()}</code></td>
                                        <td>${acte.libelle}</td>
                                        <td><strong><fmt:formatNumber value="${acte.prix}" pattern="#,##0.00"/> DH</strong></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="2"><strong><i class="fas fa-calculator"></i> TOTAL</strong></td>
                                    <td><strong><fmt:formatNumber value="${coutTotal}" pattern="#,##0.00"/> DH</strong></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <c:if test="${consultation.statut == 'TERMINEE'}">
            <div class="resume-card mb-4">
                <h5 class="mb-3" style="color: #11998e; font-weight: 700;">
                    <i class="fas fa-file-medical"></i> Résumé de la Consultation
                </h5>
                <h6>Raison de consultation:</h6>
                <p>${consultation.raison}</p>
                <c:if test="${not empty consultation.observation}">
                    <h6>Observations:</h6>
                    <p class="mb-0">${consultation.observation}</p>
                </c:if>
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