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
        <h2><i class="fas fa-clipboard-list"></i> Toutes les Consultations</h2>
        
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        
        <div class="card mt-4">
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty consultations}">
                        <div class="text-center py-5">
                            <i class="fas fa-inbox fa-4x text-muted mb-3"></i>
                            <p class="text-muted">Aucune consultation enregistrée</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Patient</th>
                                        <th>Date</th>
                                        <th>Statut</th>
                                        <th>Diagnostic</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="consultation" items="${consultations}">
                                        <tr>
                                            <td><span class="badge bg-primary">#${consultation.id}</span></td>
                                            <td><strong>${consultation.patient.prenom} ${consultation.patient.nom}</strong></td>
                                            <td>
                                                <fmt:formatDate value="${consultation.dateConsultation}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${consultation.statut == 'TERMINEE'}">
                                                        <span class="badge bg-success">
                                                            <i class="fas fa-check"></i> Terminée
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${consultation.statut == 'EN_COURS'}">
                                                        <span class="badge bg-warning">
                                                            <i class="fas fa-spinner"></i> En Cours
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">
                                                            <i class="fas fa-clock"></i> En Attente
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty consultation.diagnostic}">
                                                        ${consultation.diagnostic.substring(0, consultation.diagnostic.length() > 50 ? 50 : consultation.diagnostic.length())}...
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
        </div>
        
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/medecin" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left"></i> Retour
            </a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>