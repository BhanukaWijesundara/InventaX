<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.InventoryItem" %>
<%
  List<InventoryItem> report = (List<InventoryItem>) request.getAttribute("report");
%>
<html>
<head><title>Expiry Report</title></head>
<body>
<h2>Sorted Inventory by Expiry Date</h2>
<table border="1">
  <tr><th>ID</th><th>Name</th><th>Qty</th><th>Expiry</th><th>Category</th></tr>
  <% for (InventoryItem i : report) { %>
  <tr>
    <td><%= i.getItemId() %></td>
    <td><%= i.getItemName() %></td>
    <td><%= i.getQuantity() %></td>
    <td><%= i.getExpiryDate() %></td>
    <td><%= i.getCategory() %></td>
  </tr>
  <% } %>
</table>
</body>
</html>