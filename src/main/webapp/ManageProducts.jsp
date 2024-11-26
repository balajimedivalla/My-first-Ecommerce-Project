<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        h1 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
        }
        .button:hover {
            background-color: #0056b3;
        }
        /* Adjusted column widths */
        .name-column {
            width: 50px;
        }
        .description-column {
            width: 150px;
        }
        .actions-column {
            width: 350px;
        }
        /* Form styles */
        .action-form {
            display: flex;
            flex-direction: column;
            gap: 5px;
            align-items: stretch;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            background-color: white;
        }
        .action-form input {
            width: 100%;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>

<h1>Manage Products</h1>

<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th class="description-column">Description</th>
        <th>Price</th>
        <th>Stock</th>
        <th>Image URL</th>
        <th class="actions-column">Actions</th>
    </tr>
    <%
        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/revshop"; // Update with your DB name
        String user = "root"; // Replace with your DB username
        String password = "root"; // Replace with your DB password

        Connection conn = null;
        Statement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            stmt = conn.createStatement();
            String sql = "SELECT * FROM products"; // Replace with your products table name
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                int stock = rs.getInt("stock");
                String imageUrl = rs.getString("image_url");
    %>
                <tr>
                    <td><%= id %></td>
                    <td><%= name %></td>
                    <td><%= description %></td>
                    <td><%= price %></td>
                    <td><%= stock > 0 ? "In Stock" : "Out of Stock" %></td>
                    <td><img src="<%= imageUrl %>" alt="<%= name %>" style="width: 50px; height: 50px;"></td>
                    <td>
                        <!-- Update Product Form -->
                        <form class="action-form" method="post" action="UpdateProduct">
                            <input type="hidden" name="id" value="<%= id %>">
                            
                            <label for="name">Product Name</label>
                            <input type="text" id="name" name="name" value="<%= name %>" required>
                            
                            <label for="description">Description</label>
                            <input type="text" id="description" name="description" value="<%= description %>" required>
                            
                            <label for="price">Price</label>
                            <input type="number" id="price" name="price" value="<%= price %>" step="0.01" required>
                            
                            <label for="stock">Stock</label>
                            <input type="number" id="stock" name="stock" value="<%= stock %>" required>
                            
                            <label for="imageUrl">Image URL</label>
                            <input type="text" id="imageUrl" name="imageUrl" value="<%= imageUrl %>" required>
                            
                            <div class="action-buttons">
                                <button type="submit" class="button">Update Product</button>
                            </div>
                        </form>
                        
                        <!-- Delete Product Form -->
                        <form method="post" action="DeleteProduct" style="display:inline;">
                            <input type="hidden" name="id" value="<%= id %>">
                            <button type="submit" class="button" onclick="return confirm('Are you sure you want to delete this product?');">Delete</button>
                        </form>
                    </td>
                </tr>
    <%
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    %>
</table>

</body>
</html>
