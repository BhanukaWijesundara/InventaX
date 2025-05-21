<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Item - InventaX</title>
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
        /* Style date input text color */
        .form-control[type="date"] {
            color: #f8f9fa;
        }
        /* Style date input icon color */
        .form-control[type="date"]::-webkit-calendar-picker-indicator {
            filter: invert(1);
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
        h2 {
            color: #f8f9fa;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
            <div class="position-sticky pt-3">
                <h4 class="text-center mb-3">InventaX</h4>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard">
                            <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="inventory?action=list">
                            <i class="fas fa-boxes me-2"></i>Inventory
                        </a>
                    </li>
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

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 main-content">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-4 border-bottom border-secondary">
                <h2 class="h2">Add New Item</h2>
                <a href="inventory?action=list" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-1"></i> Back to List
                </a>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-box me-2"></i> Item Details</h5>
                        </div>
                        <div class="card-body p-4">
                            <form action="inventory" method="post">
                                <input type="hidden" name="action" value="add">

                                <div class="mb-3">
                                    <label for="itemId" class="form-label">Item ID</label>
                                    <input type="text" class="form-control" id="itemId" name="itemId" required>
                                    <div class="form-text">Enter a unique identifier for this item</div>
                                </div>

                                <div class="mb-3">
                                    <label for="itemName" class="form-label">Item Name</label>
                                    <input type="text" class="form-control" id="itemName" name="itemName" required>
                                </div>

                                <div class="mb-3">
                                    <label for="quantity" class="form-label">Quantity</label>
                                    <input type="number" class="form-control" id="quantity" name="quantity" min="0" required>
                                </div>

                                <div class="mb-3">
                                    <label for="expiryDate" class="form-label">Expiry Date</label>
                                    <input type="date" class="form-control" id="expiryDate" name="expiryDate">
                                    <div class="form-text">Optional. Leave blank if not applicable.</div>
                                </div>

                                <div class="mb-3">
                                    <label for="category" class="form-label">Category</label>
                                    <%-- Assuming you pass categories from the servlet, otherwise use text input --%>
                                    <select class="form-select" id="category" name="category">
                                        <option value="" selected>Select a category</option>
                                        <%-- Example Categories - Replace with dynamic list if available --%>
                                        <option value="Books">Books</option>
                                        <option value="Electronics">Electronics</option>
                                        <option value="Clothing">Clothing</option>
                                        <option value="Groceries">Groceries</option>
                                        <option value="Other">Other</option>
                                        <%--
                                        <c:forEach items="${categories}" var="cat">
                                            <option value="${cat}">${cat}</option>
                                        </c:forEach>
                                        --%>
                                    </select>
                                    <%-- Fallback to text input if categories aren't predefined --%>
                                    <%-- <input type="text" class="form-control" id="category" name="category"> --%>
                                </div>

                                <%-- Add any other necessary fields for InventoryItem here --%>

                                <div class="d-flex justify-content-end mt-4">
                                    <a href="inventory?action=list" class="btn btn-secondary me-2">Cancel</a>
                                    <button type="submit" class="btn btn-primary"><i class="fas fa-plus me-1"></i> Add Item</button>
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
