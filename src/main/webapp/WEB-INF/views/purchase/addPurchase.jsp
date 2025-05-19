<%--
  Created by IntelliJ IDEA.
  User: Hasanthi
  Date: 5/19/2025
  Time: 10:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Purchase - InventaX</title>
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
        .form-control::placeholder,
        .form-select {
            color: #adb5bd;
        }
        /* Ensure dropdown options are visible */
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
        .input-group-text {
            background-color: #868e96;
            border: 1px solid #868e96;
            color: #f8f9fa;
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
                        <a class="nav-link active" href="purchases?action=list"> <%-- Active Link --%>
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
                <h2 class="h2">Add New Purchase</h2>
                <a href="purchases?action=list" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-1"></i> Back to List
                </a>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-shopping-cart me-2"></i> Purchase Details</h5>
                        </div>
                        <div class="card-body p-4">
                            <form action="purchases" method="post">
                                <input type="hidden" name="action" value="add">

                                <div class="mb-3">
                                    <label for="purchaseId" class="form-label">Purchase ID</label>
                                    <input type="text" class="form-control" id="purchaseId" name="purchaseId" required>
                                    <div class="form-text">A unique identifier for the purchase (e.g., P001).</div>
                                </div>

                                <div class="mb-3">
                                    <label for="itemId" class="form-label">Item</label>
                                    <select class="form-select" id="itemId" name="itemId" required>
                                        <option value="" selected disabled>Select an item</option>
                                        <c:forEach items="${items}" var="item">
                                            <option value="${item.itemId}">${item.itemName} (ID: ${item.itemId})</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label for="quantity" class="form-label">Quantity</label>
                                    <input type="number" class="form-control" id="quantity" name="quantity" min="1" required>
                                </div>

                                <div class="mb-3">
                                    <label for="supplierId" class="form-label">Supplier</label>
                                    <select class="form-select" id="supplierId" name="supplierId" required>
                                        <option value="" selected disabled>Select a supplier</option>
                                        <c:forEach items="${suppliers}" var="supplier">
                                            <option value="${supplier.supplierId}">${supplier.name} (ID: ${supplier.supplierId})</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label for="status" class="form-label">Status</label>
                                    <select class="form-select" id="status" name="status" required>
                                        <option value="" selected disabled>Select status</option>
                                        <option value="Pending">Pending</option>
                                        <option value="Ordered">Ordered</option>
                                        <option value="Received">Received</option>
                                        <option value="Cancelled">Cancelled</option>
                                    </select>
                                    <div class="form-text">Current status of the purchase order.</div>
                                </div>

                                <div class="mb-3">
                                    <label for="purchaseDate" class="form-label">Purchase Date</label>
                                    <input type="date" class="form-control" id="purchaseDate" name="purchaseDate" required>
                                </div>

                                <%-- Removed Total Amount, Payment Status, Notes as they might not be in PurchaseOrder model --%>
                                <%-- If they are in the model, uncomment and ensure names match --%>
                                <%--
                                <div class="mb-3">
                                    <label for="totalAmount" class="form-label">Total Amount</label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="number" class="form-control" id="totalAmount" name="totalAmount" step="0.01" min="0" required>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="paymentStatus" class="form-label">Payment Status</label>
                                    <select class="form-select" id="paymentStatus" name="paymentStatus" required>
                                        <option value="pending" selected>Pending</option>
                                        <option value="paid">Paid</option>
                                        <option value="cancelled">Cancelled</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label for="notes" class="form-label">Notes</label>
                                    <textarea class="form-control" id="notes" name="notes" rows="3"></textarea>
                                </div>
                                --%>

                                <div class="d-flex justify-content-end mt-4">
                                    <a href="purchases?action=list" class="btn btn-secondary me-2">Cancel</a>
                                    <button type="submit" class="btn btn-primary"><i class="fas fa-save me-1"></i> Add Purchase</button>
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
