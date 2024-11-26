<%@ page import="java.util.Map" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Cart - RevShop</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin-top: 20px;
            color: black;
        }

        .cart-container {
            width: 80%;
            margin: auto;
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #e0e0e0;
        }

        img {
            width: 100px;
            height: auto;
        }

        .total {
            font-size: 20px;
            font-weight: bold;
            margin-top: 20px;
            text-align: right;
        }

        .checkout-button {
            display: block;
            width: 150px;
            margin: 20px auto;
            padding: 10px;
            background-color: #28a745;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
        }

        .checkout-button:hover {
            opacity: 0.8;
        }

        .remove-button {
            background-color: #dc3545;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .remove-button:hover {
            opacity: 0.8;
        }
    </style>
<body>
    <h1>Your Shopping Cart</h1>

    <div class="cart-container">
        <%
            // Get the cart from the session
            Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
            double totalAmount = 0.0;

            if (cart == null || cart.isEmpty()) {
        %>
            <p>Your cart is empty.</p>
        <%
            } else {
        %>
            <table>
                <tr>
                    <th>Product Image</th>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
                <%
                String DB_URL = "jdbc:mysql://localhost:3306/revshop";
                String DB_USER = "root";
                String DB_PASSWORD = "root";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                    for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                        int productId = entry.getKey();
                        int quantity = entry.getValue();

                        String sql = "SELECT name, price, image_url FROM products WHERE id = ?";
                        PreparedStatement preparedStatement = connection.prepareStatement(sql);
                        preparedStatement.setInt(1, productId);
                        ResultSet resultSet = preparedStatement.executeQuery();

                        if (resultSet.next()) {
                            String productName = resultSet.getString("name");
                            double price = resultSet.getDouble("price");
                            String imageUrl = resultSet.getString("image_url");
                            double totalPrice = price * quantity;
                            totalAmount += totalPrice;
                %>

                <tr>
                    <td><img src="<%= imageUrl %>" alt="<%= productName %>"></td>
                    <td><%= productName %></td>
                    <td>₹<%= String.format("%.2f", price) %></td>
                    <td><%= quantity %></td>
                    <td>₹<%= String.format("%.2f", totalPrice) %></td>
                    <td>
                        <form action="RemoveFromCartServlet" method="post">
                            <input type="hidden" name="productId" value="<%= productId %>">
                            <button type="submit" class="remove-button">Remove</button>
                        </form>
                    </td>
                </tr>

                <%
                        }
                        resultSet.close();
                        preparedStatement.close();
                    }

                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </table>

            <div class="total">Total Amount: ₹<%= String.format("%.2f", totalAmount) %></div>

            <!-- Proceed to Checkout form -->
            <form action="checkout.jsp" method="post">
                <input type="hidden" name="totalAmount" value="<%= totalAmount %>">
                <button type="submit" class="checkout-button">Proceed to Checkout</button>
            </form>

        <%
            }
        %>
    </div>

</body>
</html>
    