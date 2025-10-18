<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patients en Attente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/navbar-medecin.jsp" />
    
    <div class="container mt-4">
        <h2><i class="fas fa-user-clock"></i> Patients en Attente</h2>
        
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
                    <c:when test="${not empty patients}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>N°</th>
                                        <th>Patient</th>
                                        <th>Date Naissance</th>
                                        <th>Contact</th>
                                        <th>Heure Arrivée</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="patient" items="${patients}" varStatus="status">
                                        <tr>
                                            <td>
                                                <span class="badge ${status.index == 0 ? 'bg-danger' : 'bg-secondary'} fs-6">
                                                    ${status.index + 1}
                                                </span>
                                            </td>
                                            <td>
                                                <strong>${patient.prenom} ${patient.nom}</strong>
                                                ${status.index == 0 ? '<span class="badge bg-danger ms-2">PRIORITAIRE</span>' : ''}
                                            </td>
                                            <td>
                                                ${patient.dateNaissance}
                                            </td>
                                            <td><i class="fas fa-phone"></i> ${patient.telephone}</td>
                                            <td>
                                                ${patient.createdAt.toLocalTime()}
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/medecin/creer-consultation?patientId=${patient.id}" 
                                                   class="btn btn-sm ${status.index == 0 ? 'btn-danger' : 'btn-primary'}">
                                                    <i class="fas fa-stethoscope"></i> ${status.index == 0 ? 'Consulter en PRIORITÉ' : 'Consulter'}
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-inbox fa-4x text-muted mb-3"></i>
                            <p class="text-muted">Aucun patient en attente</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
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