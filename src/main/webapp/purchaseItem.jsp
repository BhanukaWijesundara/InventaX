<%--
  Created by IntelliJ IDEA.
  User: Hasanthi
  Date: 5/19/2025
  Time: 10:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Add Purchase Order</title></head>
<body>
<h2>Add Purchase</h2>
<form action="purchases" method="post">
  <label>Purchase ID:</label><input type="text" name="purchaseId" /><br/>
  <label>Item ID:</label><input type="text" name="itemId" /><br/>
  <label>Quantity:</label><input type="number" name="quantity" /><br/>
  <label>Date (YYYY-MM-DD):</label><input type="text" name="date" /><br/>
  <label>Supplier ID:</label><input type="text" name="supplierId" /><br/>
  <button type="submit">Add Purchase</button>
</form>
</body>
