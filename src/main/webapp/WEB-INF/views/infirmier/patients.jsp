<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patients du Jour</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        .badge-EN_ATTENTE { background-color: #ffc107; }
        .badge-EN_CONSULTATION { background-color: #0dcaf0; }
        .badge-TERMINE { background-color: #198754; }
    </style>
</head>
<body>
<!-- Barre de navigation -->
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
    <!-- Titre + bouton -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-calendar-day"></i> Patients du Jour</h2>
        <a href="${pageContext.request.contextPath}/infirmier/enregistrer" class="btn btn-primary">
            <i class="fas fa-plus"></i> Nouveau Patient
        </a>
    </div>

    <!-- Message de succès -->
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="successMessage" scope="session"/>
    </c:if>

    <%-- Liste des patients --%>
    <div class="card shadow-sm">
        <div class="card-body">
            <c:choose>
                <%-- Aucun patient --%>
                <c:when test="${empty patients}">
                    <div class="text-center py-5">
                        <i class="fas fa-inbox fa-4x text-muted mb-3"></i>
                        <p class="text-muted">Aucun patient enregistré aujourd'hui</p>
                        <a href="${pageContext.request.contextPath}/infirmier/enregistrer" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Enregistrer un Patient
                        </a>
                    </div>
                </c:when>

                <%-- Patients trouvés --%>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Nom Complet</th>
                                <th>Sexe</th>
                                <th>Téléphone</th>
                                <th>Heure d'Enregistrement</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="patient" items="${patients}">
                                <tr>
                                    <td>#${patient.id}</td>
                                    <td><strong>${patient.prenom} ${patient.nom}</strong></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${patient.sexe == 'M'}">
                                                <i class="fas fa-mars text-primary"></i> Masculin
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-venus text-danger"></i> Féminin
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${patient.telephone}</td>
                                    <td>
                                        <c:if test="${not empty patient.dateEnregistrement}">
                                            ${patient.dateEnregistrement.toLocalTime()}
                                        </c:if>
                                    </td>

                                    <td>
                                    <span class="badge text-white px-3 py-2 fs-6 badge-${patient.statut}">
                                        <c:choose>
                                            <c:when test="${patient.statut == 'EN_ATTENTE'}">
                                                <i class="fas fa-clock"></i> En Attente
                                            </c:when>
                                            <c:when test="${patient.statut == 'EN_CONSULTATION'}">
                                                <i class="fas fa-stethoscope"></i> En Consultation
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-check"></i> Terminé
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/infirmier/patient/${patient.id}"
                                           class="btn btn-sm btn-info text-white"
                                           data-bs-toggle="tooltip" title="Voir Détails">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-3">
                        <p class="text-muted">
                            <i class="fas fa-info-circle"></i>
                            Total : <strong>${patients.size()}</strong> patient(s) enregistré(s) aujourd'hui
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>


    <!-- Bouton retour -->
    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/infirmier" class="btn btn-outline-secondary">
            <i class="fas fa-arrow-left"></i> Retour
        </a>
    </div>
</div>

<!-- Scripts Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Initialiser les tooltips Bootstrap
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    })
</script>
</body>
</html>
