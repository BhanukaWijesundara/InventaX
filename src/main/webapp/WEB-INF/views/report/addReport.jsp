<%--
  Created by IntelliJ IDEA.
  User: Shehan
  Date: 5/21/2025
  Time: 7:03 PM
  To change this template use File | Settings | File Templates.
--%>
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
    .form-control {
      background-color: #343a40;
      border-color: #454d55;
      color: #f8f9fa;
    }
    .form-control:focus {
      background-color: #343a40;
      border-color: #2980b9;
      color: #f8f9fa;
      box-shadow: 0 0 0 0.25rem rgba(41, 128, 185, 0.25);
    }
    .form-label {
      color: #f8f9fa;
    }
    .form-select {
      background-color: #343a40;
      border-color: #454d55;
      color: #f8f9fa;
    }
    .form-select:focus {
      background-color: #343a40;
      border-color: #2980b9;
      color: #f8f9fa;
      box-shadow: 0 0 0 0.25rem rgba(41, 128, 185, 0.25);
    }
    .btn-primary {
      background-color: #2980b9;
      border-color: #2980b9;
    }
    .btn-primary:hover {
      background-color: #2471a3;
      border-color: #2471a3;
    }
    .btn-secondary {
      background-color: #6c757d;
      border-color: #6c757d;
    }
    .btn-secondary:hover {
      background-color: #5a6268;
      border-color: #545b62;
    }
    .alert {
      background-color: #495057;
      border-color: #343a40;
      color: #f8f9fa;
    }
    .alert-danger {
      background-color: #e74c3c;
      border-color: #c0392b;
    }
    .border-bottom {
      border-color: #454d55 !important;
    }
    h1.h2, h6.m-0 {
      color: #f8f9fa;
    }
  </style>
</head>
