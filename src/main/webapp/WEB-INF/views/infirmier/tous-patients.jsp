<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Tous les patients</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .table th { background-color: #f8f9fa; }
    </style>
</head>
<body>
    <div class="container mt-4">
        <h2 class="mb-4">Liste des patients</h2>
        
        <div class="card">
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty patients}">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nom et Prénom</th>
                                        <th>Date de naissance</th>
                                        <th>Téléphone</th>
                                        <th>Sexe</th>
                                        <th>Date d'enregistrement</th>
                                        <th>Statut</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="patient" items="${patients}">
                                        <tr>
                                            <td>#${patient.id}</td>
                                            <td><strong>${patient.prenom} ${patient.nom}</strong></td>
                                            <td>${patient.dateNaissanceFormatee}</td>

                                            <td>${patient.telephone}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${patient.sexe == 'M'}">
                                                        <i class="fas fa-mars text-primary"></i> M
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-venus text-danger"></i> F
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${patient.dateEnregistrementFormatee}</td>

                                            
                                            <td>
                                                <span class="badge ${patient.statut == 'EN_ATTENTE' ? 'bg-warning' : 'bg-success'}">
                                                    ${patient.statut}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info">
                            Aucun patient enregistré pour le moment.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="mt-3">
            <a href="${pageContext.request.contextPath}/infirmier" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Retour
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>