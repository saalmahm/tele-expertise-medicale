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
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
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
                                        <th>ID</th>
                                        <th>Patient</th>
                                        <th>Date Naissance</th>
                                        <th>Contact</th>
                                        <th>Heure Arrivée</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="patient" items="${patients}">
                                        <tr>
                                            <td><span class="badge bg-warning">#${patient.id}</span></td>
                                            <td><strong>${patient.prenom} ${patient.nom}</strong></td>
                                            <td>
                                                ${patient.dateNaissance} <!-- Affiche directement la LocalDate -->
                                            </td>
                                            <td><i class="fas fa-phone"></i> ${patient.telephone}</td>
                                            <td>
                                                ${patient.dateEnregistrement.toLocalTime()} <!-- Affiche uniquement l'heure -->
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/medecin/consulter-patient?id=${patient.id}" 
                                                   class="btn btn-sm btn-primary">
                                                    <i class="fas fa-stethoscope"></i> Consulter
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
            <a href="${pageContext.request.contextPath}/medecin" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left"></i> Retour
            </a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>