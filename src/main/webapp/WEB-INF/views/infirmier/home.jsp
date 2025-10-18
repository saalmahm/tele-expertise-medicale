<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module Infirmier</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .dashboard-header {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            animation: slideDown 0.5s ease-out;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .dashboard-header h2 {
            color: #2d3748;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .dashboard-header h2 i {
            color: #667eea;
            font-size: 2rem;
        }
        
        .action-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            height: 100%;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border: none;
            animation: fadeInUp 0.6s ease-out;
            animation-fill-mode: both;
        }
        
        .action-card:nth-child(1) { animation-delay: 0.1s; }
        .action-card:nth-child(2) { animation-delay: 0.2s; }
        .action-card:nth-child(3) { animation-delay: 0.3s; }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .action-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 12px 30px rgba(102, 126, 234, 0.2);
        }
        
        .card-icon {
            width: 70px;
            height: 70px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            font-size: 2rem;
            color: white;
        }
        
        .card-icon.primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }
        
        .card-icon.success {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            box-shadow: 0 8px 20px rgba(17, 153, 142, 0.3);
        }
        
        .card-icon.info {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            box-shadow: 0 8px 20px rgba(79, 172, 254, 0.3);
        }
        
        .action-card h5 {
            color: #2d3748;
            font-weight: 700;
            font-size: 1.3rem;
            margin-bottom: 1rem;
        }
        
        .action-card p {
            color: #718096;
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }
        
        .btn-action {
            padding: 0.75rem 1.5rem;
            border-radius: 10px;
            font-weight: 600;
            border: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .btn-action.primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        
        .btn-action.primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        .btn-action.success {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(17, 153, 142, 0.3);
        }
        
        .btn-action.success:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(17, 153, 142, 0.4);
            color: white;
        }
        
        .btn-action.info {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(79, 172, 254, 0.3);
        }
        
        .btn-action.info:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(79, 172, 254, 0.4);
            color: white;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/navbar-infirmier.jsp" />
    
    <div class="container mt-4">
        <div class="dashboard-header">
            <h2>
                <i class="fas fa-chart-line"></i>
                Tableau de Bord Infirmier
            </h2>
        </div>
        
        <div class="row g-4">
            <div class="col-md-6 col-lg-4">
                <div class="action-card">
                    <div class="card-icon primary">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <h5>Enregistrer un Patient</h5>
                    <p>Rechercher et enregistrer un nouveau patient avec ses signes vitaux dans le système</p>
                    <a href="${pageContext.request.contextPath}/infirmier/rechercher-patient" class="btn btn-action primary">
                        <i class="fas fa-search"></i> Rechercher Patient
                    </a>
                </div>
            </div>
            
            <div class="col-md-6 col-lg-4">
                <div class="action-card">
                    <div class="card-icon success">
                        <i class="fas fa-calendar-day"></i>
                    </div>
                    <h5>Patients du Jour</h5>
                    <p>Consulter la liste des patients enregistrés et traités aujourd'hui</p>
                    <a href="${pageContext.request.contextPath}/infirmier/patients" class="btn btn-action success">
                        <i class="fas fa-eye"></i> Voir les Patients
                    </a>
                </div>
            </div>
            
            <div class="col-md-6 col-lg-4">
                <div class="action-card">
                    <div class="card-icon info">
                        <i class="fas fa-database"></i>
                    </div>
                    <h5>Tous les Patients</h5>
                    <p>Accéder à la base de données complète de tous les patients enregistrés</p>
                    <a href="${pageContext.request.contextPath}/infirmier/tous-patients" class="btn btn-action info">
                        <i class="fas fa-list"></i> Tous les Patients
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>