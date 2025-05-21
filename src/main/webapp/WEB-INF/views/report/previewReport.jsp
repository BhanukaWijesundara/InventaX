<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Report Preview - InventaX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fc;
    }
    .sidebar {
      background-color: #2c3e50;
      color: white;
      min-height: 100vh;
    }
    .sidebar .nav-link {
      color: rgba(255, 255, 255, 0.8);
    }
    .sidebar .nav-link.active,
    .sidebar .nav-link:hover {
      color: white;
      background-color: rgba(255, 255, 255, 0.1);
    }
    .main-content {
      background-color: #343a40;
      color: #f8f9fa;
      min-height: 100vh;
      padding: 2rem;
    }
    .report-container {
      background-color: #495057;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      padding: 2rem;
      margin-top: 1rem;
    }
    .report-header {
      border-bottom: 2px solid #6c757d;
      padding-bottom: 1rem;
      margin-bottom: 2rem;
    }
    .report-content {
      background-color: #343a40;
      border-radius: 8px;
      padding: 1.5rem;
      font-family: 'Courier New', monospace;
      white-space: pre-wrap;
      line-height: 1.6;
      color: #e9ecef;
    }
    .btn-back {
      background-color: #2980b9;
      border-color: #2980b9;
      color: white;
      transition: all 0.3s ease;
    }
    .btn-back:hover {
      background-color: #2471a3;
      border-color: #2471a3;
      color: white;
      transform: translateY(-2px);
    }
    .logo-link {
      text-decoration: none;
      color: white;
      font-weight: bold;
      font-size: 1.5rem;
      transition: color 0.3s ease;
    }
    .logo-link:hover {
      color: #0d6efd;
    }
    .report-title {
      color: #e9ecef;
      font-size: 1.8rem;
      margin-bottom: 0.5rem;
    }
    .report-meta {
      color: #adb5bd;
      font-size: 0.9rem;
    }
    .report-section {
      margin-bottom: 2rem;
    }
    .report-section-title {
      color: #17a2b8;
      font-size: 1.2rem;
      margin-bottom: 1rem;
      padding-bottom: 0.5rem;
      border-bottom: 1px solid #6c757d;
    }
    .table {
      color: #e9ecef;
      background-color: #343a40;
      border-color: #6c757d;
    }
    .table thead th {
      background-color: #495057;
      border-bottom: 2px solid #6c757d;
      color: #e9ecef;
    }
    .table td {
      border-top: 1px solid #6c757d;
      vertical-align: middle;
    }
    .table tbody tr:hover {
      background-color: #495057;
    }
    .badge {
      font-size: 0.9em;
      padding: 0.5em 0.8em;
    }
    .badge-inventory {
      background-color: #17a2b8;
    }
    .badge-sales {
      background-color: #28a745;
    }
    .badge-purchases {
      background-color: #ffc107;
      color: #212529;
    }
  </style>
</head>
<body>
<div class="container-fluid">
  <div class="row">
    <!-- Sidebar -->
    <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
      <div class="position-sticky pt-3">
        <h4 class="text-center mb-3">
          <a href="dashboard" class="logo-link">InventaX</a>
        </h4>
        <ul class="nav flex-column">
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
              <i class="fas fa-tachometer-alt me-2"></i>Dashboard
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/inventory?action=list">
              <i class="fas fa-boxes me-2"></i>Inventory
            </a>
          </li>
          <c:if test="${sessionScope.loggedUser.role == 'admin'}">
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/user">
                <i class="fas fa-user me-2"></i>Users
              </a>
            </li>
          </c:if>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/suppliers?action=list">
              <i class="fas fa-truck me-2"></i>Suppliers
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/purchases?action=list">
              <i class="fas fa-shopping-cart me-2"></i>Purchases
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/sales">
              <i class="fas fa-chart-line me-2"></i>Sales
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="${pageContext.request.contextPath}/reports">
              <i class="fas fa-file-alt me-2"></i>Reports
            </a>
          </li>
          <li class="nav-item mt-auto">
            <a class="nav-link" href="${pageContext.request.contextPath}/logout">
              <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
          </li>
        </ul>
      </div>
    </nav>

    <!-- Main Content -->
    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3">
        <div>
          <h1 class="h2 mb-0">Report Preview</h1>
          <p class="text-muted mt-2">View the generated report details</p>
        </div>
        <div class="btn-toolbar mb-2 mb-md-0">
          <a href="${pageContext.request.contextPath}/reports" class="btn btn-back">
            <i class="fas fa-arrow-left me-2"></i>Back to Reports
          </a>
        </div>
      </div>

      <div class="report-container">
        <div class="report-header">
          <h2 class="report-title">
            <i class="fas fa-file-alt me-2"></i>
            ${reportType} Report
          </h2>
          <div class="report-meta">
            <i class="fas fa-calendar-alt me-2"></i>
            Generated on: ${generatedDate}
          </div>
        </div>

        <div class="report-content">
          ${reportContent}
        </div>
      </div>
    </main>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 
