<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/22/2025
  Time: 12:55 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Add Item</title></head>
<body>
<h2>Add Inventory Item</h2>
<form action="inventory" method="post">
    <label>Item ID:</label><input type="text" name="itemId" /><br/>
    <label>Name:</label><input type="text" name="itemName" /><br/>
    <label>Quantity:</label><input type="number" name="quantity" /><br/>
    <label>Expiry Date (YYYY-MM-DD):</label><input type="text" name="expiryDate" /><br/>
    <label>Category:</label><input type="text" name="category" /><br/>
    <button type="submit">Add Item</button>
</form>
</body>
</html>
