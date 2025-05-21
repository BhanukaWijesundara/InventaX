<%--
  Created by IntelliJ IDEA.
  User: Hasanthi
  Date: 5/21/2025
  Time: 10:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dashboard - InventaX</title>
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
    .dashboard-card {
      border: none;
      border-radius: 5px;
      color: white;
      padding: 1.5rem;
      margin-bottom: 1rem;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      position: relative;
      overflow: hidden;
      cursor: pointer;
      transition: transform 0.3s ease;
    }
    .dashboard-card:hover {
      transform: translateY(-5px);
    }
    .dashboard-card .card-body {
      padding: 0;
      position: relative;
      z-index: 2;
    }
    .dashboard-card .card-title {
      font-size: 0.9rem;
      text-transform: uppercase;
      margin-bottom: 0.5rem;
      font-weight: bold;
    }
    .dashboard-card .card-count {
      font-size: 2rem;
      font-weight: bold;
      margin-bottom: 0;
    }
    .dashboard-card .card-icon {
      font-size: 4rem;
      position: absolute;
      right: 15px;
      bottom: 10px;
      opacity: 0.3;
      z-index: 1;
      transition: transform 0.3s ease;
    }
    .dashboard-card:hover .card-icon {
      transform: scale(1.1);
    }
    .card-sales { background-color: #2980b9; }
    .card-purchases { background-color: #27ae60; }
    .card-suppliers { background-color: #34495e; }
    .card-items { background-color: #16a085; }

    .table {
      color: #f8f9fa;
    }
    .table th {
      color: #adb5bd;
      border-color: #454d55 !important;
    }
    .table td {
      border-color: #454d55 !important;
    }
    .card-header {
      background-color: #495057;
      color: white;
      border-bottom: 1px solid #343a40;
    }
    .card {
      background-color: #495057;
      border: none;
    }
    .border-bottom {
      border-color: #454d55 !important;
    }
    h1.h2, h6.m-0 {
      color: #f8f9fa;
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/dashboard">
              <i class="fas fa-tachometer-alt me-2"></i>Dashboard
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/inventory">
              <i class="fas fa-boxes me-2"></i>Inventory
            </a>
          </li>
          <c:if test="${sessionScope.loggedUser.role == 'admin'}">
            <li class="nav-item">
              <a class="nav-link" href="user"><i class="fas fa-user me-2"></i>Users</a>
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
            <a class="nav-link" href="${pageContext.request.contextPath}/reports">
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
        <h1 class="h2">Dashboard</h1>
      </div>

      <!-- Stats Cards -->
      <div class="row mb-4">
        <div class="col-lg-3 col-md-6 mb-4">
          <a href="${pageContext.request.contextPath}/sales" class="text-decoration-none">
            <div class="card dashboard-card card-sales">
              <div class="card-body">
                <div class="card-count">${totalSales}</div>
                <div class="card-title">Sale Orders</div>
              </div>
              <i class="fas fa-chart-line card-icon"></i>
            </div>
          </a>
        </div>
        <div class="col-lg-3 col-md-6 mb-4">
          <a href="${pageContext.request.contextPath}/purchases?action=list" class="text-decoration-none">
            <div class="card dashboard-card card-purchases">
              <div class="card-body">
                <div class="card-count">${totalPurchases}</div>
                <div class="card-title">Purchase Orders</div>
              </div>
              <i class="fas fa-shopping-cart card-icon"></i>
            </div>
          </a>
        </div>
        <div class="col-lg-3 col-md-6 mb-4">
          <a href="${pageContext.request.contextPath}/inventory" class="text-decoration-none">
            <div class="card dashboard-card card-items">
              <div class="card-body">
                <div class="card-count">${totalItems}</div>
                <div class="card-title">Item Registry</div>
              </div>
              <i class="fas fa-boxes card-icon"></i>
            </div>
          </a>
        </div>
        <div class="col-lg-3 col-md-6 mb-4">
          <a href="${pageContext.request.contextPath}/suppliers?action=list" class="text-decoration-none">
            <div class="card dashboard-card card-suppliers">
              <div class="card-body">
                <div class="card-count">${totalSuppliers}</div>
                <div class="card-title">Supplier Registry</div>
              </div>
              <i class="fas fa-truck card-icon"></i>
            </div>
          </a>
        </div>
      </div>

      <!-- Recent Purchases -->
      <div class="card shadow mb-4">
        <div class="card-header py-3">
          <h6 class="m-0 font-weight-bold">Recent Purchases (Last 7 Days)</h6>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-hover" width="100%" cellspacing="0">
              <thead>
              <tr>
                <th>ID</th>
                <th>Supplier</th>
                <th>Date</th>
                <th>Quantity</th>
                <th>Status</th>
              </tr>
              </thead>
              <tbody>
              <c:choose>
                <c:when test="${not empty recentPurchases}">
                  <c:forEach items="${recentPurchases}" var="purchase">
                    <tr>
                      <td>${purchase.id}</td>
                      <td>${purchase.supplierName}</td>
                      <td>${purchase.date}</td>
                      <td>${purchase.quantity}</td>
                      <td>
                        <span class="badge bg-${purchase.statusColor}">${purchase.status}</span>
                      </td>
                    </tr>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <tr>
                    <td colspan="5" class="text-center">No recent purchases found.</td>
                  </tr>
                </c:otherwise>
              </c:choose>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Expiring Items -->
      <div class="card shadow mb-4">
        <div class="card-header py-3">
          <h6 class="m-0 font-weight-bold">Items Expiring Soon (Next 7 Days)</h6>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-hover" width="100%" cellspacing="0">
              <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Category</th>
                <th>Quantity</th>
                <th>Expiry Date</th>
                <th>Days Left</th>
              </tr>
              </thead>
              <tbody>
              <c:choose>
                <c:when test="${not empty expiringItemsList}">
                  <c:forEach items="${expiringItemsList}" var="item">
                    <tr>
                      <td>${item.id}</td>
                      <td>${item.name}</td>
                      <td>${item.category}</td>
                      <td>${item.quantity}</td>
                      <td>${item.expiryDate}</td>
                      <td>${item.daysUntilExpiry}</td>
                    </tr>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <tr>
                    <td colspan="6" class="text-center">No items expiring soon.</td>
                  </tr>
                </c:otherwise>
              </c:choose>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Low Stock Items -->
      <div class="card shadow mb-4">
        <div class="card-header py-3">
          <h6 class="m-0 font-weight-bold">Low Stock Items (<= 5 Units)</h6>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-hover" width="100%" cellspacing="0">
              <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Category</th>
                <th>Quantity</th>
                <th>Expiry Date</th>
              </tr>
              </thead>
              <tbody>
              <c:choose>
                <c:when test="${not empty lowStockItemsList}">
                  <c:forEach items="${lowStockItemsList}" var="item">
                    <tr>
                      <td>${item.itemId}</td>
                      <td>${item.itemName}</td>
                      <td>${item.category}</td>
                      <td>${item.quantity}</td>
                      <td>${item.expiryDate}</td>
                    </tr>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <tr>
                    <td colspan="5" class="text-center">No low stock items found.</td>
                  </tr>
                </c:otherwise>
              </c:choose>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </main>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


