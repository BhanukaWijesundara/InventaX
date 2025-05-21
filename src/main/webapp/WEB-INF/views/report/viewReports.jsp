<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>View Reports - InventaX</title>
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
      padding-top: 1rem;
    }
    .card {
      background-color: #495057;
      border: none;
      color: #f8f9fa;
    }
    .card-header {
      background-color: #495057;
      color: white;
      border-bottom: 1px solid #343a40;
    }
    .table {
      color: #f8f9fa;
      background-color: #495057;
      border-color: #5a6268;
    }
    .table thead th {
      border-bottom: 2px solid #5a6268;
      color: #f8f9fa;
      background-color: #495057;
    }
    .table td {
      border-top: 1px solid #5a6268;
      background-color: #495057;
    }
    .table tbody tr:hover td {
      background-color: #5a6268;
    }
    .btn-primary {
      background-color: #2980b9;
      border-color: #2980b9;
    }
    .btn-primary:hover {
      background-color: #2471a3;
      border-color: #2471a3;
    }
    .btn-info {
      background-color: #17a2b8;
      border-color: #17a2b8;
      color: white;
    }
    .btn-info:hover {
      background-color: #138496;
      border-color: #117a8b;
      color: white;
    }
    .alert {
      background-color: #495057;
      border-color: #343a40;
      color: #f8f9fa;
    }
    .alert-success {
      background-color: #28a745;
      border-color: #23923d;
    }
    .alert-danger {
      background-color: #dc3545;
      border-color: #bd2130;
    }
    .border-bottom {
      border-color: #454d55 !important;
    }
    h1.h2, h6.m-0 {
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
    .stock-table {
      margin-top: 20px;
    }
    .stock-table th {
      background-color: #f8f9fa;
    }
    .stock-status {
      font-weight: bold;
    }
    .stock-status.low {
      color: #dc3545;
    }
    .stock-status.medium {
      color: #ffc107;
    }
    .stock-status.good {
      color: #28a745;
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

    <!-- Main content -->
    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Reports</h1>
        <div class="d-flex gap-2">
          <a href="reports?action=generate" class="btn btn-primary">
            <i class="fas fa-plus me-2"></i> Generate Report
          </a>
        </div>
      </div>

      <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${successMessage}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      </c:if>

      <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${errorMessage}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      </c:if>

      <div class="card">
        <div class="card-body">
          <c:if test="${empty reports}">
            <div class="text-center py-5">
              <i class="fas fa-file-alt fa-3x mb-3 text-muted"></i>
              <h5>No Reports Generated</h5>
              <p class="text-muted">Generate your first report to see it here.</p>
              <a href="reports?action=generate" class="btn btn-primary">
                <i class="fas fa-plus me-2"></i> Generate Report
              </a>
            </div>
          </c:if>

          <c:if test="${not empty reports}">
            <div class="table-responsive">
              <table class="table">
                <thead>
                <tr>
                  <th>Report Type</th>
                  <th>Period</th>
                  <th>Generated Date</th>
                  <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${reports}" var="report">
                  <tr>
                    <td>
                      <c:choose>
                        <c:when test="${report.reportType == 'inventory'}">
                                                            <span class="badge bg-info">
                                                                <i class="fas fa-boxes me-1"></i> Inventory Status
                                                            </span>
                        </c:when>
                        <c:when test="${report.reportType == 'sales'}">
                                                            <span class="badge bg-success">
                                                                <i class="fas fa-chart-line me-1"></i> Sales Report
                                                            </span>
                        </c:when>
                        <c:when test="${report.reportType == 'purchases'}">
                                                            <span class="badge bg-warning text-dark">
                                                                <i class="fas fa-shopping-cart me-1"></i> Purchases Report
                                                            </span>
                        </c:when>
                      </c:choose>
                    </td>
                    <td>
                      <i class="fas fa-calendar-alt me-1"></i>
                        ${report.startDate} to ${report.endDate}
                    </td>
                    <td>
                      <i class="fas fa-clock me-1"></i>
                        ${report.generatedDate}
                    </td>
                    <td>
                      <div class="btn-group">
                        <a href="reports?action=preview&id=${report.reportId}"
                           class="btn btn-info btn-sm">
                          <i class="fas fa-eye me-1"></i> Preview
                        </a>
                        <button type="button"
                                class="btn btn-danger btn-sm"
                                data-bs-toggle="modal"
                                data-bs-target="#deleteModal${report.reportId}">
                          <i class="fas fa-trash me-1"></i> Delete
                        </button>
                      </div>

                      <!-- Delete Modal -->
                      <div class="modal fade" id="deleteModal${report.reportId}" tabindex="-1">
                        <div class="modal-dialog">
                          <div class="modal-content bg-dark text-light">
                            <div class="modal-header">
                              <h5 class="modal-title">Confirm Delete</h5>
                              <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                              Are you sure you want to delete this report?
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                              <form action="reports" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${report.reportId}">
                                <button type="submit" class="btn btn-danger">Delete</button>
                              </form>
                            </div>
                          </div>
                        </div>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
                </tbody>
              </table>
            </div>
          </c:if>
        </div>
      </div>

      <!-- Available Stocks Section -->
      <div class="card stock-table">
        <div class="card-header">
          <h4>Current Stock Levels</h4>
        </div>
        <div class="card-body">
          <table class="table table-striped">
            <thead>
            <tr>
              <th>Item ID</th>
              <th>Name</th>
              <th>Quantity</th>
              <th>Status</th>
              <th>Category</th>
              <th>Expiry Date</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${inventoryItems}" var="item">
              <tr>
                <td>${item.itemId}</td>
                <td>${item.itemName}</td>
                <td>${item.quantity}</td>
                <td>
                  <c:choose>
                    <c:when test="${item.quantity <= 5}">
                      <span class="stock-status low">Low Stock</span>
                    </c:when>
                    <c:when test="${item.quantity <= 15}">
                      <span class="stock-status medium">Medium Stock</span>
                    </c:when>
                    <c:otherwise>
                      <span class="stock-status good">Good Stock</span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>${item.category}</td>
                <td>${item.expiryDate}</td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </main>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 