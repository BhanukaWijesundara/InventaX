<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management - InventaX</title>
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
        .btn-primary {
            background-color: #2980b9;
            border-color: #2980b9;
        }
        .btn-primary:hover {
            background-color: #2471a3;
            border-color: #2471a3;
        }
        .btn-danger {
            background-color: #e74c3c;
            border-color: #e74c3c;
        }
        .btn-danger:hover {
            background-color: #c0392b;
            border-color: #c0392b;
        }
        .alert {
            background-color: #495057;
            border-color: #343a40;
            color: #f8f9fa;
        }
        .alert-success {
            background-color: #27ae60;
            border-color: #219a52;
        }
        .text-muted {
            color: #adb5bd !important;
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/user">
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
                <h1 class="h2">User Management</h1>
                <c:if test="${sessionScope.loggedUser.role == 'admin'}">
                    <a href="user?action=add" class="btn btn-primary">
                        <i class="fas fa-user-plus me-2"></i> Add New User
                    </a>
                </c:if>
            </div>

            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>User ID</th>
                                <th>Username</th>
                                <th>Role</th>
                                <c:if test="${sessionScope.loggedUser.role == 'admin'}">
                                    <th>Actions</th>
                                </c:if>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>${user.userId}</td>
                                    <td>${user.username}</td>
                                    <td>
                                                <span class="badge bg-${user.role eq 'admin' ? 'danger' : 'info'}">
                                                        ${user.role}
                                                </span>
                                    </td>
                                    <c:if test="${sessionScope.loggedUser.role == 'admin' && user.role != 'admin'}">
                                        <td>
                                            <a href="user?action=edit&id=${user.userId}" class="btn btn-primary btn-sm me-2">
                                                <i class="fas fa-edit me-1"></i> Edit
                                            </a>
                                            <form action="user" method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="userId" value="${user.userId}">
                                                <button type="submit" class="btn btn-danger btn-sm"
                                                        onclick="return confirm('Are you sure you want to delete this user?')">
                                                    <i class="fas fa-trash me-1"></i> Delete
                                                </button>
                                            </form>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <c:if test="${empty users}">
                        <div class="text-center p-5">
                            <i class="fas fa-users display-1 text-muted"></i>
                            <h3 class="mt-3">No Users Found</h3>
                            <p class="text-muted">There are no users in the system.</p>
                            <c:if test="${sessionScope.loggedUser.role == 'admin'}">
                                <a href="user?action=add" class="btn btn-primary mt-3">
                                    <i class="fas fa-user-plus me-2"></i> Add New User
                                </a>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
