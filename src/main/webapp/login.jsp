<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 4/2/2025
  Time: 3:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - InventaX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #343a40; /* Dark background */
            color: #f8f9fa; /* Light text */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px; /* Add padding for smaller screens */
        }
        .login-container {
            max-width: 500px;
            width: 100%;
        }
        .login-card {
            background-color: #495057; /* Darker card background */
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            overflow: hidden; /* Ensure child elements conform to border radius */
        }
        .login-card .card-header {
            background-color: transparent; /* Remove header background */
            border-bottom: 1px solid #6c757d; /* Lighter border for tabs */
            padding: 0; /* Remove padding to allow tabs to fill */
        }
        .login-card .nav-tabs {
            border-bottom: none; /* Remove default tab border */
        }
        .login-card .nav-tabs .nav-link {
            color: #adb5bd; /* Lighter text for inactive tabs */
            border: none;
            border-radius: 0; /* Remove individual tab radius */
            padding: 1rem 1.5rem; /* Adjust tab padding */
            border-bottom: 3px solid transparent;
            text-align: center;
            flex-grow: 1; /* Make tabs share space */
        }
        .login-card .nav-tabs .nav-item {
            flex-grow: 1; /* Ensure nav items share space */
        }
        .login-card .nav-tabs .nav-link.active {
            color: #f8f9fa; /* White text for active tab */
            background-color: transparent;
            border-bottom: 3px solid #0d6efd; /* Blue indicator for active tab */
        }
        .login-card .form-label {
            color: #adb5bd; /* Lighter label text */
        }
        .login-card .form-control {
            background-color: #6c757d; /* Darker input background */
            color: #f8f9fa; /* Light input text */
            border: 1px solid #868e96;
        }
        .login-card .form-control::placeholder {
            color: #adb5bd;
        }
        .login-card .form-control:focus {
            background-color: #6c757d;
            color: #f8f9fa;
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        .login-card .alert {
            border-radius: 5px;
            margin-bottom: 1rem; /* Add space below alerts */
        }
        .site-title {
            font-size: 2.5rem;
            font-weight: bold;
            color: #f8f9fa;
            text-align: center;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        .btn-primary {
            background-color: #0d6efd; /* Standard Bootstrap primary */
            border-color: #0d6efd;
        }
        .btn-success {
            background-color: #198754; /* Standard Bootstrap success */
            border-color: #198754;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h1 class="site-title"> <i class="fas fa-box-open me-2"></i> InventaX</h1>
    <div class="card login-card">
        <div class="card-header">
            <ul class="nav nav-tabs card-header-tabs" id="loginRegisterTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link active" id="login-tab" data-bs-toggle="tab" href="#login" role="tab" aria-controls="login" aria-selected="true">Login</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="register-tab" data-bs-toggle="tab" href="#register" role="tab" aria-controls="register" aria-selected="false">Register</a>
                </li>
            </ul>
        </div>
        <div class="card-body p-4">
            <div class="tab-content" id="loginRegisterTabContent">
                <!-- Login Form -->
                <div class="tab-pane fade show active" id="login" role="tabpanel" aria-labelledby="login-tab">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>
                    <form action="login" method="post">
                        <%-- Assuming LoginServlet handles the login action --%>
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-primary btn-lg">Login</button>
                        </div>
                    </form>
                </div>

                <!-- Registration Form -->
                <div class="tab-pane fade" id="register" role="tabpanel" aria-labelledby="register-tab">
                    <c:if test="${not empty registerError}">
                        <div class="alert alert-danger">${registerError}</div>
                    </c:if>
                    <form action="register" method="post" onsubmit="return validateForm()">
                        <%-- Assuming RegisterServlet handles the registration --%>
                        <div class="mb-3">
                            <label for="reg-userId" class="form-label">User ID</label>
                            <input type="text" class="form-control" id="reg-userId" name="userId" required>
                        </div>
                        <div class="mb-3">
                            <label for="reg-username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="reg-username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="reg-password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="reg-password" name="password" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirm-password" class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" id="confirm-password" name="confirmPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <%-- Role selection can be added here if needed --%>
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-success btn-lg">Register</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function validateForm() {
        var password = document.getElementById("reg-password").value;
        var confirmPassword = document.getElementById("confirm-password").value;

        if (password !== confirmPassword) {
            alert("Passwords do not match!");
            document.getElementById("reg-password").focus(); // Focus on password field
            return false;
        }
        // Basic email format validation
        var email = document.getElementById("email").value;
        var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(email)) {
            alert("Please enter a valid email address.");
            document.getElementById("email").focus(); // Focus on email field
            return false;
        }
        return true;
    }

    // Ensure the correct tab stays active on validation errors/refresh
    document.addEventListener('DOMContentLoaded', function() {
        var hash = window.location.hash; // Check if URL hash indicates a tab
        var activeTabId = localStorage.getItem('activeLoginTab'); // Check local storage

        // Determine which tab to activate
        var targetTabTriggerEl = null;
        if (hash === '#register') {
            targetTabTriggerEl = document.querySelector('#register-tab');
        } else if (hash === '#login') {
            targetTabTriggerEl = document.querySelector('#login-tab');
        } else if (activeTabId) {
            targetTabTriggerEl = document.querySelector('#' + activeTabId + '-tab');
        } else {
            targetTabTriggerEl = document.querySelector('#login-tab'); // Default to login
        }

        if (targetTabTriggerEl) {
            var tab = new bootstrap.Tab(targetTabTriggerEl);
            tab.show();
        }

        // Save active tab to local storage on change
        var tabTriggerList = document.querySelectorAll('#loginRegisterTab a[data-bs-toggle="tab"]');
        tabTriggerList.forEach(function(tabTriggerEl) {
            tabTriggerEl.addEventListener('shown.bs.tab', function(event) {
                var tabId = event.target.id.replace('-tab', '');
                localStorage.setItem('activeLoginTab', tabId);
                // Update URL hash without reloading page
                history.replaceState(null, null, '#' + tabId);
            });
        });

        // Clear local storage if user successfully logs in or registers
        // This should ideally be triggered by server-side logic after successful auth
        // e.g., if(loginSuccess) localStorage.removeItem('activeLoginTab');
        // For demonstration, we can clear it if there are no error messages shown
        var loginError = document.querySelector('#login .alert-danger');
        var registerError = document.querySelector('#register .alert-danger');
        if (!loginError && !registerError) { // If no errors are currently displayed
            // Check if coming from a successful action (optional, needs server cooperation)
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('success')) {
                localStorage.removeItem('activeLoginTab');
                // Optionally redirect to dashboard or clear the success param
                // window.location.href = 'dashboard';
            }
        }
    });
</script>
</body>
</html>

