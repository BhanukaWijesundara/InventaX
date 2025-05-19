<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Suppliers - InventaX</title>
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
        .table {
            color: #f8f9fa;
            background-color: #495057;
            border-color: #454d55;
            border-radius: 5px;
            overflow: hidden;
        }
        .table th {
            color: #adb5bd;
            background-color: #495057;
            border-color: #454d55 !important;
            border-bottom-width: 1px !important;
        }
        .table td {
            border-color: #454d55 !important;
            background-color: #495057;
        }
        .table tbody tr:hover td {
            background-color: #5a6268;
        }
        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }
        .btn-primary {
            background-color: #0d6efd;
            border-color: #0d6efd;
        }
        .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
            color: #000;
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
        .alert-success {
            background-color: #198754;
            color: white;
            border-color: #198754;
        }
        .alert-info {
            background-color: #0dcaf0;
            color: #000;
            border-color: #0dcaf0;
        }
        .alert .btn-close {
            filter: invert(1) grayscale(100%) brightness(200%);
        }
        .action-buttons a, .action-buttons form button {
            margin-right: 0.25rem;
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
                        <a class="nav-link active" href="suppliers?action=list">
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
                        <a class="nav-link" href="reports">
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
                <h2 class="h2">Supplier Management</h2>
                <a href="suppliers?action=add" class="btn btn-success">
                    <i class="fas fa-plus me-1"></i> Add New Supplier
                </a>
            </div>

            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Contact</th>
                        <th>Email</th>
                        <c:if test="${sessionScope.loggedUser.role == 'admin'}">
                            <th>Actions</th>
                        </c:if>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${not empty suppliers}">
                            <c:forEach items="${suppliers}" var="supplier">
                                <tr>
                                    <td>${supplier.supplierId}</td>
                                    <td>${supplier.name}</td>
                                    <td>${supplier.contact}</td>
                                    <td>${supplier.email}</td>
                                    <c:if test="${sessionScope.loggedUser.role == 'admin'}">
                                        <td>
                                            <a href="suppliers?action=edit&id=${supplier.supplierId}" class="btn btn-sm btn-warning">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <form action="suppliers" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this supplier?')">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="supplierId" value="${supplier.supplierId}">
                                                <button type="submit" class="btn btn-sm btn-danger">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="text-center p-4">
                                    <p class="text-muted mb-2">No suppliers found.</p>
                                    <a href="suppliers?action=add" class="btn btn-primary">
                                        <i class="fas fa-plus-circle me-1"></i> Add First Supplier
                                    </a>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>