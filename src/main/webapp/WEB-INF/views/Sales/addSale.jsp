<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 5/21/2025
  Time: 10:23 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Sale - InventaX</title>
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
            border-radius: 8px;
        }
        .card-header {
            background-color: #5a6268;
            border-bottom: 1px solid #6c757d;
            color: #f8f9fa;
        }
        .form-control, .form-select {
            background-color: #6c757d;
            border-color: #868e96;
            color: #f8f9fa;
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
        .border-bottom {
            border-color: #454d55 !important;
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/sales">
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
                <h1 class="h2">Edit Sale</h1>
                <a href="sales?action=list" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to List
                </a>
            </div>

            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-edit me-2"></i>Edit Sale Details</h5>
                </div>
                <div class="card-body p-4">
                    <form action="sales" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="salesId" value="${sale.salesId}">

                        <div class="mb-3">
                            <label for="itemId" class="form-label">Item</label>
                            <select class="form-select" id="itemId" name="itemId" required>
                                <option value="">Select an item</option>
                                <c:forEach items="${items}" var="item">
                                    <option value="${item.itemId}" ${item.itemId == sale.itemId ? 'selected' : ''}>
                                            ${item.itemName} (ID: ${item.itemId})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="quantity" class="form-label">Quantity</label>
                            <input type="number" class="form-control" id="quantity" name="quantity" min="1" value="${sale.quantity}" required>
                        </div>

                        <div class="mb-3">
                            <label for="totalAmount" class="form-label">Total Amount</label>
                            <input type="number" step="0.01" class="form-control" id="totalAmount" name="totalAmount" value="${sale.totalAmount}" required>
                        </div>

                        <div class="mb-3">
                            <label for="customerName" class="form-label">Customer Name</label>
                            <input type="text" class="form-control" id="customerName" name="customerName" value="${sale.customerName}" required>
                        </div>

                        <div class="mb-3">
                            <label for="paymentStatus" class="form-label">Payment Status</label>
                            <select class="form-select" id="paymentStatus" name="paymentStatus" required>
                                <option value="pending" ${sale.paymentStatus == 'pending' ? 'selected' : ''}>Pending</option>
                                <option value="completed" ${sale.paymentStatus == 'completed' ? 'selected' : ''}>Completed</option>
                            </select>
                        </div>

                        <div class="d-flex justify-content-end mt-4">
                            <a href="sales?action=list" class="btn btn-secondary me-2">Cancel</a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 