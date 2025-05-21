<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Generate Report - InventaX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fc;
    }
    .sidebar {
      background-color: #2c3e50;
      color: white;
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
    .card {
      background-color: #495057;
      border: none;
      color: #f8f9fa;
      border-radius: 8px;
    }
    .card-header {
      background-color: #5a6268;
      border-bottom: 1px solid #6c757d;
      color: #f8f9fa;
    }
    .form-label {
      color: #adb5bd;
    }
    .form-control,
    .form-select {
      background-color: #6c757d;
      color: #f8f9fa;
      border: 1px solid #868e96;
    }
    .form-control::placeholder,
    .form-select {
      color: #adb5bd;
    }
    .form-select option {
      background-color: #6c757d;
      color: #f8f9fa;
    }
    .form-control:focus,
    .form-select:focus {
      background-color: #6c757d;
      color: #f8f9fa;
      border-color: #0d6efd;
      box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
    }
    .form-text {
      color: #adb5bd;
    }
    .btn-primary {
      background-color: #0d6efd;
      border-color: #0d6efd;
    }
    .btn-secondary {
      background-color: #6c757d;
      border-color: #6c757d;
    }
    .btn-primary:hover {
      background-color: #0b5ed7;
      border-color: #0a58ca;
    }
    .btn-secondary:hover {
      background-color: #5c636a;
      border-color: #565e64;
    }
    h2 {
      color: #f8f9fa;
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
    .alert {
      background-color: #495057;
      border-color: #343a40;
      color: #f8f9fa;
    }
    .alert-success {
      background-color: #198754;
      border-color: #198754;
    }
    .alert-danger {
      background-color: #dc3545;
      border-color: #dc3545;
    }
    .alert .btn-close {
      filter: invert(1) grayscale(100%) brightness(200%);
    }
  </style>
</head>
<body>
<div class="container-fluid">
  <div class="row">
    <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
      <div class="position-sticky pt-3">
        <h4 class="text-center mb-3">
          <a href="dashboard" class="logo-link">InventaX</a>
        </h4>
        <ul class="nav flex-column">
          <li class="nav-item">
            <a class="nav-link" href="dashboard">
              <i class="fas fa-tachometer-alt me-2"></i>Dashboard
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="inventory?action=list">
              <i class="fas fa-boxes me-2"></i>Inventory
            </a>
          </li>
          <c:if test="${sessionScope.loggedUser.role == 'admin'}">
            <li class="nav-item">
              <a class="nav-link" href="user">
                <i class="fas fa-user me-2"></i>Users
              </a>
            </li>
          </c:if>
          <li class="nav-item">
            <a class="nav-link" href="suppliers?action=list">
              <i class="fas fa-truck me-2"></i>Suppliers
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="purchases?action=list">
              <i class="fas fa-shopping-cart me-2"></i>Purchases
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="sales?action=list">
              <i class="fas fa-chart-line me-2"></i>Sales
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="reports">
              <i class="fas fa-file-alt me-2"></i>Reports
            </a>
          </li>
          <li class="nav-item mt-auto">
            <a class="nav-link" href="logout">
              <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
          </li>
        </ul>
      </div>
    </nav>

    <main class="col-md-9 ms-sm-auto col-lg-10 main-content">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-4 border-bottom border-secondary">
        <h2 class="h2">Generate Report</h2>
        <a href="reports" class="btn btn-secondary">
          <i class="fas fa-arrow-left me-1"></i> Back to Reports
        </a>
      </div>

      <div class="row justify-content-center">
        <div class="col-lg-8">
          <div class="card">
            <div class="card-header">
              <h5 class="mb-0"><i class="fas fa-file-alt me-2"></i> Report Configuration</h5>
            </div>
            <div class="card-body p-4">
              <form action="reports" method="post">
                <input type="hidden" name="action" value="generate">

                <div class="mb-3">
                  <label for="reportType" class="form-label">Report Type</label>
                  <select class="form-select" id="reportType" name="reportType" required>
                    <option value="">Select report type</option>
                    <option value="inventory">Inventory Status</option>
                    <option value="sales">Sales Report</option>
                    <option value="purchases">Purchases Report</option>
                  </select>
                </div>

                <div class="mb-3">
                  <label for="startDate" class="form-label">Start Date</label>
                  <input type="date" class="form-control" id="startDate" name="startDate" required>
                </div>

                <div class="mb-3">
                  <label for="endDate" class="form-label">End Date</label>
                  <input type="date" class="form-control" id="endDate" name="endDate" required>
                </div>

                <div class="mb-3">
                  <label for="format" class="form-label">Report Format</label>
                  <select class="form-select" id="format" name="format" required>
                    <option value="">Select format</option>
                    <option value="pdf">PDF</option>
                    <option value="excel">Excel</option>
                    <option value="csv">CSV</option>
                  </select>
                </div>

                <div class="d-flex justify-content-end mt-4">
                  <a href="reports" class="btn btn-secondary me-2">Cancel</a>
                  <button type="submit" class="btn btn-primary">
                    <i class="fas fa-file-export me-1"></i> Generate Report
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>