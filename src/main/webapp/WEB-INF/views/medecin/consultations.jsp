<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toutes les Consultations</title>
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
        .modern-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            animation: fadeInUp 0.6s ease-out;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .modern-table {
            border-radius: 10px;
            overflow: hidden;
        }
        .modern-table thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            transform: scale(1.01);
        }
        .modern-table tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #e2e8f0;
        }
        .badge-modern {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 600;
        }
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
        }
        .empty-state i {
            color: #cbd5e0;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/navbar-medecin.jsp" />
    
    <div class="container mt-4">
        <div class="page-header">
            <h2><i class="fas fa-clipboard-list"></i> Toutes les Consultations</h2>
        </div>
        
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        
        <div class="modern-card">
            <c:choose>
                <c:when test="${empty consultations}">
                    <div class="empty-state">
                        <i class="fas fa-inbox fa-4x"></i>
                        <p class="text-muted fs-5">Aucune consultation enregistrée</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table modern-table">
                            <thead>
                                <tr>
                                    <th>Patient</th>
                                    <th>Date</th>
                                    <th>Statut</th>
                                    <th>Observation</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="consultation" items="${consultations}">
                                    <tr>
                                        <td><strong>${consultation.patient.prenom} ${consultation.patient.nom}</strong></td>
                                        <td>
                                            ${consultation.createdAt}
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${consultation.statut.name() == 'TERMINEE'}">
                                                    <span class="badge badge-modern bg-success">
                                                        <i class="fas fa-check"></i> Terminée
                                                    </span>
                                                </c:when>
                                                <c:when test="${consultation.statut.name() == 'EN_COURS'}">
                                                    <span class="badge badge-modern bg-warning">
                                                        <i class="fas fa-spinner"></i> En Cours
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-modern bg-secondary">
                                                        <i class="fas fa-clock"></i> En Attente
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty consultation.observation}">
                                                    ${consultation.observation.substring(0, consultation.observation.length() > 50 ? 50 : consultation.observation.length())}...
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Non renseigné</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/medecin/consultation-details?id=${consultation.id}" 
                                               class="btn btn-sm btn-info">
                                                <i class="fas fa-eye"></i> Détails
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <p class="text-muted mt-3">
                        Total: <strong>${consultations.size()}</strong> consultation(s)
                    </p>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/medecin/accueil" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left"></i> Retour
            </a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>